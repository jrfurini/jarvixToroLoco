#include <Servo.h>
#define NONE			255

/*
	Tabela de registro dos sensores.
*/
//direcaoLeitura
	#define ascendente	0
	#define descendente	1
//tipoSensor
	#define sensorPING		0
	#define sensorEZ1		1
	#define sensorAnalogico		2
	#define sensorLinhaDigital	3
//tipoLeitura
	#define polegadas	0
	#define centimetros	1
	#define metros		2
	#define leituraPadrao	3

#define MAX_SENSOR		4
struct	{
	int	 pinSensor
		,pinServo
		,estiloMovtoServo
		,estiloMovtoServoPadrao
		,servoPosAtual
		,direcaoLeitura
		,tipoLeitura
		,tipoSensor
		,anguloMenorLeitura
		,anguloMaiorLeitura
		;
	int	 repeticao
		,intervaloRepeticao
		,contadorRepeticao
		,intervaloExecucao
		,cicloAnterior
		,idComandoLerSensor
		,idComandoRepeticao
		;
	long	 menorConversao
		,maiorConversao
		,ultimaLeitura
		,leituraAtual
		,menorLeitura
		,maiorLeitura
		;
	Servo	 servoMovto;
	}
	Sensor [ MAX_SENSOR ];

int   qtdeSensor	  =	-1;

//funcao
	#define retornarLeitura	0
	#define usarMAP		1
	#define usarFuncao	2

#define MAX_TIPOSENSOR		4
struct	{
	int	 funcao
	        ;
	float	 divisor_1
		,multiplicador_1
		,divisor_2
		,multiplicador_2
		;					//                   Polegadas                       Centimetros                         Metros
							//           ------------------------      ------------------------------      --------------------------------
							//           F    D     M     D     M      F    D           M     D     M      F    D           M       D     M
	}						//                1     1     2     2           1           1     2     2           1           1       2     2
	TipoSensor [ MAX_TIPOSENSOR ][ 3 ]	=	{
								 { { 2, 148,    1,    1,    1 }, { 2,  58,          1,    1,    1 }, { 2,   58,       100,      1,    1 } } // PING
								,{ { 2,   2,    1,    1,    1 }, { 2,   1,    1.30435,    1,    1 }, { 2,   100,  1.30435,      1,    1 } } // EZ1
								,{ { 1,   1,    1,    1,    1 }, { 1,   1,          1,    1,    1 }, { 1,   1,          1,      1,    1 } } // Analogico
								,{ { 1,   1,    1,    1,    1 }, { 1,   1,          1,    1,    1 }, { 1,   1,          1,      1,    1 } } // Analogico
							};

unsigned long  leitura;

boolean ExecutarLerSensor	=	false;
boolean ExecutarRepeticao	=	false;
/*
	Tabela de estilo de leitura dos sensores.
*/
// Linhas
	#define movtoVarredura   0
	#define movtoAFrente     1
	#define movtoExtremos    2
	#define semMovto         3
// colunas
struct	{
	int	 fatorAcrescimo
		,anguloInicial
		,anguloFinal
		;
	}
	EstiloMovtoServo[ 4 ]	=	{	 //   fatorAcres  anguloInicial  anguloFinal
						 {            10,            20,         170 }
						,{            15,            75,         105 }
						,{            30,            30,         150 }
						,{             0,             0,           0 }
					};

