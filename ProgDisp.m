classdef ProgDisp < handle
    %ProgDisp Class for reporting progress of long algorithms
    %   
    %   This class periodically prints the progress of an algorithm and the expected execution time
    %   remaining at a configurable time interval.
    %   
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (Access = protected)
        d_print;    % Print duration [s]
        t_init;     % Time of reset [s]
        t_print;    % Time of last print [s]
    end
    
    methods (Access = public)
        function obj = ProgDisp(d_print)
            %obj = PROGDISP(interval)
            %   Construct and start tracker
            %   
            %   Inputs:
            %   - d_print = Print interval [s]
            obj.d_print = d_print;
            obj.start();
        end
        
        function start(obj)
            %START(obj) Start (or reset) progress tracking
            obj.t_init = tic();
            obj.t_print = 0;
        end
        
        function printed = update(obj, prog)
            %printed = UPDATE(obj, prog)
            %   Update progress tracker
            %   
            %   Inputs:
            %   - prog = Progress ratio [0, 1]
            %   
            %   Outputs:
            %   - printed = Flag indicating print [logical]
            t_now  = toc(obj.t_init);
            printed = t_now - obj.t_print > obj.d_print;
            if printed
                obj.t_print = t_now;
                d_left = (1.0 - prog) * t_now / prog;
                if d_left > 86400
                    str = sprintf('%.1f day(s)', d_left / 86400);
                elseif d_left > 3600
                    str = sprintf('%.1f hour(s)', d_left / 3600);
                elseif d_left > 60
                    str = sprintf('%.1f min(s)', d_left / 60);
                else
                    str = sprintf('%.1f sec(s)', d_left);
                end
                prog = prog * 100.0;
                fprintf('Progress; %.3f%%, Time left: %s\n', prog, str);
            end
        end
    end
end