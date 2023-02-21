CPP=clang++
CPPFLAGS=-std=c++20

BIN_DIR=./bin
BLD_DIR=./build
SRC_DIR=./src
INC_DIR=./include
LIB_DIR=./lib
DAT_DIR=./data

DEP=main.o LinkedList.o Time.o
DEP_ACT=$(BLD_DIR)/main.o $(BLD_DIR)/LinkedList.o $(BLD_DIR)/Time.o

COMPILE=$(CPP) $(CPPFLAGS)

# Build sort executable
insertion: $(DEP) insertion.o prep-script
	@mkdir -p $(BIN_DIR)
	$(COMPILE) $(DEP_ACT) $(BLD_DIR)/insertion.o -o $(BIN_DIR)/insertion

merge: $(DEP) merge.o prep-script
	@mkdir -p $(BIN_DIR)
	$(COMPILE) $(DEP_ACT) $(BLD_DIR)/merge.o -o $(BIN_DIR)/merge

quick: $(DEP) quick.o prep-script
	@mkdir -p $(BIN_DIR)
	$(COMPILE) $(DEP_ACT) $(BLD_DIR)/quick.o -o $(BIN_DIR)/quick

# Compile lib
%.o: $(LIB_DIR)/%.cpp $(INC_DIR)/%.h
	@mkdir -p $(BLD_DIR)
	$(COMPILE) -c $< -o $(BLD_DIR)/$@

# Compile src
%.o: $(SRC_DIR)/%.cpp $(INC_DIR)/Sort.h
	@mkdir -p $(BLD_DIR)
	$(COMPILE) -c $< -o $(BLD_DIR)/$@

# Generate sample input
generate-input:
	@sed -i -e 's/\r$$//' ./scripts/generate_data.sh
	@chmod +x ./scripts/generate_data.sh
	./scripts/generate_data.sh

# Test insertion
test-insertion: prep-script
	@sed -i -e 's/\r$$//' ./scripts/test_sort.sh
	@chmod +x ./scripts/test_sort.sh
	./scripts/test_sort.sh insertion

# Test merge
test-merge: prep-script
	@sed -i -e 's/\r$$//' ./scripts/test_sort.sh
	@chmod +x ./scripts/test_sort.sh
	./scripts/test_sort.sh merge

# Test quick
test-quick: prep-script
	@sed -i -e 's/\r$$//' ./scripts/test_sort.sh
	@chmod +x ./scripts/test_sort.sh
	./scripts/test_sort.sh quick

# Removes carriage return and makes script executable
prep-script:
	@sed -i -e 's/\r$$//' ./run_sort.sh
	@chmod +x ./run_sort.sh

# Clean build
clean:
	rm $(BIN_DIR)/* $(BLD_DIR)/*