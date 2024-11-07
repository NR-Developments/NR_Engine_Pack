-- Sets server list convar
SetConvarServerInfo('tags', 'Audio_Pack')

-- Setup for the version check
updatePath = "/NR-Developments/NR_Engine_Pack" -- your git user/repo path
versionFile = "/NR_Engine_Pack/version" -- path to the version file

-- Console stuff
Citizen.CreateThread(function()
    if GetCurrentResourceName() ~= "NR_Engine_Pack" then
        print("-----------------------------------------------------")
        print("FiveM Engine Pack By NR-Developments.")
        print("-----------------------------------------------------")
    end
    if GetCurrentResourceName() == 'NR_Engine_Pack' then
        function checkVersion(_, responseText)
            local curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

            if curVersion and responseText then
                if tonumber(curVersion) and tonumber(responseText) then
                    if tonumber(curVersion) < tonumber(responseText) then
                        print("---------- NR-Developments FiveM ----------")
                        print("Hi There Thank You For Choosing NR_DEV! ")
                        print("  Oh No! Looks like NR_Engine_Pack is outdated")
                        print("Should be: "..responseText..", currently is: "..curVersion..". Please update it from https://github.com"..updatePath.."")
                        print("-------------------------------------------")
                    elseif tonumber(curVersion) > tonumber(responseText) then
                        print("---------- NR-Developments FiveM ----------")
                        print("Hi There Thank You For Choosing NR_DEV! ")
                        print("Oh No! You skipped a few versions of Audio Pack")
                        print("Please Update As Soon As Possible")
                        print("-------------------------------------------")
                    else
                        print("---------- NR-Developments FiveM ----------")
                        print("Hi There Thank You For Choosing NR_DEV! ")
                        print("Looks Like NR_Engine_Pack is up to date, have fun!")
                        print("-------------------------------------------")
                    end
                else
                    print("Error: Unable to parse version numbers.")
                end
            else
                print("Error: Unable to load version file or receive response from GitHub API.")
            end
        end

        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/main"..versionFile, checkVersion, "GET")
    end
end)