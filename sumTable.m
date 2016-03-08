classdef sumTable

    properties
        summarytable
    end
    
    methods
        function Obj = sumTable()
            Obj.summarytable = cell(0);
        end

        function addEntry(Obj,entryCell)
            [n m] = size(Obj.summarytable);
            Obj.summarytable{n+1,1} = entryCell{1,1};
            Obj.summarytable{n+1,2} = entryCell{1,2};
            Obj.summarytable
        end
    end
end


