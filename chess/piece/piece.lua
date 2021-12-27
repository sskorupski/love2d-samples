-- Meta class
Piece = {column = "A", row = 1, image = "", scale = 1}

-- Derived class method new

function Piece:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Piece:columnIndex()
    return string.byte(self.column) - string.byte("A") + 1
end

return Piece