struct Int64
  
  def self.from_bson(bson : IO)
    bytes = Slice(UInt8).new(8)
    bson.read(bytes)
    bytes.to_i64
  end

  def to_bson(bson : IO)
    bson.write(to_bytes)
  end

  def to_bytes(type = :little_endian)
    arr = [self, self >> 8, self >> 16, self >> 24, self >> 32, self >> 40, self >> 48, self >> 56].map(&.to_u8)
    type == :little_endian ? arr : arr.reverse
  end

  def bson_size
    sizeof(typeof(Int64))
  end

end