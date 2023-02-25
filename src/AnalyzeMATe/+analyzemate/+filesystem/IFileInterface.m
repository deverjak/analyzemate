classdef (Abstract) IFileInterface < handle
    methods (Abstract)
        readFileAsString(obj, file)
    end
end

