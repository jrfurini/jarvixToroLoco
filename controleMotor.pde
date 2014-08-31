/*
  Controle direção de robos oferecendo um conjunto de funções para facilitar a interface com sensores.

 criado em 05 de julho de 2010
 por Junior Furini

*/

/*
	Tabela de movimento a partir de pin 0 e pin 1:

		Quando pin 1 é diferente de -1 usamos as duas portas para controle de direção.
			+--------+------+------+
			| Pino   |   0  |   1  |
			+--------+------+------+
			| Frente | HIGH | LOW  |
			+--------+------+------+
			| Traz   | LOW  | HIGH |
			+--------+------+------+
			| Stop   | HIGH | HIGH |
			+--------+------+------+
			| Stop   | LOW  | LOW  |
			+--------+------+------+

		Quando pin 1 igual -1 só usamos a porta 0 para controle de direção.
			+--------+------+------+
			| Pino   |   0  |   1  |
			+--------+------+------+
			| Frente | HIGH |      | -- NÃO TEMOS STOP NESTA CONFIGURAÇÃO.
			+--------+------+------+ -- A lógica prevê freio lógico invertendo por microsegundos o motor antes de parar.
			| Traz   | LOW  |      |
			+--------+------+------+
*/

#define MAX_MOTOR 2
struct	{
	int	 pinInput_1
		,pinInput_2
		,pinPWM
		,direcao
		,velocidade
		,velocidadeDestino
		,fatorCompen
		,idComandoAjusteVel
		;
	}
	Motor[ MAX_MOTOR ];

int qtdeMotor		=	-1;

//direcaoPadrao
	#define parado		0
	#define frente		1
	#define traz		2
	#define direita		3
	#define esquerda	4

int incluirMotor	(
			 int pPinPWM
			,int pPinIN1
			,int pPinIN2
			,int pFatorCompensacao
			) {
	qtdeMotor++;
	if ( qtdeMotor <= ( MAX_MOTOR -1 ) ) {
		Motor[ qtdeMotor ].pinPWM			=	pPinPWM;
		Motor[ qtdeMotor ].pinInput_1			=	pPinIN1;
		Motor[ qtdeMotor ].pinInput_2			=	pPinIN2;
		Motor[ qtdeMotor ].fatorCompen			=	pFatorCompensacao;
		Motor[ qtdeMotor ].idComandoAjusteVel		=	incluirComando( getTempoAltVeloc() );

		//mostrarTexto( "Incluido o motor [" );
		//mostrarTexto( qtdeMotor );
		//mostrarTexto( "] ", true );

		pinMode( Motor[ qtdeMotor ].pinPWM, OUTPUT );
		digitalWrite( Motor[ qtdeMotor ].pinPWM, LOW );
		//mostrarTexto( "    Porta [" );
		//mostrarTexto( Motor[ qtdeMotor ].pinPWM );
		//mostrarTexto( "] PWM ativada.", true );

		// Abre portas para de saida.
		pinMode( Motor[ qtdeMotor ].pinInput_1, OUTPUT );
		digitalWrite( Motor[ qtdeMotor ].pinInput_1, LOW );
		//mostrarTexto( "    Porta [" );
		//mostrarTexto( Motor[ qtdeMotor ].pinInput_1 );
		//mostrarTexto( "] Input 1 ativada.", true );

		// Estando -1 nesta porta não ativamos, temos um transistor ajudando na direção do motor.
		if ( Motor[ qtdeMotor ].pinInput_2 != NONE ) {
			pinMode( Motor[ qtdeMotor ].pinInput_2, OUTPUT );
			digitalWrite( Motor[ qtdeMotor ].pinInput_2, LOW );
			//mostrarTexto( "    Porta [" );
			//mostrarTexto( Motor[ qtdeMotor ].pinInput_2 );
			//mostrarTexto( "] Input 2 ativada.", true );
		}

		// Inicializa variavel.
		Motor[ qtdeMotor ].direcao			=	getDirecaoParado();
		Motor[ qtdeMotor ].velocidade			=	0;
		//mostrarTexto( "		Variaveis inicializadas.", true );

		direcionarFrente( qtdeMotor );

		return( qtdeMotor );
	}
	else {
		return NONE;
	}
}

