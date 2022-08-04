classdef DDS < ALGORITHM
    % A Dual Decomposition Strategy 
    % Author: PeiKeWang
    % Last Modified: 2022.08.04
    % Algorithmorithm For: <multi> <large>
    % Parameters:
        % It <Number of Iterations>: 10
        % s_t <Start Tage of DDS>: 40000/40000/1000000/2000000 <-> D: 200/500/1000/2000
        % s <step of Sliding Window>: 50
        % w <Size of Sliding Window>: 150
    
    methods
        function main(Algorithmorithms, Problems)
            % Parameters Setting
            delta = 0.9;
            nr = 2;
            [It,s_t,s,w] = Algorithm.ParameterSet(10,1,40000,50,150);

            [W,Problems.N] = UniformPoint(Problems.N,Problems.M);
            T = ceil(Problems.N/10);
            B = pdist2(W,W);
            [~,B] = sort(B,2);
            B = B(:,1:T);
            Population = Problems.Initialization();
            Z = min(Population.objs,[],1);

            Gen=0;

            while Algorithm.NotTerminated(Population)

                % DDS-$A$
                Population = A(Population)
                
                % DDS BEGIN
                if Algorithm.pro.FE ~=Algorithm.pro.maxFE && Algorithm.pro.FE > s_t
                    while Gen < It
                        Gen = Gen + 1;
                        Point = 1;
                        while Point < Problems.D
                            EndPoint = min(Pro.D,Point+w);
                            Pop = Population.decs;
                            CD_Pop = Pop(:,Point:EndPoint);
                            for i = 1 : Problems.N
                                if rand < delta
                                    P = B(i,randperm(end));
                                else
                                    P = randperm(Pro.N);
                                end
                                CopyD = Problems.D;
                                CopyLower = Problems.lower;
                                CopyUpper = Problems.upper;
                                EndPoint = min(Problems.D,Point+w);
                                Problems.upper = Problems.upper(Point:EndPoint);
                                Problems.lower = Problems.lower(Point:EndPoint);
                                Problems.D = EndPoint-Point+1;
                                CDOffspring = DE(CD_Pop(i,:),CD_Pop(P(1),:),CD_Pop(P(2),:));
                                Problems.upper = CopyLower;
                                Problems.lower = CopyUpper;
                                Problems.D = CopyD;
                                Offspring = SOLUTION([Pop(i,1:Point-1) CDOffspring Pop(i,EndPoint+1:end)]);
                                Z = min(Z,Offspring.obj);
                                g_old = max(abs(Population(i).objs - Z).*W(i,:),[],2);
                                g_new = max(abs(Offspring.objs - Z).*W(i,:),[],2);
                                if g_old  > g_new
                                    Population(i) = Offspring;
                                end
                            end
                            Point = Point+s;
                        end
                        Point = 1;
                    end
                    Gen=0;
                end
                % DDS END
            end
        end
    end
end
