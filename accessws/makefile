TARGET  := accessws.exe
INCS = -I ../network -I ../utils
# LIBS = -L ../utils -lutils -L ../network -lnetwork -Wl,-Bstatic -lev -ljansson -lmpdec -lrdkafka -lz -lssl -lcrypto -lhiredis -lcurl -Wl,-Bdynamic -lm -lpthread -ldl
LIBS = -L ../utils -lutils -L ../network -lnetwork -lrdkafka -Wl,-Bstatic -lev -ljansson -lmpdec -lcurl -lz -lssl -lcrypto -lhiredis -Wl,-Bdynamic -lm -lpthread -ldl

include ../makefile.inc
