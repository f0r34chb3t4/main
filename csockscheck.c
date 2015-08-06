/**************************************************************************************
 C functions for socks 4/5 checking by Paolo Ardoino < paolo.ardoino@gmail.com >
 slchk_host is a linked list of all socks that you want to test. 
 IP must be in Ipv4 standard dot notation, port is the port of the socks and
 type is set to 5 for socks5 and 4 for socks4.

 try_socks4 and try_socks5 keep as argument a pointer to the list and return
 1 if the host is a working socks5 , 0 otherwise .
**************************************************************************************/

// These are definitions of the strings for the socks protocol
#define SOCKS4HS "\004\001%c%c%c%c%c%c"
#define SOCKS5HS "\x05\x01%c"
#define SOCKS5RQ "\x05\x01%c\x03%c%s%c%c"

struct slchk_host {
	char ip[18];
	int port;
	int type; //if type==5 use try_socks5 if type==4 use try_socks4
	struct slchk_host *next, *prev;
};

int try_socks4(struct slchk_host *hs)
{
	int sd, buflen = 0;
	struct hostent *hent;
	struct sockaddr_in sa;
	char buf[BUFFER_SIZE];
	
	if(!(hent = gethostbyname(hs->ip)))
		return 0;
	sa.sin_family = AF_INET;
	sa.sin_port = htons(hs->port);
	memcpy((char *) &sa.sin_addr.s_addr, hent->h_addr_list[0], hent->h_length);
	if ((sd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
		return 0;
	if (connect(sd, (struct sockaddr *)&sa, sizeof(struct sockaddr_in)) == -1) {
		close(sd);
		return 0;
	}
      	buflen = snprintf (buf, BUFFER_SIZE, SOCKS4HS, (hs->port >> 8) & 0xFF, hs->port & 0xFF,
		(char)hent->h_addr[0], (char)hent->h_addr[1], (char)hent->h_addr[2], (char)hent->h_addr[3]);
	SOCKSSR;
	close(sd);
	printf("buf[1]=%d\n", buf[1]);
	if(buf[1] == 90) 
		return 1;
	return 0;
}

int try_socks5(struct slchk_host *hs)
{
	int sd, buflen = 0;
	struct hostent *hent;
	struct sockaddr_in sa;
	char buf[BUFFER_SIZE];

	if(!(hent = gethostbyname(hs->ip)))
		return 0;
	sa.sin_family = AF_INET;
	sa.sin_port = htons(hs->port);
	memcpy((char *) &sa.sin_addr.s_addr, hent->h_addr_list[0], hent->h_length);
	if ((sd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
		return 0;
	if (connect(sd, (struct sockaddr *)&sa, sizeof(struct sockaddr_in)) == -1) {
		close(sd);
		return 0;
	}
	buflen = snprintf(buf, BUFFER_SIZE, SOCKS5HS, 0);
	SOCKSSR;
	if(buf[0] != 0x05 || buf[1] != 0x00) {
		close(sd);
		return 0;
	}
	buflen = snprintf(buf, BUFFER_SIZE, SOCKS5RQ, 0, strlen("www.google.it"), "www.google.it", (80 >> 8) & 0xFF, 80 & 0xFF);
	SOCKSSR;
	close(sd);
	if(buf[0] != 0x05 || buf[1] != 0x00)
		return 0;
	return 1;
	
}

