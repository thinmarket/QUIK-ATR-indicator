Settings = {
    Name = "MYATR",
    period = 14,
    line = 
    {{
        Name = "ATR",
        Color = RGB(0, 0, 0),
        Type = TYPE_HISTOGRAM,
        Width = 1
    }}
}

function Init()
    -- ВАЖНО: возвращаем ТОЛЬКО количество линий, никакого периода
    return 1
end

function OnCalculate(index)
    local period = Settings.period
    
    if index < period + 1 then
        return nil
    end
    
    local sumTR = 0
    local validCount = 0
    
    for i = index - period + 1, index do
        local high = H(i)
        local low = L(i)
        local prevClose = C(i - 1)
        
        if high and low and prevClose then
            local tr1 = high - low
            local tr2 = math.abs(high - prevClose)
            local tr3 = math.abs(low - prevClose)
            local tr = math.max(tr1, tr2, tr3)
            sumTR = sumTR + tr
            validCount = validCount + 1
        end
    end
    
    if validCount == period then
        return sumTR / period
    else
        return nil
    end
end