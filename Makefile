SOURCE_FILES=Main.hs Luhn.hs
BENCHMARK_SOURCE_FILES=Benchmark.hs
OUTPUT_FILES=$(SOURCE_FILES:hs=o)
BENCHMARK_OUTPUT_FILES=$(BENCHMARK_SOURCE_FILES:hs=o)
INTERFACE_FILES=$(SOURCE_FILES:hs=hi)
LDFLAGS=-L/usr/local/opt/llvm/lib
CPPFLAGS=-I/usr/local/opt/llvm/include
HC=ghc
HC_OPTIONS=-O3 -fllvm
HC_OUTPUT_OPTIONS=$(HC_OPTIONS) -o luhn
HC_BENCHMARK_OPTIONS=$(HC_OPTIONS) -o benchmark
EXECUTABLE=luhn
INSTALL_DIR=/usr/bin/

all: compile clean

install: all
	cp $(EXECUTABLE) $(INSTALL_DIR)

compile:
	$(HC) $(SOURCE_FILES) $(HC_OUTPUT_OPTIONS)

clean:
	rm -rf $(OUTPUT_FILES)
	rm -rf $(INTERFACE_FILES)
	rm -rf $(BENCHMARK_OUTPUT_FILES)

benchmark:
	$(HC) $(BENCHMARK_SOURCE_FILES) $(HC_BENCHMARK_OPTIONS)

realclean purge: clean
	rm -rf $(EXECUTABLE)
