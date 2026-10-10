KICK   = java -jar $(HOME)/tools/KickAss.jar
RD     = $(HOME)/tools/retrodebugger

.SUFFIXES:
.PRECIOUS: %.prg

# make prg and run on kickassember
%.prg: %.asm
	$(KICK) $< -vicesymbols -debugdump -showmem

# make prg
%: %.prg
	$(RD) -prg $< -autojmp -wait 1000

# build, upload and run on the Ultimate
%.u64: %.prg
	curl -sS -X POST \
	  -H "Content-Type: application/octet-stream" \
	  $(if $(U64_PASS),-H "X-Password: $(U64_PASS)") \
	  --data-binary @$< \
	  http://$(U64_IP)/v1/runners:run_prg