/*
	Incluir um novo sensor.
*/
int incluirSensor	(
			 int pPin
			,int pPinServo
			,int  pRepeticao
			,int  pIntervaloRepeticao
			,int pEstiloMovtoServo
			,long pMenorConversao
			,long pMaiorConversao
			,int pTipoSensor
			,int  pIntervaloMinimoExec
			,int pTipoLeitura
			) {
	qtdeSensor++;
	if ( qtdeSensor <= ( MAX_SENSOR -1 ) ) {
		Sensor[ qtdeSensor ].pinSensor			=	pPin;
		Sensor[ qtdeSensor ].pinServo			=	pPinServo;
		Sensor[ qtdeSensor ].tipoSensor			=	pTipoSensor;
		Sensor[ qtdeSensor ].tipoLeitura		=	pTipoLeitura;
		Sensor[ qtdeSensor ].repeticao			=	pRepeticao;
		Sensor[ qtdeSensor ].menorConversao		=	pMenorConversao;
		Sensor[ qtdeSensor ].maiorConversao		=	pMaiorConversao;

		// Configura o intervalo de repeticao do comando.
		if ( Sensor[ qtdeSensor ].repeticao < 1 ) {
			Sensor[ qtdeSensor ].repeticao		=	1; // No minimo 1 repeticao.
		}
		Sensor[ qtdeSensor ].intervaloRepeticao = pIntervaloRepeticao;
		if ( Sensor[ qtdeSensor ].intervaloRepeticao < 10 ) {
			Sensor[ qtdeSensor ].intervaloRepeticao	=	10; // No minimo um intervalo de 10 milisegundos entre cada repeticao de leitura.
		}
		Sensor[ qtdeSensor ].idComandoRepeticao		=	incluirComando( Sensor[ qtdeSensor ].intervaloRepeticao );
		ativarComando( Sensor[ qtdeSensor ].idComandoRepeticao );


		Sensor[ qtdeSensor ].intervaloExecucao		=	pIntervaloMinimoExec;
		if ( Sensor[ qtdeSensor ].intervaloExecucao < 60 ) {
			Sensor[ qtdeSensor ].intervaloExecucao	=	60; // No minimo um intervalo de 60 milisegundos entre cada leitura completa do sensor (posicionamento do servo).
		}
		// O intervalo de execucao do comando lerSensor sera sempre maior ou igual a soma dos intervalos das repeticoes.
		if ( Sensor[ qtdeSensor ].intervaloExecucao < ( Sensor[ qtdeSensor ].intervaloRepeticao * Sensor[ qtdeSensor ].repeticao ) ) {
			Sensor[ qtdeSensor ].intervaloExecucao	=	( Sensor[ qtdeSensor ].intervaloRepeticao * Sensor[ qtdeSensor ].repeticao );
		}
		Sensor[ qtdeSensor ].idComandoLerSensor		=	incluirComando( Sensor[ qtdeSensor ].intervaloExecucao );
		ativarComando( Sensor[ qtdeSensor ].idComandoLerSensor );

		Sensor[ qtdeSensor ].cicloAnterior		=	0;

		//mostrarTexto( "		Sensor [" );
		//mostrarTexto( qtdeSensor );
		//mostrarTexto( "] pin [" );
		//mostrarTexto( Sensor[ qtdeSensor ].pinSensor );
		//mostrarTexto( "] Servo [" );
		//mostrarTexto( Sensor[ qtdeSensor ].pinServo );
		//mostrarTexto( "] Repeticao [" );
		//mostrarTexto( Sensor[ qtdeSensor ].repeticao );
		//mostrarTexto( "] Intervalo [" );
		//mostrarTexto( Sensor[ qtdeSensor ].intervaloExecucao );
		//mostrarTexto( "] Tipo Leitura [" );
		//mostrarTexto( Sensor[ qtdeSensor ].tipoLeitura );
		//mostrarTexto( "]", true );

		// Ativa e posiciona o servo. O NONE indica que nao ha servo para este sensor.
		if ( Sensor[ qtdeSensor ].pinServo != NONE ) {
			Sensor[ qtdeSensor ].servoMovto.attach( Sensor[ qtdeSensor ].pinServo );
			//mostrarTexto( "		Servo ativado em [" );
			//mostrarTexto( Sensor[ qtdeSensor ].servoPosAtual );
			//mostrarTexto( "]", true );
		}

		// Inicializa variaveis de controle de leitura do sensor.
		setSensorEstiloMovto( qtdeSensor, pEstiloMovtoServo );

		// Realiza 3 leituras para inicializar corretamente o sensor.
		lerSensor( qtdeSensor );
		lerSensor( qtdeSensor );
		lerSensor( qtdeSensor );

		return qtdeSensor;
	}
	else {
		return NONE;
	}
}

void inicializaPosServo ( int pSensor ) {
	//mostrarTexto( "			inicializaPosServo.", true );
	Sensor[ pSensor ].direcaoLeitura		=	ascendente;
	Sensor[ pSensor ].servoPosAtual			=	EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].anguloInicial
							-	EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].fatorAcrescimo;
}

void inicializaRepeticao ( int pSensor ) {
	//mostrarTexto( "			inicializaRepeticao.", true );
	Sensor[ pSensor ].contadorRepeticao		=	0;
}

