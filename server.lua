local resources = GetNumResources()
local webhookURL = Config.DiscordWebhookURL
local logFile = 'performance_log.txt'

-- Function to get memory usage of a resource
local function getResourceMemoryUsage(resourceName)
    return GetResourceMemoryUsage(resourceName) or 0
end

-- Function to get resource start time
local function getResourceStartTime(resourceName)
    local start = os.clock()
    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        local timeTaken = os.clock() - start
        local message = ('[Performance Analyzer] Resource %s started in %d ms'):format(resourceName, timeTaken * 1000)
        print(message)
        sendToDiscord(message)
        logToFile(message)
    end)
end

-- Function to log messages to a file
local function logToFile(message)
    local file = io.open(logFile, "a")
    if file then
        file:write(message .. "\n")
        file:close()
    end
end

-- Function to send message to Discord
local function sendToDiscord(message)
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        content = message
    }), { ['Content-Type'] = 'application/json' })
end

-- Event handler for resource start
AddEventHandler('onResourceStart', function(resourceName)
    getResourceStartTime(resourceName)
end)

-- Event handler for resource stop
AddEventHandler('onResourceStop', function(resourceName)
    local message = ('[Performance Analyzer] Resource %s stopped'):format(resourceName)
    print(message)
    sendToDiscord(message)
    logToFile(message)
end)

-- Function to get txAdmin server performance data
local function getTxAdminPerformanceData()
    PerformHttpRequest('http://localhost:40120/performance', function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            local message = ('[Performance Analyzer] txAdmin Performance Data: %s'):format(json.encode(data))
            print(message)
            sendToDiscord(message)
            logToFile(message)
        else
            local message = '[Performance Analyzer] Failed to get txAdmin performance data'
            print(message)
            sendToDiscord(message)
            logToFile(message)
        end
    end, 'GET', '', {['Authorization'] = 'Basic YOUR_API_KEY'})
end

-- Function to get QB-Core performance data (example)
local function getQBPerformanceData()
    -- Example function for QB-Core performance data retrieval
    -- Replace with actual QB-Core function or export
    if exports['qb-core'] then
        local data = exports['qb-core']:GetPerformanceData() -- This is a placeholder
        local message = ('[Performance Analyzer] QB-Core Performance Data: %s'):format(json.encode(data))
        print(message)
        sendToDiscord(message)
        logToFile(message)
    end
end

-- Main performance monitoring loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(config.sampleInterval)
        
        -- Collect and print memory usage
        collectgarbage()
        local message = ('[Performance Analyzer] Memory usage: %d KB'):format(collectgarbage('count'))
        print(message)
        sendToDiscord(message)
        logToFile(message)
        
        -- Get and print txAdmin performance data
        getTxAdminPerformanceData()
        
        -- Get and print QB-Core performance data
        getQBPerformanceData()
        
        -- Iterate through resources and print their memory usage
        for i = 0, resources - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if resourceName then
                local memoryUsage = getResourceMemoryUsage(resourceName)
                local message = ('[Performance Analyzer] Resource %s memory usage: %d KB'):format(resourceName, memoryUsage)
                print(message)
                sendToDiscord(message)
                logToFile(message)
            end
        end
    end
end)