// Calcula o valor numerico da velocidade a partir do % indicado.
int perc2Velocidade( int pPerc ) {
	int vPerc		=	min( pPerc, 100 );
	vPerc			=	max( vPerc, 0 );

	return( ( ( ( getVelocidadeMax() - getVelocidadeMin() ) * vPerc ) / 100 ) + getVelocidadeMin() );
}

int velocidade2Perc( int pVelocidade ) {
	int vVelocidade	=	min( pVelocidade, getVelocidadeMax() );
										// Ajuste para o MAP abaixo
	vVelocidade		=	max( vVelocidade, getVelocidadeMin() ) + 1;

	return( map( vVelocidade, getVelocidadeMin(), getVelocidadeMax(), 0, 100 ) );
}

void direcionarFrente( int pMotor ) {
	if ( pMotor != NONE ) {
		//mostrarTexto( "Direcionando Motor [" );
		//mostrarTexto( pMotor );
		//mostrarTexto( "] para frente. 1 H 2 L", true );

		digitalWrite( Motor[ pMotor ].pinInput_1, HIGH );
		if ( Motor[ pMotor ].pinInput_2 != NONE ) {
			digitalWrite( Motor[ pMotor ].pinInput_2, LOW );
		}
		Motor[ pMotor ].direcao		=	getDirecaoFrente();
	}
}

void direcionarTraz( int pMotor ) {
	if ( pMotor != NONE ) {
		//mostrarTexto( "Direcionando Motor [" );
		//mostrarTexto( pMotor );
		//mostrarTexto( "] para traz. 1 L 2 H", true );

		digitalWrite( Motor[ pMotor ].pinInput_1, LOW );
		if ( Motor[ pMotor ].pinInput_2 != NONE ) {
			digitalWrite( Motor[ pMotor ].pinInput_2, HIGH );
		}
		Motor[ pMotor ].direcao		=	getDirecaoTraz();
	}
}

void registrarVelocidade(
			 int pMotor
			,int pVelocidade
			) {
	// Acelera o motor indicado.
	int velocidadeDestinoTmp			=	0;

	// Determina velocidade destino.
	if ( pVelocidade == NONE ) { // ir ao máximo
		velocidadeDestinoTmp			=	getVelocidadeMax();
	}
	else { // velocidade indicada
		velocidadeDestinoTmp			=	pVelocidade;
	}

	// Limita acelerar até a velocidade máxima
	if ( velocidadeDestinoTmp > getVelocidadeMax() ) {
		velocidadeDestinoTmp			=	getVelocidadeMax();
	}

	// Limita desacelerar até a velocidade mínima
	if ( velocidadeDestinoTmp < getVelocidadeMin() ) {
		velocidadeDestinoTmp			=	getVelocidadeMin();
	}

	if ( Motor[ pMotor ].velocidade != velocidadeDestinoTmp ) {
		Motor[ pMotor ].velocidadeDestino	=	velocidadeDestinoTmp;
	}

	// Se vamos ao minimo entao freamos o motor.
	if ( velocidadeDestinoTmp == getVelocidadeMin() ) {
		frearMotor( pMotor );
	}
}

void frearMotor( int pMotor ) {
	//mostrarTexto( "Freando motor [" );
	//mostrarTexto( pMotor );
	//mostrarTexto( "].", true );

	digitalWrite( Motor[ pMotor ].pinInput_1, LOW );
	if ( Motor[ pMotor ].pinInput_2 != NONE ) {
		digitalWrite( Motor[ pMotor ].pinInput_2, LOW );
	}
	analogWrite( Motor[ pMotor ].pinPWM, LOW );

	Motor[ pMotor ].velocidade		=	0;
}

boolean motoresAjustados() {
	boolean retorno = true;
	
	for( int i = 0; i <= qtdeMotor; i++ )  {
		if ( Motor[ i ].velocidade != Motor[ i ].velocidadeDestino ) {
			retorno = false;
		}
	}
	return retorno;
}

