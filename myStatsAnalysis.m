function stats = myStatsAnalysis(data)
    % Find maximum
    stats.max = max(data);
    
    % Find minimum
    stats.min = min(data);
    
    % Find mean
    stats.mean = mean(data);
    
    % Find median
    stats.median = median(data);
    
    % Find mode
    [mode_val, freq] = mode(data);
    if freq == 1
        stats.mode = NaN;
    else
        stats.mode = mode_val;
    end
    
    % Find standard deviation
    stats.std = std(data);
    
    % Find variance
    stats.var = var(data);
    
    % Find count
    stats.count = length(data);
end

