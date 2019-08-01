drive = peripheral.wrap("bottom")
mon1 = peripheral.wrap("top")
k1 = 1024
k4 = k1 * 4
k16 = k1 * 16
k64 = k1 * 64
list = drive.getAvailableItems()
totalSize = 0
totalUsed = 0

mon1.clear()

function splitString(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
  end

for number, item in pairs(list) do
    totalUsed = totalUsed + item.count / 4

    name = splitString(item.name, "_")
    size = name[#name]

    if size == "1k" then
        totalSize = totalSize + k1
    elseif size == "4k" then
        totalSize = totalSize + k4
    elseif size == "16k" then
        totalSize = totalSize + k16
    elseif size == "64k" then
        totalSize = totalSize + k64
    else
        error("Drive size not recognized")
    end
end

freeSpace = totalSize – totalUsed
freePerc = round((totalUsed / totalSize) * 100)

mon1.setCursorPos(1,1)
mon1.write(“Total Bytes: “)
mon1.setCursorPos(20,1)
mon1.write(k64)

mon1.setCursorPos(1,2)
mon1.write(“Used Bytes: “)
mon1.setCursorPos(20,2)
mon1.write(totalUsed)

mon1.setCursorPos(1,3)
mon1.write(“Space Remaining: “)
mon1.setCursorPos(20,3)
mon1.write(freeSpace)
