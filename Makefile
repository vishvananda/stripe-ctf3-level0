TARGET = level0
CXX = g++
CC_FLAGS = -std=gnu++11 -Wall -Wno-write-strings -Wno-unused-result -O3 -static-libgcc
SRC = src
INC = -I$(SRC)
OBJ = obj
VPATH = $(SRC)

common_objs = $(patsubst %.cpp, $(OBJ)/$(1)/%.o, $(notdir $(wildcard $(SRC)/*.cpp)))

all: $(TARGET) $(TARGET)-debug

$(TARGET): $(OBJ)/release $(TARGET).cpp $(call common_objs,release)
	$(CXX) $(CC_FLAGS) $(INC) -o $(TARGET) $(TARGET).cpp $(call common_objs,release)

$(TARGET)-debug: CC_FLAGS += -D_DEBUG -g -pg
$(TARGET)-debug: $(OBJ)/debug $(TARGET).cpp $(call common_objs,debug)
	$(CXX) $(CC_FLAGS) $(INC) -o $(TARGET)-debug $(TARGET).cpp $(call common_objs,debug)

$(OBJ)/release $(OBJ)/debug: %:
	@- mkdir -p $@

$(OBJ)/release/%.o: %.cpp Makefile
	$(CXX) $(CC_FLAGS) $(INC) -c -o $@ $<

$(OBJ)/debug/%.o: %.cpp Makefile
	$(CXX) $(CC_FLAGS) $(INC) -c -o $@ $<

# test $(TARGET) application
test: $(TARGET)
	test/harness level0-ws8xCiPURG

../dev/$(TARGET):
	cd ../dev
	make

test-debug: $(TARGET)
	test/harness level0-ws8xCiPURG

clean:
	rm $(TARGET) $(TARGET)-debug $(OBJ)/release/*.o $(OBJ)/debug/*.o

