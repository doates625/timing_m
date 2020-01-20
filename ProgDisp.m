classdef ProgDisp < handle
    %ProgDisp Class for reporting progress of long algorithms
    %   
    %   This class periodically displays the progress of an algorithm and the
    %   expected remaining time at a configurable interval
    %   
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (Access = protected)
        disp_int;   % Display interval [s]
        init_tmr;   % Init timer [timing.Timer]
        disp_tmr;   % Display timer [timing.Timer]
    end
    
    methods (Access = public)
        function obj = ProgDisp(disp_int)
            %obj = PROGDISP(disp_int)
            %   Construct and start tracker
            %   
            %   Inputs:
            %   - disp_int = Display interval [s]
            import('timing.Timer');
            if nargin < 1, disp_int = 1; end
            obj.disp_int = disp_int;
            obj.init_tmr = Timer();
            obj.disp_tmr = Timer();
        end
        
        function start(obj)
            %START(obj) Start (or reset) progress tracking
            obj.init_tmr.tic();
            obj.disp_tmr.tic();
        end
        
        function do_disp = update(obj, prog)
            %do_disp = UPDATE(obj, prog)
            %   Update progress tracker
            %   
            %   Inputs:
            %   - prog = Progress ratio [0, 1]
            %   
            %   Outputs:
            %   - do_disp = Display flag
            do_disp = obj.disp_tmr.elapsed(obj.disp_int);
            if do_disp
                obj.disp_tmr.tic();
                t_left = (1.0 - prog) * obj.init_tmr.toc() / prog;
                if t_left > 86400
                    str = sprintf('%.1f day', t_left / 86400);
                elseif t_left > 3600
                    str = sprintf('%.1f hour', t_left / 3600);
                elseif t_left > 60
                    str = sprintf('%.1f min', t_left / 60);
                else
                    str = sprintf('%.1f sec', t_left);
                end
                prog = prog * 100.0;
                fprintf('%.3f%% (%s)\n', prog, str);
            end
        end
    end
end