XMLS = $(wildcard *.xml)
CONFS = $(XMLS:xml=conf)
BINS = $(XMLS:xml=bin)

all : $(BINS)

%.bin : %.conf
	$(ALSATPLG) -c $< -o $@

%.conf : %.xml
	$(AVSTPLG) -c $< -o $@

.PHONY : clean
clean :
	-@rm *.bin

install:
	@mkdir -p $(DESTDIR)/lib/firmware/intel/avs
	cp *.bin $(DESTDIR)/lib/firmware/intel/avs