void setSensorEstiloMovto ( int pSensor, int pEstilo ) {
	if ( pSensor != NONE &&
	     Sensor[ pSensor ].estiloMovtoServo != pEstilo &&
	     Sensor[ pSensor ].pinServo != NONE
	   ) {
		//mostrarTexto( "		Novo estilo.", true );
		// Configuramos o estilo de leitura escolhido.
		if ( pEstilo == NONE ) {
			Sensor[ pSensor ].estiloMovtoServo	=	Sensor[ pSensor ].estiloMovtoServoPadrao;
			//mostrarTexto( "			Padrao", true );
		}
		else {
			Sensor[ pSensor ].estiloMovtoServo	=	pEstilo;
			//mostrarTexto( "			pEstilo", true );
		}

		// Inicializa variaveis de controle de leitura do sensor.
		Sensor[ pSensor ].anguloMenorLeitura	=	0;
		Sensor[ pSensor ].anguloMaiorLeitura	=	0;
		Sensor[ pSensor ].menorLeitura		=	 9999; // maior valor que um long pode receber
		Sensor[ pSensor ].maiorLeitura		=	-9999;
		//mostrarTexto( "		Variaveis inicializadas.", true );
		Sensor[ pSensor ].servoPosAtual		=	EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].anguloInicial;
		//mostrarTexto( "		Servo posicionado.", true );

		// Inicializa ciclos do comando lerSensor.
		inicializaPosServo( pSensor );
		inicializaRepeticao( pSensor );
	}
}

void lerSensor ( int pSensor ) {
	// Usa a configuracao do sensor para realizar a leitura.
	lerSensor( pSensor, Sensor[ pSensor ].estiloMovtoServo );
}

