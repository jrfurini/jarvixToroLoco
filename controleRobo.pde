//Personalidades
#define MALUCO			0
#define ZEM			1
#define NERVOSO			2
#define MEDROSO			3
#define EXCENTRICO		4
#define NONE			255

#define MAX_PERSONALIDADE	2 //5
#define MAX_REACAO		6 //7
	// Reacoes
	#define ANDAR			0
	#define CORRER			1
	#define FUGIR			2
	#define SEGUIR			3
	#define DESVIAR			4
	#define ANALISAR		5
#define MAX_MOVTO		3
#define MAX_PENSAMENTO		6
	// Pensamentos
	#define DEVO_ANDAR		0
	#define DEVO_CORRER		1
	#define DEVO_FUGIR		2
	#define DEVO_SEGUIR		3
	#define DEVO_DESVIAR		4
	#define DEVO_ANALISAR		5


//Movimentos por personalidade e reacao
struct	{
	int	 direcao
		,percVelocidade
		,grau
		,tempo
		,tipoMovtoSensor
		,pensamentoSeguinte
		;
	}
	/*
		Matriz formada por:
			1. Personalidade
			2. Reacao
			3. Movimento
	*/
							//direcao
								// getDirecaoParado()
								// getDirecaoFrente()
								// getDirecaoTraz()
								// getDirecaoDireita()
								// getDirecaoEsquerda()
							//tipoMovtoSensor
								// getSemMovtoServo()
								// getMovtoServoVarredura()
								// getMovtoServoAFrente()
								// getMovtoServoExtremos()
													//              direcao	 Vel Grau  Time           tipoMovtoSensor pensamentoSeguinte
	Reacao [ MAX_PERSONALIDADE ][ MAX_REACAO ][ MAX_MOVTO ]		=	{
											// MALUCO
											{
												 {
												// ANDAR
													 {   getDirecaoFrente(),  80,  90, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  80,  90, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  80,  90, 1000,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// CORRER
													 {   getDirecaoFrente(), 100,  90,  750,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(), 100, 100,  750,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(), 100,  80,  750,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// FUGIR
													 {     getDirecaoTraz(),  80,  80,  250,  getMovtoServoExtremos(),               NONE }
													,{     getDirecaoTraz(),  80, 100,  250,  getMovtoServoExtremos(),               NONE }
													,{     getDirecaoTraz(),  80,  90,  250,  getMovtoServoExtremos(),      DEVO_ANALISAR }
												 }
												,{
												// SEGUIR
													 {   getDirecaoFrente(),  80,  -1,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  80,  -3,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  80,  -3,  250,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// DESVIAR
													 {   getDirecaoFrente(),  60,  -2, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  -3,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  -3,  250,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// ANALISAR
													 { getDirecaoEsquerda(), 100, 360, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoParado(),   0,   0, 2000, getMovtoServoVarredura(),               NONE }
													,{   getDirecaoParado(),   0,   0,  200,  getMovtoServoExtremos(),               NONE }
												 }
											}
											// ZEM
											,{
												 {
												// ANDAR
													 {   getDirecaoFrente(),  60,  90, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  90, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  90, 1000,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// CORRER
													 {   getDirecaoFrente(),  70,  90,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  70,  90,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  70,  90,  250,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// FUGIR
													 {     getDirecaoTraz(),  60,  90,  100,  getMovtoServoExtremos(),               NONE }
													,{     getDirecaoTraz(),  60,  90,  100,  getMovtoServoExtremos(),               NONE }
													,{     getDirecaoTraz(),  60,  90,  100,  getMovtoServoExtremos(),      DEVO_ANALISAR }
												 }
												,{
												// SEGUIR
													 {   getDirecaoFrente(),  60,  -1,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  -3,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  -3,  250,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// DESVIAR
													 {   getDirecaoFrente(),  60,  -2, 1000,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  -3,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoFrente(),  60,  -3,  250,  getMovtoServoExtremos(),               NONE }
												 }
												,{
												// ANALISAR
													 { getDirecaoEsquerda(), 100, 360,  800,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoParado(),   0,   0, 2000, getMovtoServoVarredura(),               NONE }
													,{   getDirecaoParado(),   0,   0,  200,  getMovtoServoExtremos(),               NONE }
												 }
											}
/*
											// NERVOSO
											,{
												 {
												// ANDAR
													 {   getDirecaoFrente(),  60,  90, 5000,   getMovtoServoAFrente(),               NONE }
													,{                 NONE,   0,   0,    0,  getMovtoServoExtremos(),               NONE }
													,{                 NONE,   0,   0,    0,   getMovtoServoAFrente(),               NONE }
												 }
												,{
												// CORRER
													 {   getDirecaoFrente(), 100,  90, 5000,   getMovtoServoAFrente(),               NONE }
													,{   getDirecaoFrente(),  90, 100, 1000,   getMovtoServoAFrente(),               NONE }
													,{   getDirecaoFrente(),  90,  80, 1000,   getMovtoServoAFrente(),               NONE }
												 }
												,{
												// FUGIR
													 {     getDirecaoTraz(), 100,  90,  250,  getMovtoServoExtremos(),               NONE }
													,{     getDirecaoTraz(), 100, 180,  250,  getMovtoServoExtremos(),               NONE }
													,{   getDirecaoParado(), 100,  90,  250, getMovtoServoVarredura(),      DEVO_ANALISAR }
												 }
												,{
												// SEGUIR
													 {   getDirecaoFrente(), 100,  -1, 5000,   getMovtoServoAFrente(),               NONE }
													,{   getDirecaoFrente(),  80,  -1, 2000,   getMovtoServoAFrente(),               NONE }
													,{   getDirecaoFrente(),  50,  -1, 1000,   getMovtoServoAFrente(),        DEVO_CORRER }
												 }
												,{
												// DESVIAR
													 {     getDirecaoTraz(), 100,  -1, 1000,  getMovtoServoExtremos(),               NONE }
													,{     getDirecaoTraz(),  50,  -1, 1000,  getMovtoServoExtremos(),               NONE }
													,{ getDirecaoEsquerda(),  50,  -1, 3000,  getMovtoServoExtremos(),       DEVO_DESVIAR }
												 }
												,{
												// ANALISAR
													 {   getDirecaoParado(), 100,   0, 2000, getMovtoServoVarredura(),               NONE }
													,{   getDirecaoParado(),  50, 180, 2000, getMovtoServoVarredura(),               NONE }
													,{   getDirecaoParado(),  50, 300, 3000, getMovtoServoVarredura(),        DEVO_SEGUIR }
												 }
											}
*/
											// MEDROSO
											// EXCENTRICO
										};

//Pensamentos por personalidade
struct	{
	int	 sensor
		,angulo		//  0 - 180, angulo específico
				// -1, qualquer angulo
				// -2, angulos frontais    ( 85 a 95 )
				// -3, angulos da direita  ( 150 a 180 )
				// -4, angulos da esquerda ( 0 a 30 )
				// -5, angulos laterias ( 0 a 84 ou 96 a 180 )
		,tipoAngulo	//  0, ultima leitura
				//  1, angulo com a menor leitura
				//  2, angulo com a maior leitura
		;
	float	 valorMin
		,valorMax
		;
	int	 prioridade
		,reacao
		;
	}
							// Sensor
								// getSensorFrontal()
								// getSensorLinha_1()
								// getSensorLinha_2()
								// getSensorDireita()
								// getSensorEsquerda()
								// getSensorTraseiro()
								// getSensorPersonalidade()
	Pensamento [ MAX_PERSONALIDADE ][ MAX_PENSAMENTO ]	=	{
												// sensor		angulo		tipoAngulo	 valorMin	valorMax	prioridade	reacao
										// MALUCO
										 {
											// DEVO_ANDAR
											 {	 getSensorFrontal(),	   -2,			0,		0,	    999,	       40,	 ANDAR }
											// DEVO_CORRER
											,{	 getSensorFrontal(),	   -2,		        0,	      150,	    500,	       50,	CORRER }
											// DEVO_FUGIR
											,{	 getSensorFrontal(),	   -1,			0,	       11,	     20,	       10,	 FUGIR }
											// DEVO_SEGUIR
											,{	 getSensorFrontal(),	   -2,		        1,	       40,	    100,	       30,	SEGUIR }
											// DEVO_DESVIAR
											,{	 getSensorFrontal(),	   -5,		        1,	       21,	     30,	       20,     DESVIAR }
											// DEVO_ANALISAR
											,{	 getSensorFrontal(),	   -2,		        0,	        0,	     10,	        0,    ANALISAR }
										 }
										// ZEM
										 ,{
											// DEVO_ANDAR
											 {	 getSensorFrontal(),	   -2,			0,		0,	    999,	       50,	 ANDAR }
											// DEVO_CORRER
											,{	 getSensorFrontal(),	   -2,		        0,	      201,	    250,	       40,	CORRER }
											// DEVO_FUGIR
											,{	 getSensorFrontal(),	   -1,			0,	       21,	     30,	       10,	 FUGIR }
											// DEVO_SEGUIR
											,{	 getSensorFrontal(),	   -2,		        1,	      100,	    200,	       30,	SEGUIR }
											// DEVO_DESVIAR
											,{	 getSensorFrontal(),	   -5,		        1,	       31,	     40,	       20,     DESVIAR }
											// DEVO_ANALISAR
											,{	 getSensorFrontal(),	   -2,		        0,	        0,	     20,	        0,    ANALISAR }
										 }
										// NERVOSO
										// MEDROSO
										// EXCENTRICO
									};

// Configuracao do robo.
int	 motorDireita			=	0
	,motorEsquerda			=	1
	// Configuracao de seguranca
	,velocidadeMax			=	255		// Maximo valor para a PWM.
	,velocidadeMin			=	0		// Cada motor tem a sua velocidade minima e se enviarmos uma voltagem menor ele nao gira.
								// Entao usamos esta constante para determinar, quando aceleramos, o valor minimo a ser colocado na PWM.
								// Usaremos 0 (LOW) durante o freio logico para deteminar que o motor deva desligar.
	// Configuracao de mudanca de velocidade
	,fatorAltVeloc			=	5
	,tempoAltVeloc			=	100
	,tempoTrocarMovto		=	0
	// Configuracao de sensores
	,sensorFrontal			=	0
	,sensorLinha_1			=	0
	,sensorLinha_2			=	0
	,sensorDireita			=	0
	,sensorEsquerda			=	0
	,sensorTraseiro			=	0
	// Personalidade	
	,sensorPersonalidade		=	0
	,pinPersonalidade		=	NONE
	,personalidadeAtual		=	9
	// Configuracao de movimento
	,idComandoTrocarMovto		=	0
	,pensamentoPadrao		=	DEVO_ANDAR
	,pensamentoAtual		=	9 // pre-pensamento.
	,posicaoSensorPensamento	=	0
	,reacaoAtual			=	ANDAR
	,movtoAtual			=	9 // pre-movimento.
	,movtoCount			=	9 // pre-movimento.
	,grauAnterior			=	90
	;
float	 leituraSensorPensamento	=	0
	;

void roboAtivar	(
		// Motores
		 int  pMotorDireta
		,int  pMotorEsquerda
		,int  pVelocidadeMinima
		,int  pVelocidadeMaxima
		,int  pFatorAltVeloc
		,int  pTempoAltVeloc
		// Sensores
		,int  pSensorFrontal
		,int  pSensorLinha_1
		,int  pSensorLinha_2
		,int  pSensorDireita
		,int  pSensorEsquerda
		,int  pSensorTraseiro
		// Personalidade
		,int  pSensorPersonalidade
		,int  pPinPersonalidade
		// Configuracao de movimento padrao
		,int  pPensamentoPadrao
		) {
	//mostrarTexto( "roboAtivar", true );
	// Motores
	setMotorDireita ( pMotorDireta );
	setMotorEsquerda( pMotorEsquerda );
	setVelocidadeMax( pVelocidadeMaxima );
	setVelocidadeMin( pVelocidadeMinima );
	setFatorAltVeloc( pFatorAltVeloc );
	setTempoAltVeloc( pTempoAltVeloc );

	// Sensores
	setSensorFrontal( pSensorFrontal );
	setSensorLinha_1( pSensorLinha_1 );
	setSensorLinha_2( pSensorLinha_2 );
	setSensorDireita( pSensorDireita );
	setSensorEsquerda( pSensorEsquerda );
	setSensorTraseiro( pSensorTraseiro );
	setSensorPersonalidade( pSensorPersonalidade );

	// Indicadores
	pinPersonalidade		=	pPinPersonalidade;
	if ( pinPersonalidade != NONE ) {
		pinMode( pinPersonalidade, OUTPUT );
	}

	// Aciona o primeiro pensamento da personalidade.
	tempoTrocarMovto		=	0;
	idComandoTrocarMovto		=	incluirComando( tempoTrocarMovto ); // apenas registra o comando, mas o materá desativado.
	pensamentoPadrao		=	pPensamentoPadrao;

	setPersonalidade( ZEM ); // primeira personalidade
}

void roboAnalisar() {
	//mostrarTexto( "roboAnalisar", true );
	// Lemos todos os sensores.
	for ( int iSensor = 0; iSensor <= getQtdeSensor(); iSensor++ ) {
		lerSensor( iSensor );
	}
}

// Analisamos as informacoes dos sensores para definir reacoes.
void roboPensar() {
	// Pensamentos
	for ( int iPensamento = 0; iPensamento <= (MAX_PENSAMENTO-1); iPensamento++ ) {

		if ( Pensamento[ getPersonalidade() ][ iPensamento ].tipoAngulo == 1 ) {
			leituraSensorPensamento	=	getMenorLeituraSensor( Pensamento[ getPersonalidade() ][ iPensamento ].sensor );
			posicaoSensorPensamento	=	getPosicaoMenorLeituraSensor( Pensamento[ getPersonalidade() ][ iPensamento ].sensor );
		}
		else if ( Pensamento[ getPersonalidade() ][ iPensamento ].tipoAngulo == 2 ) {
			leituraSensorPensamento	=	getMaiorLeituraSensor( Pensamento[ getPersonalidade() ][ iPensamento ].sensor );
			posicaoSensorPensamento	=	getPosicaoMaiorLeituraSensor( Pensamento[ getPersonalidade() ][ iPensamento ].sensor );
		}
		else {
			leituraSensorPensamento	=	getLeituraSensor( Pensamento[ getPersonalidade() ][ iPensamento ].sensor );
			posicaoSensorPensamento	=	getPosicaoLeituraSensor( Pensamento[ getPersonalidade() ][ iPensamento ].sensor );
		}

		//mostrarTexto( "(roboPensar)" );
		//mostrarTexto( " Pensamento [" );
		//mostrarTexto( iPensamento );
		//mostrarTexto( "] leitura do sensor [" );
		//mostrarTexto( leituraSensorPensamento );
		//mostrarTexto( "] Min [" );
		//mostrarTexto( Pensamento[ getPersonalidade() ][ iPensamento ].valorMin );
		//mostrarTexto( "] Max [" );
		//mostrarTexto( Pensamento[ getPersonalidade() ][ iPensamento ].valorMax );
		//mostrarTexto( "] Prior [" );
		//mostrarTexto( Pensamento[ getPersonalidade() ][ iPensamento ].prioridade );
		//mostrarTexto( "] PriAnterior [" );
		//mostrarTexto( Pensamento[ getPersonalidade() ][ getPensamentoAtual() ].prioridade );
		//mostrarTexto( "]", true );
				// -2, angulos frontais    ( 85 a 95 )
				// -3, angulos da direita  ( 150 a 180 )
				// -4, angulos da esquerda ( 0 a 30 )
				// -5, angulos laterias ( 0 a 84 ou 96 a 180 )
		if ( (
		       // Há um sensor neste pensamento.
		       Pensamento[ getPersonalidade() ][ iPensamento ].sensor != NONE &&
		       // Prioridade do pensamento atual eh menor que a do pensamento ativo no momento.
		       Pensamento[ getPersonalidade() ][ iPensamento ].prioridade < Pensamento[ getPersonalidade() ][ getPensamentoAtual() ].prioridade &&
		       // Leitura do sensor esta entre os valores configurados.
		       leituraSensorPensamento >= Pensamento[ getPersonalidade() ][ iPensamento ].valorMin &&
		       leituraSensorPensamento <= Pensamento[ getPersonalidade() ][ iPensamento ].valorMax &&
		       // O valor da leitura esta dentro do angulo configurado.
		          // todos os angulos
		       ( Pensamento[ getPersonalidade() ][ iPensamento ].angulo == -1 ||
		          // Angulo exato
		         posicaoSensorPensamento == Pensamento[ getPersonalidade() ][ iPensamento ].angulo ||
		          // Angulos frontais de 85 a 95
		         ( Pensamento[ getPersonalidade() ][ iPensamento ].angulo == -2 &&
		           posicaoSensorPensamento >= 85 &&
		           posicaoSensorPensamento <= 95
		         ) ||
		          // Angulos da direita de 150 a 180
		         ( Pensamento[ getPersonalidade() ][ iPensamento ].angulo == -3 &&
		           posicaoSensorPensamento >= 150 &&
		  	 posicaoSensorPensamento <= 180
		         ) ||
		          // Angulos da esquerda de 0 a 30
		         ( Pensamento[ getPersonalidade() ][ iPensamento ].angulo == -4 &&
		           posicaoSensorPensamento >= 0 &&
			   posicaoSensorPensamento <= 30
		         ) ||
		          // Angulos laterias ( 0 a 84 ou 96 a 180 )
		         ( Pensamento[ getPersonalidade() ][ iPensamento ].angulo == -5 &&
		           ( ( posicaoSensorPensamento >= 0 &&
			       posicaoSensorPensamento <= 84
			     ) ||
		             ( posicaoSensorPensamento >= 96 &&
			       posicaoSensorPensamento <= 180
			     )
			   )
		         )
		       ) 
		     )
		   ) {
			//mostrarTexto( "(roboPensar) Pensamento [" );
			//mostrarTexto( iPensamento );
			/*
			if ( iPensamento == DEVO_ANDAR ) {
				mostrarTexto( "DEVO_ANDAR" );
			}
			else if ( iPensamento == DEVO_CORRER ) {
				mostrarTexto( "DEVO_CORRER" );
			}
			else if ( iPensamento == DEVO_FUGIR ) {
				mostrarTexto( "DEVO_FUGIR" );
			}
			else if ( iPensamento == DEVO_SEGUIR ) {
				mostrarTexto( "DEVO_SEGUIR" );
			}
			else if ( iPensamento == DEVO_DESVIAR ) {
				mostrarTexto( "DEVO_DESVIAR" );
			}
			else if ( iPensamento == DEVO_ANALISAR ) {
				mostrarTexto( "DEVO_ANALISAR" );
			}
			else {
				mostrarTexto( getPensamento() );
			}

			mostrarTexto( "] leitura do sensor [" );
			mostrarTexto( leituraSensorPensamento );
			mostrarTexto( "]", true );
			*/
			setPensamentoAtual( iPensamento );
		}
	}

	// Verificamos a cada ciclo se foi solicitada a alteracao de personalidade.
	roboDefinirPersonalidade();
}

void roboIr() {
	//mostrarTexto( "roboIr", true );

	// Rodamos o comando de ajuste de velocidade para todos os motores.
	// Dentro deste comando eh que analisamos se o comando para ajuste esta ou nao ativo.
	for ( int iMotor = 0; iMotor <= getQtdeMotor(); iMotor++  ) {
		ajustarVelocidade( iMotor );
	}

	// Só iniciamos as trocas de movimentos quando atingimos a velocidade indicada no movimento anterior.
	// E quando já não estivermos em troca de movimento.
	// E quando não estivermos no pensamento padrão.
	// OU quando estivermos no pensamento padrão e ainda estivermos trocando os movimentos para ele.
	
	// Finalizamos os ajuste de velocidade do robo.
	// O comando de troca de movimento está desligado.
	// O pensamento atual é diferente do pensamento padrão.
	if ( motoresAjustados() &&
	     !comandoAtivo( idComandoTrocarMovto )
	   ) {
		//mostrarTexto( "Ativando o comando de troca com o tempo [" );
		//mostrarTexto( tempoTrocarMovto );
		//mostrarTexto( "]", true );
		ativarComando( idComandoTrocarMovto, tempoTrocarMovto );
	}

	// A cada ciclo pode ser necessario alterar o movto do robo.
	roboTrocarMovto();
}

void roboTrocarMovto() {
	if ( podeExecutarComando( idComandoTrocarMovto ) ) {
		//mostrarTexto( "roboTrocarMovto", true );
		movtoCount++;

		if ( movtoCount > (MAX_MOVTO-1) ) { // Atingimos o ultimo movimento da reacao.
			movtoCount	=	0; // preparamos o próximo ciclo.
			// Ativamos a reacao seguinte, se existir.
			if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].pensamentoSeguinte != NONE ) {
				setPensamentoAtual( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].pensamentoSeguinte );
			}
			else { // Nao temos uma sequencia para seguir apos o termino dos movimento. Assumimos a reacao padrao.
				//mostrarTexto( "        Assumindo reacao padrao", true );
				setPensamentoAtual( getPensamentoPadrao() );
  			}
		}
		else {
			//mostrarTexto( "roboTrocarMovto.setMovto", true );
			setMovto( movtoCount );
		}
	}
}

void roboDefinirPersonalidade() {
	if ( getSensorPersonalidade() != NONE ) {
		//mostrarTexto( "roboDefinirPersonalidade" );
		//mostrarTexto( "     Trocando [" );
		//mostrarTexto( getLeituraSensor( getSensorPersonalidade() ) );

		int fatorPersonalidade	=	map( getLeituraSensor( getSensorPersonalidade() ), 0, 1023, 0, 4 );

		//mostrarTexto( "] map [" );
		//mostrarTexto( fatorPersonalidade );
		//mostrarTexto( "]", true );

		if ( fatorPersonalidade == MALUCO &&
		     getPersonalidade() != MALUCO
		   ) { // MALUCO
	   		setPersonalidade( MALUCO );
		}
		else if ( fatorPersonalidade == NERVOSO &&
			  getPersonalidade() != NERVOSO
		         ) { // NERVOSO
	   		setPersonalidade( NERVOSO );
		}
		else if ( fatorPersonalidade == ZEM &&
			  getPersonalidade() != ZEM
		         ) { // ZEM
		   	setPersonalidade( ZEM );
		}
		else if ( fatorPersonalidade == MEDROSO &&
			  getPersonalidade() != MEDROSO
		         ) { // MEDROSO
		   	setPersonalidade( MEDROSO );
		}
		else if ( fatorPersonalidade == EXCENTRICO &&
			  getPersonalidade() != EXCENTRICO
		         ) { // MEDROSO
		   	setPersonalidade( EXCENTRICO );
		}
	}
}

void posicionarRobo	(
			 int pDirecao
			,int pPercVelocidade
			,int pTempo
			,int pGrau
			) {
	int vGrau		=	min( pGrau, 360 );
	vGrau			=	max( vGrau, 0 );
	int percDiferenca	=	map( vGrau, 0, 360, 0, 100 );
	int novaVelocidade	=	0;
	//mostrarTexto( "(posicionarRobo)", true );

	if ( pDirecao == getDirecaoParado() ) {
		//mostrarTexto( "Parando Robo a [" );
		//mostrarTexto( pPercVelocidade );
		//mostrarTexto( "] %.", true );

		direcionarFrente( getMotorDireita() );
		direcionarFrente( getMotorEsquerda() );

		registrarVelocidade( getMotorDireita(), 0 );
		registrarVelocidade( getMotorEsquerda(), 0 );
	}
	else if ( pDirecao == getDirecaoFrente() ) {
		vGrau		=	min( vGrau, 180 );
		//mostrarTexto( "Para Frente a [" );
		//mostrarTexto( pPercVelocidade );
		//mostrarTexto( "] % [" );
		//mostrarTexto( vGrau );
		//mostrarTexto( "] graus.", true );

		direcionarFrente( getMotorDireita() );
		direcionarFrente( getMotorEsquerda() );

		if ( vGrau > 90 ) {
			// Direita menor
			percDiferenca	=	map( vGrau, 180, 91, 0, 100 );
			novaVelocidade	=	map( percDiferenca, 0, 100, getVelocidadeMin(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorDireita(), novaVelocidade );
			registrarVelocidade( getMotorEsquerda(), perc2Velocidade( pPercVelocidade ) );
		}
		else if ( vGrau < 90 ) {
			// Esquerda menor
			percDiferenca	=	map( vGrau, 0, 89, 0, 100 );
			novaVelocidade	=	map( percDiferenca, 0, 100, getVelocidadeMin(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorDireita(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorEsquerda(), novaVelocidade );
		}
		else {// vGrau == 90
			// velocidades iguais
			registrarVelocidade( getMotorDireita(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorEsquerda(), perc2Velocidade( pPercVelocidade ) );
		}
	}
	else if ( pDirecao == getDirecaoTraz() ) {
		vGrau		=	min( vGrau, 180 );

		//mostrarTexto( "Para Traz a [" );
		//mostrarTexto( pPercVelocidade );
		//mostrarTexto( "] % [" );
		//mostrarTexto( vGrau );
		//mostrarTexto( "] graus.", true );

		direcionarTraz( getMotorDireita() );
		direcionarTraz( getMotorEsquerda() );

		if ( vGrau > 90 ) {
			// Direita menor
			percDiferenca	=	map( vGrau, 180, 91, 0, 100 );
			novaVelocidade	=	map( percDiferenca, 0, 100, getVelocidadeMin(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorDireita(), novaVelocidade );
			registrarVelocidade( getMotorEsquerda(), perc2Velocidade( pPercVelocidade ) );
		}
		else if ( vGrau < 90 ) {
			// Esquerda menor
			percDiferenca	=	map( vGrau, 0, 89, 0, 100 );
			novaVelocidade	=	map( percDiferenca, 0, 100, getVelocidadeMin(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorDireita(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorEsquerda(), novaVelocidade );
		}
		else {// vGrau == 90
			// velocidades iguais
			registrarVelocidade( getMotorDireita(), perc2Velocidade( pPercVelocidade ) );
			registrarVelocidade( getMotorEsquerda(), perc2Velocidade( pPercVelocidade ) );
		}
	}
	else if ( pDirecao == getDirecaoDireita() ) {
		//mostrarTexto( "Virando para direita a [" );
		//mostrarTexto( pPercVelocidade );
		//mostrarTexto( "] % [" );
		//mostrarTexto( vGrau );
		//mostrarTexto( "] graus.", true );

		// Recalcula a velocidade do motor da direita
		registrarVelocidade( getMotorDireita(), perc2Velocidade( pPercVelocidade ) );
		direcionarFrente( getMotorDireita() );

		if ( vGrau > 180 ) {
			novaVelocidade	=	map( vGrau, 90, 180, getVelocidadeMin(), perc2Velocidade( pPercVelocidade ) );
			// Inverte o motor oposto quanto o grau for maior que 180.
			direcionarTraz( getMotorEsquerda() );
		}
		else {
			novaVelocidade	=	map( percDiferenca, 0, 50, perc2Velocidade( pPercVelocidade ), getVelocidadeMin() );
			direcionarFrente( getMotorEsquerda() );
		}
		registrarVelocidade( getMotorEsquerda(), novaVelocidade );

		//mostrarTexto( "	Velocidade direita [" );
		//mostrarTexto( Motor[ getMotorDireita() ].velocidade );
		//mostrarTexto( "] esquerda [" );
		//mostrarTexto( novaVelocidade );
		//mostrarTexto( "]  [" );
		//mostrarTexto( percDiferenca );
		//mostrarTexto( "] %", true );
	}
	else if ( pDirecao == getDirecaoEsquerda() ) {
		//mostrarTexto( "Virando para esquerda a [" );
		//mostrarTexto( pPercVelocidade );
		//mostrarTexto( "] % [" );
		//mostrarTexto( vGrau );
		//mostrarTexto( "] graus.", true );

		// Recalcula a velocidade do motor da esquerda
		registrarVelocidade( getMotorEsquerda(), perc2Velocidade( pPercVelocidade ) );
		direcionarFrente( getMotorEsquerda() );

		if ( vGrau > 180 ) {
			novaVelocidade  = map( percDiferenca, 51, 100, getVelocidadeMin(), perc2Velocidade( pPercVelocidade ) );
			// Inverte o motor oposto quanto o grau for maior que 180.
			direcionarTraz( getMotorDireita() );
		}
		else {
			novaVelocidade	=	map( percDiferenca, 0, 50, perc2Velocidade( pPercVelocidade ), getVelocidadeMin() );
			direcionarFrente( getMotorDireita() );
		}
		registrarVelocidade( getMotorDireita(), novaVelocidade );

		//mostrarTexto( "	Velocidade esquerda [" );
		//mostrarTexto( Motor[ getMotorEsquerda() ].velocidade );
		//mostrarTexto( "] direita [" );
		//mostrarTexto( novaVelocidade );
		//mostrarTexto( "]  [" );
		//mostrarTexto( percDiferenca );
		//mostrarTexto( "] %", true );
	}

	// Ativa os comandos para alterar a velocidade dos motores.
	ativarComando( getComandoDireita() );
	ativarComando( getComandoEsquerda() );

	// Prepara para manter o movimento por alguns segundos (pTempo).
		// Primeiro vamos ajustar a velocidade, so apos ser ajutada eh que faremos a troca de movimento.
	desativarComando( idComandoTrocarMovto );
	tempoTrocarMovto	=	pTempo; // este tempo serah usados para manter a velocidade e o movimento do robo.
}

int getMovto() {
	return movtoAtual;
}

void setMovto( int pMovto ) {
	movtoAtual	=	pMovto;
	// o roboTrocarMovto trocou o movtoAtual.
	mostrarTexto( "(setMovto) Pers [" );
	mostrarTexto( getPersonalidade() );
	mostrarTexto( "] Pens [" );
	/*
	if ( getPensamento() == DEVO_ANDAR ) {
		mostrarTexto( "DEVO_ANDAR" );
	}
	else if ( getPensamento() == DEVO_CORRER ) {
		mostrarTexto( "DEVO_CORRER" );
	}
	else if ( getPensamento() == DEVO_FUGIR ) {
		mostrarTexto( "DEVO_FUGIR" );
	}
	else if ( getPensamento() == DEVO_SEGUIR ) {
		mostrarTexto( "DEVO_SEGUIR" );
	}
	else if ( getPensamento() == DEVO_DESVIAR ) {
		mostrarTexto( "DEVO_DESVIAR" );
	}
	else if ( getPensamento() == DEVO_ANALISAR ) {
		mostrarTexto( "DEVO_ANALISAR" );
	}
	else {
		mostrarTexto( getPensamento() );
	}
	*/
	mostrarTexto( getPensamento() );
	mostrarTexto( "] Reac [" );
	mostrarTexto( getReacao() );
	/*
	if ( getReacao() == ANDAR ) {
		mostrarTexto( "ANDAR" );
	}
	else if ( getReacao() == CORRER ) {
		mostrarTexto( "CORRER" );
	}
	else if ( getReacao() == FUGIR ) {
		mostrarTexto( "FUGIR" );
	}
	else if ( getReacao() == SEGUIR ) {
		mostrarTexto( "SEGUIR" );
	}
	else if ( getReacao() == DESVIAR ) {
		mostrarTexto( "DESVIAR" );
	}
	else if ( getReacao() == ANALISAR ) {
		mostrarTexto( "ANALISAR" );
	}
	else {
		mostrarTexto( getReacao() );
	}
	*/
	mostrarTexto( "] movto [" );
	mostrarTexto( pMovto );
	mostrarTexto( "] Leit [" );
	mostrarTexto( leituraSensorPensamento );
	mostrarTexto( "] PosSensor [" );
	mostrarTexto( posicaoSensorPensamento );
	mostrarTexto( "] grau [" );

	// Ajusta o movimento dos servos dos sensores.
	if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].direcao == getDirecaoTraz() ) {
		setSensorEstiloMovto( getSensorTraseiro(),  Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].tipoMovtoSensor );
	}
	//
	else if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].direcao == getDirecaoDireita() ) {
		setSensorEstiloMovto( getSensorDireita(),   Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].tipoMovtoSensor );
	}
	//
	else if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].direcao == getDirecaoEsquerda() ) {
		setSensorEstiloMovto( getSensorEsquerda(), Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].tipoMovtoSensor );
	}
	//
	else if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].direcao == getDirecaoFrente() ) {
		setSensorEstiloMovto( getSensorFrontal(),   Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].tipoMovtoSensor );
	}

	int vGrau;
	// se o grau informado for -1 indica que temos que pegar o angulo de menor leitura.
	if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].grau == -1 ) {
		vGrau		=	posicaoSensorPensamento;
		mostrarTexto( "Sensor " );
	}
	// se o grau informado for -2 indica que temos que pegar o angulo oposto ao de menor leitura.
	else if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].grau == -2 ) {
		mostrarTexto( "Oposto " );
		vGrau		=	180 - posicaoSensorPensamento;
		vGrau		=	min( vGrau, 180 );
		vGrau		=	max( vGrau, 0 );
		if ( vGrau == 90 ) {
			vGrau	=	0;
  		}
	}
	// se o grau informado for -3 indica que temos que pegar o angulo anterior.
	else if ( Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].grau == -3 ) {
		vGrau		=	grauAnterior;
		mostrarTexto( "Ant " );
	}
	else {
		vGrau		=	Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].grau;
	}

	mostrarTexto( vGrau );

	posicionarRobo	(
			 Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].direcao
			,Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].percVelocidade
			,Reacao[ getPersonalidade() ][ getReacao() ][ getMovto() ].tempo
			,vGrau
			);

	mostrarTexto( "] VelEsq [" );
	mostrarTexto( getVelocidadeEsquerdaDest() );
	mostrarTexto( "] VelDir [" );
	mostrarTexto( getVelocidadeDireitaDest() );
	mostrarTexto( "]", true );
	grauAnterior			=	vGrau;
}

