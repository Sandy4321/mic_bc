CXX = icpc
CXXFLAGS = -Wall -std=c++11 -qoffload -O2 -mavx -qopenmp -g 
#CXXFLAGS+= -fimf-precision=high 

LIBS = 
LDFLAGS = -offload-option,mic,compiler,"-z defs -lpthread"
PROG = mic_bc.out

all : $(PROG)

OBJS = Main.o ParseArgs.o Graph.o GraphUtility.o TimeCounter.o CPU_BC.o MIC_BC.o MIC_Calc_Function.o

%.o: %.cpp %.h Makefile
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(PROG) : ${OBJS}
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ $(LIBS) -o $@
#	strip ${PROG}
clean :
	rm -f *.o *~ $(PROG)