void lerSensor	(
		 int  pSensor
		,int pEstilo
		) {
	/*
		Realiza a leitura do sensor.
	*/
	if ( pSensor != NONE ) {
		/*
			Existe uma dependencia entre o comando Posicionar Servo (idComando) e o comando ler o sensor (idComandoRepeticao). Abaixo represento esta dependencia:
				(idComando) só executa quando:
					1. Estiver com o tempo de espera maior que o tempo configurado. Esta funcao e controlada pelo "executarComando";
					2. O contador de repeticao estiver zerado;

				(idComandoRepeticao) só executa quando:
					1. Estiver com o tempo de espera maior que o tempo configurado. Esta funcao e controlada pelo "executarComando";
					2. O contador de repeticao estiver igual 0 (zero). Vai iniciar o ciclo;
						3. O ciclo do posiciona servo estiver no mesmo do anterior ou for o primeiro (==0);
					2. O contador de repeticao estiver menor a quantidade de repeticoes configuradas;
					3. O ciclo do posiciona servo estiver no mesmo do anterior ou for o primeiro (==0);
		*/

		ExecutarLerSensor	=	podeExecutarComando( Sensor[ pSensor ].idComandoLerSensor,	( Sensor[ pSensor ].contadorRepeticao == 0
														)
								);
		ExecutarRepeticao	=	podeExecutarComando( Sensor[ pSensor ].idComandoRepeticao,	(// Se estamos iniciando
														  ( ( Sensor[ pSensor ].contadorRepeticao == 0 &&
														      ( Sensor[ pSensor ].cicloAnterior == 0 ||
														        Sensor[ pSensor ].cicloAnterior != cicloAtual( Sensor[ pSensor ].idComandoLerSensor )
														      )
														    )
														  ) ||
														  ( ( Sensor[ pSensor ].contadorRepeticao > 0 &&
														      Sensor[ pSensor ].contadorRepeticao < Sensor[ pSensor ].repeticao &&
														      ( Sensor[ pSensor ].cicloAnterior == 0 ||
														        Sensor[ pSensor ].cicloAnterior == cicloAtual( Sensor[ pSensor ].idComandoLerSensor )
														      )
														    )
														  )
														)
								);

		Sensor[ pSensor ].cicloAnterior		=	cicloAtual( Sensor[ pSensor ].idComandoLerSensor );

		if ( ExecutarLerSensor ) {
			ExecutarRepeticao		=	true; // Sempre executa a repeticao se executarmos o lerSensor.
		}

		if ( ExecutarLerSensor ||
		     ExecutarRepeticao
		   ) {
			/*
			if ( ExecutarLerSensor ) {
				mostrarTexto( "LerSensor = true ", true );
			}
			if ( ExecutarRepeticao ) {
				mostrarTexto( "ExecutarRepeticao = true ", true );
			}
			
			if ( Sensor[ pSensor ].tipoSensor == getTipoEZ1() ) {
				mostrarTexto( "sensorEZ1 ", true );
			}
			else if ( Sensor[ pSensor ].tipoSensor == getTipoPING() ) {
				mostrarTexto( "sensorPING ", true );
			}
			else if ( Sensor[ pSensor ].tipoSensor == getTipoAnalogico() ) {
				mostrarTexto( "sensorAnalogico ", true );
			}
			else if ( Sensor[ pSensor ].tipoSensor == getTipoLinhaDigital() ) {
				mostrarTexto( "sensorLinhaDigital ", true );
			}
			*/
			if ( ExecutarLerSensor ) {
				// Posiciona o servo do sensor.
				if ( Sensor[ pSensor ].pinServo != NONE &&
				     Sensor[ pSensor ].estiloMovtoServo != getSemMovtoServo()
				   ) {
					//mostrarTexto( "	Posicionando" );

					// Configuramos novamente o estilo de movimento, caso o estilo seja alterado.
					setSensorEstiloMovto( pSensor, pEstilo );
/*
					if ( Sensor[ pSensor ].estiloMovtoServo == getMovtoServoVarredura() ) {
						//mostrarTexto( "[por Varredura] " );
					}
					else if ( Sensor[ pSensor ].estiloMovtoServo == getMovtoServoAFrente() ) {
						//mostrarTexto( "[Frente] " );
					}
					else if ( Sensor[ pSensor ].estiloMovtoServo == getMovtoServoExtremos() ) {
						//mostrarTexto( "[Extremos] " );
					}
*/
					// Sobe angulo do servo
						 // Calcula a subida antes de saber se vai ou não descer. Se tiver que descer usará esta informação para calcular.
					if ( Sensor[ pSensor ].direcaoLeitura == ascendente ) {
						if ( Sensor[ pSensor ].servoPosAtual < EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].anguloFinal ) {
							Sensor[ pSensor ].servoPosAtual	=	Sensor[ pSensor ].servoPosAtual + EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].fatorAcrescimo;
						}
						else {
							Sensor[ pSensor ].direcaoLeitura = descendente;
						}
					}

					// Desce angulo do servo
					if ( Sensor[ pSensor ].direcaoLeitura == descendente ) {
						if ( Sensor[ pSensor ].servoPosAtual > ( EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].anguloInicial ) ) {
							Sensor[ pSensor ].servoPosAtual	=	Sensor[ pSensor ].servoPosAtual - EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].fatorAcrescimo;
						}
					}
					Sensor[ pSensor ].servoMovto.write( Sensor[ pSensor ].servoPosAtual );

					//mostrarTexto( "Posicao [" );
					//mostrarTexto( Sensor[ pSensor ].servoPosAtual ] );
					//mostrarTexto( "]", true );

					if ( Sensor[ pSensor ].servoPosAtual == EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].anguloInicial &&
						 Sensor[ pSensor ].direcaoLeitura == descendente ) {
						inicializaPosServo( pSensor );
						// Soma mais um fator ao inicial para evitar que o proximo ciclo repita o angula atual.
						Sensor[ pSensor ].servoPosAtual		=	Sensor[ pSensor ].servoPosAtual + EstiloMovtoServo[ Sensor[ pSensor ].estiloMovtoServo ].fatorAcrescimo;
					}
				}
			}

			if ( ExecutarRepeticao ) {
				// Executa N vezes a leitura do sensor para obter a média delas.
				if ( cicloAtual( Sensor[ pSensor ].idComandoRepeticao ) == 1 ) {
					Sensor[ pSensor ].contadorRepeticao		=	0;
				}

				Sensor[ pSensor ].contadorRepeticao++;
				if ( Sensor[ pSensor ].contadorRepeticao == 1 ) {
					Sensor[ pSensor ].leituraAtual			=	0;
				}
				//mostrarTexto( "	Lendo [" );
				//mostrarTexto( Sensor[ pSensor ].contadorRepeticao );
				//mostrarTexto( "." );
				//mostrarTexto( Sensor[ pSensor ].repeticao );
				//mostrarTexto( "]", true );

				// Executa a leitura de cada tipo de sensor.
				if ( Sensor[ pSensor ].tipoSensor == getTipoEZ1() ||
				     Sensor[ pSensor ].tipoSensor == getTipoAnalogico()
				   ) {
					Sensor[ pSensor ].leituraAtual			+=	lerAnalogico( pSensor );
				}

				if ( Sensor[ pSensor ].tipoSensor == getTipoPING() ) {
					Sensor[ pSensor ].leituraAtual			+=	lerPING( pSensor );
				}

				if ( Sensor[ pSensor ].tipoSensor == getTipoLinhaDigital() ) {
					Sensor[ pSensor ].leituraAtual			+=	lerLinhaDigital( pSensor );
				}
/*
				//mostrarTexto( "Leitura sun[" );
				//mostrarTexto( Sensor[ pSensor ].leituraAtual );
				//mostrarTexto( "]" );
				if ( Sensor[ pSensor ].tipoLeitura == centimetros ) {
					//mostrarTexto( " [centimetros]" );
				}
				else if ( Sensor[ pSensor ].tipoLeitura == polegadas ) {
					//mostrarTexto( " [polegadas]" );
				}
				else if ( Sensor[ pSensor ].tipoLeitura == metros ) {
					//mostrarTexto( " [metros]" );
				}
				else {
					//mostrarTexto( " [leitura padrao]" );
				}
*/

				if ( Sensor[ pSensor ].contadorRepeticao >= Sensor[ pSensor ].repeticao ) {
					Sensor[ pSensor ].ultimaLeitura			=	( Sensor[ pSensor ].leituraAtual / Sensor[ pSensor ].contadorRepeticao );
					//mostrarTexto( "		Leitura Final [" );
					//mostrarTexto( Sensor[ pSensor ].ultimaLeitura );
					//mostrarTexto( "]", true );

					inicializaRepeticao( pSensor );
				}
			}

			// Atualizamos o valor da menor leitura.
			//	Caso o servo esteja na posicao onde foi encontrado o menor valor, atualizamos de qualquer forma.
			if ( Sensor[ pSensor ].menorLeitura > Sensor[ pSensor ].leituraAtual ||
			     Sensor[ pSensor ].anguloMenorLeitura == Sensor[ pSensor ].servoPosAtual
			   ) {
				Sensor[ pSensor ].menorLeitura				=	Sensor[ pSensor ].leituraAtual;
				Sensor[ pSensor ].anguloMenorLeitura			=	Sensor[ pSensor ].servoPosAtual;
			}

			// Atualizamos o valor da maior leitura.
			//	Caso o servo esteja na posicao onde foi encontrado o maior valor, atualizamos de qualquer forma.
			if ( Sensor[ pSensor ].maiorLeitura < Sensor[ pSensor ].leituraAtual ||
			     Sensor[ pSensor ].anguloMaiorLeitura == Sensor[ pSensor ].servoPosAtual
			   ) {
				Sensor[ pSensor ].maiorLeitura				=	Sensor[ pSensor ].leituraAtual;
				Sensor[ pSensor ].anguloMaiorLeitura			=	Sensor[ pSensor ].servoPosAtual;
			}
		}
	}
}