int getPensamentoPadrao() {
	return pensamentoPadrao;
}
int getPensamento() {
	return pensamentoAtual;
}

int getReacao() {
	return reacaoAtual;
}

void setReacao( int pReacao ) {
	reacaoAtual		=	pReacao;

	// Inicializa a sequencia de movimentos.
	movtoCount	=	0;
	setMovto( 0 );
}

// Motores
void setMotorDireita( int pMotorDireta ) {
	motorDireita		=	pMotorDireta;
}
int getMotorDireita() {
	return	motorDireita;
}


void setMotorEsquerda( int pMotorEsquerda ) {
	motorEsquerda		=	pMotorEsquerda;
}
int getMotorEsquerda() {
	return	motorEsquerda;
}

void setVelocidadeMax( int pVelocidadeMaxima ) {
	velocidadeMax		=	pVelocidadeMaxima;
}
int getVelocidadeMax() {
	return velocidadeMax;
}

void setVelocidadeMin( int pVelocidadeMinima ) {
	velocidadeMin		=	pVelocidadeMinima;
}
int getVelocidadeMin() {
	return velocidadeMin;
}

void setFatorAltVeloc( int pFatorAltVeloc ) {
	fatorAltVeloc		=	pFatorAltVeloc;
}
int getFatorAltVeloc() {
	return fatorAltVeloc;
}

