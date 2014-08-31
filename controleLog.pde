boolean logAtivo = true;
int nivel = 0;
int tempo = 250;

void ativarLog() {
	ativarLog( false, 0 );
}

void ativarLog( boolean pAtivar, int pTempo ) {
	logAtivo = pAtivar;
	tempo = pTempo;
	if ( pAtivar ) {
		Serial.begin(9600);
	}
}

void mostrarTexto( char pTexto[] ) {
	mostrarTexto( pTexto, false );
}
void mostrarTexto( char pTexto[], boolean pLinha ) {
	if ( logAtivo ) {
		if ( pLinha ) {
			Serial.println( pTexto );
		}
		else
		{
			Serial.print( pTexto );
		}
		delay( tempo );
	}
}

void mostrarTexto( int pTexto ) {
	mostrarTexto( pTexto, false );
}
void mostrarTexto( int pTexto, boolean pLinha ) {
	if ( logAtivo ) {
		if ( pLinha ) {
			Serial.println( pTexto );
		}
		else
		{
			Serial.print( pTexto );
		}
		delay( tempo );
	}
}

void mostrarTexto( float pTexto ) {
	mostrarTexto( pTexto, false );
}
void mostrarTexto( float pTexto, boolean pLinha ) {
	if ( logAtivo ) {
		if ( pLinha ) {
			Serial.println( pTexto );
		}
		else
		{
			Serial.print( pTexto );
		}
		delay( tempo );
	}
}

void mostrarTexto( long pTexto ) {
	mostrarTexto( pTexto, false );
}
void mostrarTexto( long pTexto, boolean pLinha ) {
	if ( logAtivo ) {
		if ( pLinha ) {
			Serial.println( pTexto );
		}
		else
		{
			Serial.print( pTexto );
		}
		delay( tempo );
	}
}

void mostrarTexto( unsigned long pTexto ) {
	mostrarTexto( pTexto, false );
}
void mostrarTexto( unsigned long pTexto, boolean pLinha ) {
	if ( logAtivo ) {
		if ( pLinha ) {
			Serial.println( pTexto );
		}
		else
		{
			Serial.print( pTexto );
		}
		delay( tempo );
	}
}