void converterLeitura( int pSensor ) {
	if ( pSensor != NONE &&
	     Sensor[ pSensor ].tipoLeitura != getLeituraPadrao()
	   ) {
		//mostrarTexto( "		Leu tipo [" );
		//mostrarTexto( Sensor[ pSensor ].tipoSensor );
		//mostrarTexto( "] TipoLeitura [" );
		//mostrarTexto( Sensor[ pSensor ].tipoLeitura );
		//mostrarTexto( "] Leu [" );
		//mostrarTexto( leitura );
		if ( TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].funcao == usarFuncao ) {
			leitura	=	( ( ( ( ( leitura
					          / TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].divisor_1
					        ) * TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].multiplicador_1
					      )
					      / TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].divisor_2
					    ) * TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].multiplicador_2
					  )
					);
			//mostrarTexto( "] Funcao [" );
			//mostrarTexto( leitura );
			//mostrarTexto( "] /1 [" );
			//mostrarTexto( TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].divisor_1 );
			//mostrarTexto( "] *1 [" );
			//mostrarTexto( TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].multiplicador_1 );
			//mostrarTexto( "] /2 [" );
			//mostrarTexto( TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].divisor_2 );
			//mostrarTexto( "] *2 [" );
			//mostrarTexto( TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].multiplicador_2 );
			//mostrarTexto( "]", true );
		}
		else if ( TipoSensor[ Sensor[ pSensor ].tipoSensor ][ Sensor[ pSensor ].tipoLeitura ].funcao == usarMAP ) {
			if ( Sensor[ pSensor ].menorConversao != -1 &&
			     Sensor[ pSensor ].maiorConversao != -1
			   ) {
				leitura		=	map( leitura, Sensor[ pSensor ].menorConversao, Sensor[ pSensor ].maiorConversao, 0, 100 );
				//mostrarTexto( "] Converteu [" );
				//mostrarTexto( leitura );
				//mostrarTexto( "]", true );
			}
		}
		else {
			//mostrarTexto( "]", true );
		}
	}

}

