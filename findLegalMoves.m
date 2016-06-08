function [ legal_moves] = findLegalMoves( Board, colour)

% Initialisierung: 

[rowOpponent, colOpponent] = find(Board==-colour);
emptyFields = zeros(8,8);
legalFields = zeros(8,8);

for m = 1:numel(rowOpponent)
    rowIdx = rowOpponent(m); colIdx = colOpponent(m);
    checkLeftRightFlag = 1; checkUpDownFlag = 1;
    if colIdx == 1 || colIdx == 8
        checkLeftRightFlag = 0;
    end
     
    if rowIdx == 1 || rowIdx == 8
        checkUpDownFlag = 0;
    end
    
% search direction: left
if checkLeftRightFlag
    tempField = Board(rowIdx, colIdx-1);
    
    if tempField == 0
        emptyFields(rowIdx, colIdx-1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_colIdx < 8
            if Board(search_rowIdx, search_colIdx+1) == colour
                legalFields(rowIdx, colIdx-1) = 1;
                break;
            elseif Board(search_rowIdx, search_colIdx+1) == -colour
                search_colIdx = search_colIdx + 1;
            else
                break;
            end
        end
    end
end
% search direction: right
if checkLeftRightFlag
    tempField = Board(rowIdx, colIdx+1);
    if tempField == 0
        emptyFields(rowIdx, colIdx+1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_colIdx > 1
            if Board(search_rowIdx, search_colIdx-1) == colour
                legalFields(rowIdx, colIdx+1) = 1;
                break;
            elseif Board(search_rowIdx, search_colIdx-1) == -colour
                search_colIdx = search_colIdx - 1;
            else
                break;
            end
        end
    end
end
%     search direction: up
if checkUpDownFlag
    tempField = Board(rowIdx-1, colIdx);
    if tempField == 0
        emptyFields(rowIdx-1, colIdx) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx < 8
            if Board(search_rowIdx+1, search_colIdx) == colour
                legalFields(rowIdx-1, colIdx) = 1;
                break;
            elseif Board(search_rowIdx+1, search_colIdx) == -colour
                search_rowIdx = search_rowIdx + 1;
            else
                break;
            end
        end
    end
end
%     search direction: down
if checkUpDownFlag
    tempField = Board(rowIdx+1, colIdx);
   if tempField == 0
        emptyFields(rowIdx+1, colIdx) = 1;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx >1
            if Board(search_rowIdx-1, search_colIdx) == colour
                legalFields(rowIdx+1, colIdx) = 1;
                break;
            elseif Board(search_rowIdx-1, search_colIdx) == -colour
                search_rowIdx = search_rowIdx - 1;
            else
                break;
            end
        end
   end
end
%     search direction: upper left
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx-1, colIdx-1);
    if tempField == 0
        emptyFields(rowIdx-1, colIdx-1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx < 8 && search_colIdx < 8
            if Board(search_rowIdx+1, search_colIdx+1) == colour
                legalFields(rowIdx-1, colIdx-1) = 1;
                break;
            elseif Board(search_rowIdx+1, search_colIdx+1) == -colour
                search_colIdx = search_colIdx + 1;
                search_rowIdx = search_rowIdx + 1;
            else
                break;
            end
        end
    end
end
    
%     search direction: upper right
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx-1, colIdx+1);
    if tempField == 0
%         emptyFields(rowIdx-1, colIdx+1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx < 8 && search_colIdx > 1
            if Board(search_rowIdx+1, search_colIdx-1) == colour
                legalFields(rowIdx-1, colIdx+1) = 1;
                break;
            elseif Board(search_rowIdx+1, search_colIdx-1) == -colour
                search_colIdx = search_colIdx - 1;
                search_rowIdx = search_rowIdx + 1;
            else
                break;
            end
        end
    end
end
%    search direction: lower left
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx+1, colIdx-1);
    if tempField == 0
        emptyFields(rowIdx+1, colIdx-1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx > 1 && search_colIdx < 8
            if Board(search_rowIdx-1, search_colIdx+1) == colour
                legalFields(rowIdx+1, colIdx-1) = 1;
                break;
            elseif Board(search_rowIdx-1, search_colIdx+1) == -colour
                search_colIdx = search_colIdx + 1;
                search_rowIdx = search_rowIdx - 1;
            else
                break;
            end
        end
    end
end

%     search direction: lower right
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx+1, colIdx+1);
    if tempField == 0
        emptyFields(rowIdx+1, colIdx+1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx > 1 && search_colIdx > 1
            if Board(search_rowIdx-1, search_colIdx-1) == colour
                legalFields(rowIdx+1, colIdx+1) = 1;
                break;
            elseif Board(search_rowIdx-1, search_colIdx-1) == -colour
                search_colIdx = search_colIdx - 1;
                search_rowIdx = search_rowIdx - 1;
            else
                break;
            end
        end
    end
end

end
assignin('base', 'board', Board);
assignin('base', 'emptyFields', emptyFields);
assignin('base', 'legalFields', legalFields);   

% numLegalMoves = sum(legalFields(:));
[rowLegalMove, colLegalMove] = find(legalFields==1);
legal_moves = [rowLegalMove, colLegalMove];
end






