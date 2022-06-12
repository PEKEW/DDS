classdef CD < ALGORITHM
    % <multi> <real>
    % TEST CD METHOD
    % MaxGen ---    10 ---
    % CDG    ---     1 ---
    % CDM    --- 40000 ---
    % gap    ---    50 ---
    % step   ---   150 ---
    methods
        function main(Alg,Pro)
            delta = 0.9;
            nr = 2;
            [MaxGen,CDG,CDM,gap,step] = Alg.ParameterSet(10,1,40000,50,150);
            [W,Pro.N] = UniformPoint(Pro.N,Pro.M);
            T = ceil(Pro.N/10);
            B = pdist2(W,W);
            [~,B] = sort(B,2);
            B = B(:,1:T);
            Population = Pro.Initialization();
            Z = min(Population.objs,[],1);
            Point = 1;Gen=0;
            while Alg.NotTerminated(Population)
                for c = 1 : Pro.N
                    if rand < delta
                        P = B(c,randperm(end));
                    else
                        P = randperm(Pro.N);
                    end
                    Offspring = OperatorDE(Population(c),Population(P(1)),Population(P(2)));
                    Z = min(Z,Offspring.obj);
                    g_old = max(abs(Population(P).objs-repmat(Z,length(P),1)).*W(P,:),[],2);
                    g_new = max(repmat(abs(Offspring.obj-Z),length(P),1).*W(P,:),[],2);
                    disp(size(g_old))
                    Population(P(find(g_old>=g_new,nr))) = Offspring;
                end
                if Alg.pro.FE ~=Alg.pro.maxFE && CDG && Alg.pro.FE > CDM
                    CDG = CDG-1;
                    while Gen < MaxGen
                        Gen = Gen +1;
                        %% BLOCK CD PART
                        Point = 1;
%                         step = 150;
%                         gap = 50;   
%                         gap = 100;
                        while Point < Pro.D
                            %%  Proj
                            EndPoint = min(Pro.D,Point+step);
                            Pop = Population.decs;
                            CD_Pop = Pop(:,Point:EndPoint);
                            for i = 1 : Pro.N
                                if rand < delta
                                    P = B(i,randperm(end));
                                else
                                    P = randperm(Pro.N);
                                end
                                CopyD = Pro.D;
                                CopyLower = Pro.lower;
                                CopyUpper = Pro.upper;
                                EndPoint = min(Pro.D,Point+step);
                                Pro.upper = Pro.upper(Point:EndPoint);
                                Pro.lower = Pro.lower(Point:EndPoint);
                                Pro.D = EndPoint-Point+1;
                                CDOffspring = OperatorDE(CD_Pop(i,:),CD_Pop(P(1),:),CD_Pop(P(2),:));
                                Pro.upper = CopyLower;
                                Pro.lower = CopyUpper;
                                Pro.D = CopyD;
                                Offspring = SOLUTION([Pop(i,1:Point-1) CDOffspring Pop(i,EndPoint+1:end)]);
                                Z = min(Z,Offspring.obj);
                                g_old = max(abs(Population(i).objs - Z).*W(i,:),[],2);
                                g_new = max(abs(Offspring.objs - Z).*W(i,:),[],2);
                                if g_old  > g_new
                                    Population(i) = Offspring;
                                end
                            end
                            Point = Point+gap;
                        end
                        Point = 1;
                    end
                    Gen=0;
                end
            end
            
        end
    end
end



