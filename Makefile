
all: rdjpeg.o histo.o apply_ann.o
	cc -o histo rdjpeg.o histo.o
	cc -o apply_ann apply_ann.o

histo.o: histo.c
	cc -c histo.c

apply_ann.o: apply_ann.c
	cc -c apply_ann.c

rdjpeg.o: rdjpeg.h rdjpeg.c
	cc -c rdjpeg.c

clean:
	rm -f ./*.o
	rm -f ./histo
	rm -f ./apply_ann