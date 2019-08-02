TARGET  := matchengine.exe
INCS = -I ../network -I ../utils
# LIBS = -L ../utils -lutils -L ../network -lnetwork -Wl,-Bstatic -lev -ljansson -lmpdec -lmysqlclient -lz -lrdkafka -lssl -lcrypto -lhiredis -Wl,-Bdynamic -lm -lpthread -ldl
LIBS = -L ../utils -lutils -L ../network -lnetwork -lrdkafka -Wl,-Bstatic -lev -ljansson -lmpdec -lz -lssl -lcrypto -lhiredis -Wl,-Bdynamic -lm -lpthread -ldl -lmysqlclient


include ../makefile.inc