void setTempoAltVeloc( int pTempoAltVeloc ) {
	tempoAltVeloc		=	pTempoAltVeloc;
}
int getTempoAltVeloc() {
	return tempoAltVeloc;
}

// Sensores
void setSensorFrontal( int pSensorFrontal ) {
	sensorFrontal		=	pSensorFrontal;
};
int getSensorFrontal() {
	return sensorFrontal;
};

void setSensorLinha_1( int pSensorLinha_1 ) {
	sensorLinha_1		=	pSensorLinha_1;
};
int getSensorLinha_1() {
	return sensorLinha_1;
};

void setSensorLinha_2( int pSensorLinha_2 ) {
	sensorLinha_2		=	pSensorLinha_2;
};
int getSensorLinha_2() {
	return sensorLinha_2;
};

void setSensorDireita( int pSensorDireita ) {
	sensorDireita		=	pSensorDireita;
};
int getSensorDireita() {
	return sensorDireita;
};

void setSensorEsquerda( int pSensorEsquerda ) {
	sensorEsquerda		=	pSensorEsquerda;
};
int getSensorEsquerda() {
	return sensorEsquerda;
};

void setSensorTraseiro( int pSensorTraseiro ) {
	sensorTraseiro		=	pSensorTraseiro;
};
int getSensorTraseiro() {
	return sensorTraseiro;
};

