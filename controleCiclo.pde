#define NONE	-1

int	 qtdeCiclos	=	0
	,qtdeComando	=	-1
	;
//estadoComando
	#define comandoDesligado	0
	#define comandoLigado		1

#define mtxComando	30
struct	{
	int		 cicloInicial
			,contadorCiclo
			,estadoComando
			,intervaloMinimo
			;
	unsigned long	millisInicial;
	}
	Comando[ mtxComando ];

void inicializaCiclos () {
	/*
		Inicializa o controle de Loop
	*/
	qtdeCiclos = 1;
}

/*
	Configura o comando.
*/
int incluirComando ( int pIntervaloMin ) {
	qtdeComando++;

	if ( qtdeComando <= ( mtxComando - 1 ) ) {
		Comando[ qtdeComando ].intervaloMinimo	=	pIntervaloMin;
		Comando[ qtdeComando ].cicloInicial	=	0;
		Comando[ qtdeComando ].contadorCiclo	=	0;
		Comando[ qtdeComando ].estadoComando	=	comandoDesligado;
		Comando[ qtdeComando ].millisInicial	=	0;

		//mostrarTexto( "(incluirComando) Comando [" );
		//mostrarTexto( qtdeComando );
		//mostrarTexto( "] intervalo [" );
		//mostrarTexto( Comando[ qtdeComando ].intervaloMinimo );
		//mostrarTexto( "]", true );

		return qtdeComando;
	}
	else {
		return NONE;
	}
}

/*
	Marca o comando como iniciado e registro em que ciclo se iniciou.
	Quando aberto conta os ciclos para ser usado no loop interno do comando.
*/
void ativarComando	(
			 int pComando
			) {
	ativarComando( pComando, NONE );
}

void ativarComando	(
			 int pComando
			,int pIntervaloEspera
			) {
	if ( Comando[ pComando ].estadoComando == comandoDesligado ) {
		Comando[ pComando ].estadoComando		=	comandoLigado;
		Comando[ pComando ].contadorCiclo		=	0;
		Comando[ pComando ].millisInicial		=	millis();

		//mostrarTexto( "(ativaComando) Comando [" );
		//mostrarTexto( pComando );
		//mostrarTexto( "] TempoIni [" );
		//mostrarTexto( Comando[ pComando ].millisInicial );
		if ( pIntervaloEspera != NONE ) {
			Comando[ pComando ].intervaloMinimo	=	pIntervaloEspera;
			//mostrarTexto( "] Intervalo NOVO [" );
			//mostrarTexto( Comando[ pComando ].intervaloMinimo );
		}
		//else {
			//mostrarTexto( "] Intervalo [" );
			//mostrarTexto( Comando[ pComando ].intervaloMinimo );
		//}
  		//mostrarTexto( "]", true );
	}
}

/*
	Analisa o millis() do inicio e o atual para saber se devemos executar novamente o comando.
*/
boolean podeExecutarComando( int pComando ) {
	podeExecutarComando( pComando, true );
}

boolean podeExecutarComando( int pComando, boolean condicaoExterna ) {
	unsigned long	diferenca	=	millis() - Comando[ pComando ].millisInicial;

	//mostrarTexto( "(podeExecutarComando) Comando [" );
	//mostrarTexto( pComando );
	//mostrarTexto( "] Dif [" );
	//mostrarTexto( diferenca );
	//mostrarTexto( "] Intervalo [" );
	//mostrarTexto( Comando[ pComando ].intervaloMinimo );
	//mostrarTexto( "]" );

	// Controla o tempo de intervalo entre execucoes do mesmo comando.
	if ( condicaoExterna &&
	     Comando[ pComando ].estadoComando == comandoLigado &&
	     (
	       // Esperou o tempo suficiente, configurado.
	       ( ( diferenca ) >= Comando[ pComando ].intervaloMinimo
	       ) ||
	       // Nao ha intervalo minimo entre as execucoes.
	       ( Comando[ pComando ].intervaloMinimo == -1
	       )
	     )
	   ) {
		// Primeira execução. Registramos o ciclo inicial.
		if ( Comando[ pComando ].contadorCiclo == 0 ) {
			Comando[ pComando ].cicloInicial	=	qtdeCiclos;
		}
		Comando[ pComando ].contadorCiclo ++;
		Comando[ pComando ].millisInicial		=	millis();

		//mostrarTexto( " TRUE Ciclos [" );
		//mostrarTexto( Comando[ pComando ].contadorCiclo );
		//mostrarTexto( "]", true );

		return true;
	}
	else {
		//mostrarTexto( " FALSE ignorado", true );
		return false;
	}
}

/*
	Retorna o ciclo atual para os comandos.
*/
int cicloAtual( int pComando ) {
	return( Comando[ pComando ].contadorCiclo );
}

/*
	Marca o comando como finalizado.
*/
void desativarComando ( int pComando ) {
	if ( Comando[ pComando ].estadoComando == comandoLigado ) {
		//mostrarTexto( "(desativaComando) Comando [" );
		//mostrarTexto( pComando );
		//mostrarTexto( "]", true );

		Comando[ pComando ].cicloInicial	=	0;
		Comando[ pComando ].contadorCiclo	=	0;
		Comando[ pComando ].estadoComando	=	comandoDesligado;
		Comando[ pComando ].millisInicial	=	0;
	}
}

boolean comandoAtivo( int pComando ) {
	if ( Comando[ pComando ].estadoComando == comandoLigado ) {
		return true;
	}
	else {
		return false;
	}
}

boolean temComandoAberto () {
	boolean retorno = false;
	for( int i = 0; i <= qtdeComando; i++ )  {
		//mostrarTexto( "(temComandoAberto) Comando [" );
		//mostrarTexto( i );
		//mostrarTexto( "] Estado [" );
		//mostrarTexto( Comando[ i ].estadoComando );
		//mostrarTexto( "] Ciclo [" );
		//mostrarTexto( Comando[ i ].contadorCiclo );
		//mostrarTexto( "]", true );

		if ( Comando[ i ].estadoComando == comandoLigado &&
		     Comando[ i ].cicloInicial > 0
		   ) {
			retorno = true;
		 }
	}
	
	return retorno;
}

void fimCiclo () {
	if ( temComandoAberto() ) {
		qtdeCiclos++;
	}
	else {
		// nao existindo comando ativo, zeramos o controle de cliclos.
		qtdeCiclos = 1;
	}

	//mostrarTexto( "(fimCiclo) [" );
	//mostrarTexto( qtdeCiclos );
	//mostrarTexto( "] agora [" );
	//mostrarTexto( millis() );
	//mostrarTexto( "]", true );
}
