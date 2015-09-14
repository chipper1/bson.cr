require "./core_ext/*"
require "./bson/*"

module BSON

  alias ValueType = Float64 | String | Array(ValueType) | Document | ObjectId | Bool | Time | Regex | Nil | Int32 | Int64 | Binary

  TYPES = Hash{
    1 => Float64,
    2 => String,
    3 => Document,
    4 => Array(ValueType),
    5 => Binary,
    6 => Nil, # Undefined (deprecated)
    7 => ObjectId,
    8 => Bool,
    9 => Time,
    10 => Nil,
    0x0B => Regex,
    # 0x0C => DBRef, # Deprecated
    # 0x0D => Code,
    # 0x0E => Symbol, # Deprecated
    # 0x0F => CodeWithScope,
    0x10 => Int32,
    # 0x11 => Timestamp,
    0x12 => Int64
    # 0xFF => MinKey,
    # 0x7F => MaxKey
  }

  TYPES_BY_CLASS = TYPES.invert

  NULL_BYTE = 0x00

  def self.append_null_byte(bson : IO)
    bson.write(UInt8[BSON::NULL_BYTE])
  end

  def self.parse(bson : IO)
    Document.from_bson(bson)
  end

  def self.key_from_bson(bson : IO)
    bson.gets(0.chr).not_nil!.chop
  end

  def self.type_for_byte(byte)
    TYPES[byte.not_nil!]
  end

  def self.byte_for_type(type)
    TYPES_BY_CLASS[type]
  end

end