void setSensorPersonalidade( int pSensorPersonalidade ) {
	sensorPersonalidade	=	pSensorPersonalidade;
};
int getSensorPersonalidade() {
	return sensorPersonalidade;
};


void setPersonalidade( int pPersonalidade ) {
	if ( personalidadeAtual != pPersonalidade &&
	     pPersonalidade <= 1 // limita as personalidade configuradas
	   ) {
		personalidadeAtual	=	pPersonalidade;
		/*
		mostrarTexto( "(setPersonalidade) " );
		if ( pPersonalidade == MALUCO ) {
			mostrarTexto( "MALUCO" );
		}
		else if ( pPersonalidade == NERVOSO ) {
			mostrarTexto( "NERVOSO" );
		}
		else if ( pPersonalidade == ZEM ) {
			mostrarTexto( "ZEM" );
		}
		else if ( pPersonalidade == MEDROSO ) {
			mostrarTexto( "MEDROSO" );
		}
		else if ( pPersonalidade == EXCENTRICO ) {
			mostrarTexto( "EXCENTRICO" );
		}
		*/
		if ( pinPersonalidade != NONE ) {
			digitalWrite( pinPersonalidade, HIGH );
			delay( 20 );
			digitalWrite( pinPersonalidade, LOW );
		}
		//mostrarTexto( " ", true );

		desativarComando( idComandoTrocarMovto );
		tempoTrocarMovto	=	0;
		ativarComando( idComandoTrocarMovto, tempoTrocarMovto );

		// Quando alteramos a personalidade temos que reposicionar os movimentos do robo de acordo com esta personalidade.
		// O setPensamentoAtual abaixo fara os ajustes a nova personalidade.
		setPensamentoAtual( getPensamentoAtual() );
	}
};
int getPersonalidade() {
	return personalidadeAtual;
};