void ajustarVelocidade( int pMotor ) {
	//mostrarTexto( "Motor [" );
	//mostrarTexto( pMotor );
	//mostrarTexto( "] Vel [" );
	//mostrarTexto( Motor[ pMotor ].velocidade );
	//mostrarTexto( "] Dest [" );
	//mostrarTexto( Motor[ pMotor ].velocidadeDestino );
	//mostrarTexto( "]", true );

	if ( podeExecutarComando( Motor[ pMotor ].idComandoAjusteVel, ( Motor[ pMotor ].velocidade != Motor[ pMotor ].velocidadeDestino ) ) ) {
		// Se um dos motores estiver parado, acionamos ambos na potência máxima por 400ms para que ele consiga sair da inércia e o motor comece a rodar.
/*
		if ( Motor[ pMotor ].velocidade <= getVelocidadeMin() &&
		     Motor[ pMotor ].velocidadeDestino > getVelocidadeMin()
		   ) {
			//mostrarTexto( "Pico inercial.", true );
			analogWrite( Motor[ pMotor ].pinPWM, getVelocidadeMax() );
			delay( 400 );
			analogWrite( Motor[ pMotor ].pinPWM, Motor[ pMotor ].velocidade );
		}
*/
		// Aumentar velocidade
		if ( Motor[ pMotor ].velocidade < Motor[ pMotor ].velocidadeDestino ) {
			//mostrarTexto( "Acelerando Motor [" );
			//mostrarTexto( pMotor );
			//mostrarTexto( "] de [" );
			//mostrarTexto( Motor[ pMotor ].velocidade );
			//mostrarTexto( "] ate [" );
			//mostrarTexto( Motor[ pMotor ].velocidadeDestino );
			//mostrarTexto( "] velocidade [" );

			Motor[ pMotor ].velocidade += getFatorAltVeloc();
			if ( Motor[ pMotor ].velocidade >= Motor[ pMotor ].velocidadeDestino ) {
				Motor[ pMotor ].velocidade	=	Motor[ pMotor ].velocidadeDestino;
				desativarComando( Motor[ pMotor ].idComandoAjusteVel );
			}
		}
		// Diminuir velocidade
		else {
			//mostrarTexto( "Desacelerando Motor [" );
			//mostrarTexto( pMotor );
			//mostrarTexto( "] de [" );
			//mostrarTexto( Motor[ pMotor ].velocidade );
			//mostrarTexto( "] ate [" );
			//mostrarTexto( Motor[ pMotor ].velocidadeDestino );
			//mostrarTexto( "] velocidade [" );

			Motor[ pMotor ].velocidade -= getFatorAltVeloc();
			if ( Motor[ pMotor ].velocidade <= Motor[ pMotor ].velocidadeDestino ) {
				Motor[ pMotor ].velocidade	=	Motor[ pMotor ].velocidadeDestino;
				desativarComando( Motor[ pMotor ].idComandoAjusteVel );
			}
		}
		analogWrite( Motor[ pMotor ].pinPWM, Motor[ pMotor ].velocidade );
		//mostrarTexto( Motor[ pMotor ].velocidade );
		//mostrarTexto( "]", true );

		if ( Motor[ pMotor ].velocidade <= getVelocidadeMin() ) {
			Motor[ pMotor ].velocidade		=	0;
			analogWrite( Motor[ pMotor ].pinPWM, LOW ); // Zera a PWM
			//mostrarTexto( "Motores freados.", true );
		}
	}
}

void estadoMotores() {
	//mostrarTexto( "Estado dos Motores", true );
	for ( int i = 0; i < qtdeMotor; i++ ) {
		//mostrarTexto( "	Motor [" );
		//mostrarTexto( i );
		//mostrarTexto( "] Velocidade [" );
		//mostrarTexto( Motor[ i ].velocidade );
		//mostrarTexto( "] Direcao [" );
		//mostrarTexto( Motor[ i ].direcao );
		//mostrarTexto( "]", true );
	}
}

int getQtdeMotor() {
	return qtdeMotor;
}

int getDirecaoParado() {
	return parado;
}

int getDirecaoFrente() {
	return frente;
}

int getDirecaoTraz() {
	return traz;
}

int getDirecaoDireita() {
	return direita;
}

int getDirecaoEsquerda() {
	return esquerda;
}

int getComandoEsquerda() {
	return Motor[ getMotorEsquerda() ].idComandoAjusteVel;
}
int getComandoDireita() {
	return Motor[ getMotorDireita() ].idComandoAjusteVel;
}

int getVelocidadeEsquerda() {
	return Motor[ getMotorEsquerda() ].velocidade;
}
int getVelocidadeDireita() {
	return Motor[ getMotorDireita() ].velocidade;
}

int getVelocidadeEsquerdaDest() {
	return Motor[ getMotorEsquerda() ].velocidadeDestino;
}
int getVelocidadeDireitaDest() {
	return Motor[ getMotorDireita() ].velocidadeDestino;
}

