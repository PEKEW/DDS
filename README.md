# DDS
A Dual Decomposition Strategy for Large-Scale Multiobjective Evolutionary Optimization

Since real-world problem models often have massive amounts of data. With limited computational resources, most
existing multiobjective evolutionary algorithms (MOEAs) can not solve large-scale multiobjective optimization prob-
lems (LSMOPs). This paper innovatively proposes a dual decomposition strategy ( DDS ) to enhance the perfor-
mance of MOEAs on LSMOPs. Firstly, the outer decomposition uses a sliding window to divide large-scale decision
variables into overlapped subsets of small-scale ones. A small-scale multiobjective optimization problem (MOP) is
generated every time the sliding window slides. Then, once a small-scale MOP is generated, the inner decomposi-
tion immediately creates a set of global direction vectors to transform it into a set of single-objective optimization
problems (SOPs). At last, all SOPs are optimized by adopting a block coordinate descent strategy, which guarantees
complete solutions of original LSMOPs and the currently optimal feature of solutions in the optimization process. The
proposed DDS can be embedded into many existing MOEAs. The DDS is compared with state-of-the-art large-scale
MOEAs, and the experimental has validated that the proposed DDS can deal with LSMOPs efficiently and quickly.
The results show that the DDS is very competitive on the benchmark functions even with up to 2000 decision variables
and obtains the best results in most comparisons.
