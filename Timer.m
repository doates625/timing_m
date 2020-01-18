classdef Timer < handle
    %TIMER Class for measuring time between events
    %   Author: Dan Oates (WPI Class of 2020)
    
    properties (Access = protected)
        start_time = 0;
    end
    
    methods (Access = public)
        function obj = Timer()
            %obj = TIMER() Construct and start to,er
            obj.tic();
        end
        
        function tic(obj)
            %TIC(obj) Start timer
            obj.start_time = tic;
        end
        
        function t = toc(obj)
            %t = TOC(obj)
            %   Return time elapsed since last tic()
            t = toc(obj.start_time);
        end
        
        function el = elapsed(obj, t)
            %el = ELAPSED(obj, t)
            %   Return true if t seconds have elapsed since last tic()
            el = (obj.toc() >= t);
        end
        
        function wait(obj, t)
            %WAIT(obj, t)
            %   Pause program until t seconds have elapsed since last tic()
            while ~obj.elapsed(t)
                continue
            end
        end
    end
end