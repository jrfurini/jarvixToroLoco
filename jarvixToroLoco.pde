#define NONE			255

void setup() {
	inicializaCiclos ();

	ativarLog( true, 0 );

	//  Robo
	roboAtivar	(
		// Motores
					//PWM   Input 1   Input 2    Fator
			// pMotorDireta
			 incluirMotor(      6,        9,       13,       0 )
			// pMotorEsquerda
			,incluirMotor(      5,        8,        7,       0 )
		// Configuracoes de seguranca para os motores
			// pVelocidadeMinima
			,0
			// pVelocidadeMaxima
			,255
			// pFatorAltVeloc
			,25
			// pTempoAltVeloc
			,10
		// Sensores
					//pPin  pPinServo  pRepeticao    pIntervaloRepeticao         pEstiloMovtoServo  pMenorConversao  pMaiorConversao              pTipoSensor    pIntervaloMinimoExec       pTipoLeitura
			// pSensorFrontal
			,incluirSensor(     10,        11,          1,                  NONE, getMovtoServoVarredura(),            NONE,            NONE,           getTipoPING(),                    300,   getCentimetros() )
			// pSensorLinha_1
			,NONE			//incluirSensor(    5,      NONE,          1,                  NONE,       getSemMovtoServo(),             200,             800,  getTipoAnalogico(),                    100, getLeituraPadrao() )
			// pSensorLinha_2
			,NONE
			// pSensorDireita
			,NONE
			// pSensorEsquerada
			,NONE
			// pSensorTraseiro
			,NONE			// incluirSensor(    4,        11,          3,                  NONE, getMovtoServoVarredura(),            NONE,            NONE,        getTipoEZ1(),                    150,   getCentimetros() )
		// Personalidade
			// pSensorPersonalidade
			,incluirSensor(    1,      NONE,          1,                  NONE,         getSemMovtoServo(),               0,            1023,      getTipoAnalogico(),                   300,   getLeituraPadrao() )
			// pPinPersonalidade
			,12
		// Configuracao de movimento padrao
			// pPensamentoPadrao
			,getDEVO_ANDAR()
			);
	//roboAutoTeste();
}

void loop() {
	/*
		Analisar ambiente.
	*/
	roboAnalisar();

	/*
		Decisao
	*/
	roboPensar();

	/*
		Movimento
	*/
	roboIr();

	fimCiclo();
}

