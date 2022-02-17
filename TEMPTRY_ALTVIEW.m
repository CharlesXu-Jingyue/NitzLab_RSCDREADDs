for REC = 106
    FirstOrderAlt= [];
    SecondOrderAlt = [];

    NoAlt = TurnAnalysis.IsRightTurn_IntOnly{REC};

    for j = 2:size(NoAlt,2)
        for jj = 1:size(NoAlt,1)
            if NoAlt(jj,j) == 1
                if NoAlt(jj,j-1) ==0
                    FirstOrderAlt(jj,j-1) = 1;
                end
                if NoAlt(jj,j-1) ==1
                    FirstOrderAlt(jj,j-1) = 0;
                end
            end
            if NoAlt(jj,j) == 0
                if NoAlt(jj,j-1) ==0
                    FirstOrderAlt(jj,j-1) = 0;
                end
                if NoAlt(jj,j-1) ==1
                    FirstOrderAlt(jj,j-1) = 1;
                end
            end
        end
    end


    for k = 2:size(FirstOrderAlt,2)
        for kk = 1:size(FirstOrderAlt,1)
            if FirstOrderAlt(kk,k) == 1
                if FirstOrderAlt(kk,k-1) ==0
                    SecondOrderAlt(kk,k-1) = 1;
                end
                if FirstOrderAlt(kk,k-1) ==1
                    SecondOrderAlt(kk,k-1) = 0;
                end
            end
            if FirstOrderAlt(kk,k) == 0
                if FirstOrderAlt(kk,k-1) ==0
                    SecondOrderAlt(kk,k-1) = 0;
                end
                if FirstOrderAlt(kk,k-1) ==1
                    SecondOrderAlt(kk,k-1) = 1;
                end
            end
        end
    end



figure
subplot(3,1,1)
imagesc(NoAlt)
subplot(3,1,2)
imagesc(FirstOrderAlt)
subplot(3,1,3)
imagesc(SecondOrderAlt)

%pause
end

NumRuns = size(NoAlt,2);
PFirstDegreeAlt = sum(FirstOrderAlt,2)./(NumRuns-1);
PSecondDegreeAlt = sum(SecondOrderAlt,2)./(NumRuns-2);

