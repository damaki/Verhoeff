OUTPUT_DIR = $(CURDIR)/out
BUILD_DIR  = $(OUTPUT_DIR)/build

################################################################################

all: build proof test

build: $(BUILD_DIR)/libverhoeff.a

proof:
	gnatprove -P build/build_libverhoeff.gpr

test: $(OUTPUT_DIR)/tests/tests_main
	$(OUTPUT_DIR)/tests/tests_main

$(BUILD_DIR)/libverhoeff.a:
	gprbuild -p -P build/build_libverhoeff
	
$(OUTPUT_DIR)/tests/tests_main:
	gprbuild -p -P build/build_tests

install: build
	install -d -m 755 $(DESTDIR)/adalib $(DESTDIR)/adainclude
	install -p -m 644 $(BUILD_DIR)/adalib/libverhoeff.a $(BUILD_DIR)/adalib/*.ali $(DESTDIR)/adalib/
	install -p -m 644 src/*.ads $(DESTDIR)/adainclude/
	install -p -m 644 build/libverhoeff.gpr $(DESTDIR)/

install_local: DESTDIR = $(OUTPUT_DIR)/verhoeff
install_local: install

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: clean all build install_local
