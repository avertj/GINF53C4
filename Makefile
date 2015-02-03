
all: rdjpeg.o histo.o
	cc -o histo rdjpeg.o histo.o

histo.o: histo.c
	cc -c histo.c

rdjpeg.o: rdjpeg.h rdjpeg.c
	cc -c rdjpeg.c

clean:
	rm -f ./*.o
	rm -f ./histo