local webhookURL = Config.DiscordWebhookURL
local logFile = 'performance_log.txt'

-- Function to send message to Discord
local function sendToDiscord(message)
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        content = message
    }), { ['Content-Type'] = 'application/json' })
end

-- Function to log message to a file
local function logToFile(message)
    local file = io.open(logFile, "a")
    if file then
        file:write(message .. "\n")
        file:close()
    end
end

CreateThread(function()
    while true do
        local resourceList = GetNumResources()
        local performanceData = {}

        for i = 0, resourceList - 1 do
            local resource = GetResourceByFindIndex(i)
            local time = GetResourcePerfTime(resource)
            performanceData[#performanceData + 1] = { name = resource, time = time }
        end

        -- Sort the data by time in descending order
        table.sort(performanceData, function(a, b) return a.time > b.time end)

        -- Prepare message
        local message = 'Top 10 Poorest Performing Scripts:\n'
        for i = 1, math.min(10, #performanceData) do
            message = message .. string.format('%d. %s - %dms\n', i, performanceData[i].name, performanceData[i].time)
        end

        -- Output to console
        print(message)

        -- Log to file
        logToFile(message)

        -- Send to Discord
        sendToDiscord(message)

        Wait(600000) -- Run every 10 minutes
    end
end)
