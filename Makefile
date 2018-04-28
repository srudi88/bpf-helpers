PAGE = bpf-helpers
OUTPUT = out

man: $(OUTPUT)/$(PAGE).7

html: $(OUTPUT)/$(PAGE).html

$(OUTPUT)/$(PAGE).rst: include/uapi/linux/bpf.h
	@mkdir -p $(OUTPUT)
	./scripts/bpf_helpers_doc.py > $@

$(OUTPUT)/$(PAGE).7: $(OUTPUT)/$(PAGE).rst
	@mkdir -p $(OUTPUT)
	rst2man $< > $@

$(OUTPUT)/$(PAGE).html: $(OUTPUT)/$(PAGE).rst
	@mkdir -p $(OUTPUT)
	sed '/\\$$/{N;s/\\\n\t\t/\\ /;b}' $< | pandoc -Ss -f rst -t html -V header-includes='<style type="text/css">body { width: 800px; }</style>' -o $@

clean:
	rm -rf -- $(OUTPUT)

.PHONY: clean
