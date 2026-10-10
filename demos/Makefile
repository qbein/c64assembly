KICK   = java -jar $(HOME)/tools/KickAss.jar
RD     = $(HOME)/tools/retrodebugger

.SUFFIXES:
.PRECIOUS: %.prg

# make kefren.prg  -> build only
%.prg: %.asm
	$(KICK) $< -vicesymbols -debugdump -showmem

# make kefren      -> build (if needed) and run
%: %.prg
	$(RD) -prg $< -autojmp -wait 1000