long lerPING ( int pSensor ) {
	/*
		O PING))) eh acionado por um pulso HIGH de 2 ou mais microssegundos.
		Execute um curto pulso de baixa para garantir antecipadamente um pulso HIGH limpo:
	*/
	pinMode( Sensor[ pSensor ].pinSensor, OUTPUT );
	digitalWrite( Sensor[ pSensor ].pinSensor, LOW );
	delayMicroseconds( 2 );
	digitalWrite( Sensor[ pSensor ].pinSensor, HIGH );
	delayMicroseconds( 5 );
	digitalWrite( Sensor[ pSensor ].pinSensor, LOW);

	/*
		O mesmo pino eh usado para ler o sinal do PING))): o pulso HIGH, cuja duracao eh o tempo (em microssegundos) entre o envio
		do ping para a recepcao de seu eco fora de um objeto.
	*/
	pinMode( Sensor[ pSensor ].pinSensor, INPUT );
	leitura			=	pulseIn( Sensor[ pSensor ].pinSensor, HIGH );

	converterLeitura( pSensor );

	return leitura;
}

long lerLinhaDigital( int pSensor ) {
	/*
		O PING))) eh acionado por um pulso HIGH de 2 ou mais microssegundos.
		Execute um curto pulso de baixa para garantir antecipadamente um pulso HIGH limpo:
	*/
	pinMode( Sensor[ pSensor ].pinSensor, OUTPUT );
	digitalWrite( Sensor[ pSensor ].pinSensor, HIGH );
	delayMicroseconds( 10 );
	pinMode( Sensor[ pSensor ].pinSensor, INPUT );
	digitalWrite( Sensor[ pSensor ].pinSensor, HIGH );

	leitura			=	pulseIn( Sensor[ pSensor ].pinSensor, HIGH );

	converterLeitura( pSensor );

	return leitura;
}

long lerAnalogico ( int pSensor ) {
	leitura			=	analogRead( Sensor[ pSensor ].pinSensor );

	converterLeitura( pSensor );

	return leitura;
}

long getLeituraSensor ( int pSensor ) {
	return Sensor[ pSensor ].ultimaLeitura;
}

long getMenorLeituraSensor ( int pSensor ) {
	return Sensor[ pSensor ].menorLeitura;
}

long getMaiorLeituraSensor ( int pSensor ) {
	return Sensor[ pSensor ].maiorLeitura;
}

int getPosicaoLeituraSensor ( int pSensor ) {
	return Sensor[ pSensor ].servoPosAtual;
}

int getPosicaoMenorLeituraSensor ( int pSensor ) {
	return Sensor[ pSensor ].anguloMenorLeitura;
}

int getPosicaoMaiorLeituraSensor ( int pSensor ) {
	return Sensor[ pSensor ].anguloMaiorLeitura;
}
int getQtdeSensor() {
	return( qtdeSensor );
}

int getTipoPING() {
	return( sensorPING );
}

int getTipoEZ1() {
	return( sensorEZ1 );
}

int getTipoLinhaDigital() {
	return( sensorLinhaDigital );
}

int getTipoAnalogico() {
	return( sensorAnalogico );
}

int getSemMovtoServo() {
	return( semMovto );
}

int getMovtoServoVarredura() {
	return( movtoVarredura );
}

int getMovtoServoAFrente() {
	return( movtoAFrente );
}

int getMovtoServoExtremos() {
	return( movtoExtremos );
}

int getLeituraPadrao() {
	return( leituraPadrao );
}

int getCentimetros() {
	return( centimetros );
}

int getPolegadas() {
	return( polegadas );
}

int getMetros() {
	return( metros );
}