void setPensamentoAtual( int pPensamento ) {
	//mostrarTexto( "(setPensamentoAtual) [" );
	//mostrarTexto( pPensamento );
	//mostrarTexto( "]", true );
	if ( pPensamento == NONE ) {
		pensamentoAtual		=	pensamentoPadrao;
	}
	else {
		pensamentoAtual		=	pPensamento;
	}

	// Mudamos a reacao do robo.
	setReacao( Pensamento[ getPersonalidade() ][ getPensamentoAtual() ].reacao );
}
int getPensamentoAtual() {
	return pensamentoAtual;
}

int getANDAR() {
	return ANDAR;
};

int getCORRER() {
	return CORRER;
};

int getFUGIR() {
	return FUGIR;
};

int getSEGUIR() {
	return SEGUIR;
};

int getDESVIAR() {
	return DESVIAR;
};

int getANALISAR() {
	return ANALISAR;
};

int getDEVO_ANDAR() {
	return DEVO_ANDAR;
};

int getDEVO_CORRER() {
	return DEVO_CORRER;
};

int getDEVO_FUGIR() {
	return DEVO_FUGIR;
};

int getDEVO_SEGUIR() {
	return DEVO_SEGUIR;
};

int getDEVO_DESVIAR() {
	return DEVO_DESVIAR;
};

int getDEVO_ANALISAR() {
	return DEVO_ANALISAR;
};
