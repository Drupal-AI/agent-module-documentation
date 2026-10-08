# API: the serialization services

Three services, each a `Drupal\Component\Serialization\SerializationInterface` implementation
(they extend core `Drupal\Component\Serialization\PhpSerialize`, so `encode()`/`decode()`/
`getFileExtension()` are static). Consume them from a backend factory (see
[../configure/serializers.md](../configure/serializers.md)); you rarely call them directly.

| Service id | Class (`Drupal\igbinary\Component\Serialization\…`) | Encodes with | `getFileExtension()` |
| --- | --- | --- | --- |
| `serialization.igbinary` | `IgbinarySerialize` | `igbinary_serialize()` | `igbinary` |
| `serialization.igbinary_gz` | `IgbinaryCompressSerialize` | igbinary + `gzcompress()` | `igbinary.gz` |
| `serialization.phpserialize_gz` | `PhpCompressSerialize` | PHP `serialize()` + `gzcompress()` | `serialized.gz` |

## Encode / decode contract

`IgbinarySerialize` (base, uncompressed):

```php
public static function encode($data): string {
  return \igbinary_serialize($data) ?? '';
}
public static function decode($raw) {
  if (\strpos($raw, "\x00") === 0) {        // igbinary payload begins with NUL header
    return \igbinary_unserialize($raw);
  }
  if (\strpos($raw, ':') === 1) {           // legacy PHP-serialize value (e.g. a:3:{…})
    return parent::decode($raw);            // PhpSerialize::decode() → unserialize()
  }
  // else: returns NULL (unknown/empty payload)
}
```

The two `*Compress*` classes wrap the above with `CompressionTrait`:

```php
public static function encode($data): string { return self::compressData(parent::encode($data)); }
public static function decode($raw)          { return parent::decode(self::decompressData($raw)); }
```

## Backward-compatible auto-detection (why a switch rarely breaks reads)

- **igbinary vs. phpserialize:** `IgbinarySerialize::decode()` sniffs the payload — a leading `\x00`
  is treated as igbinary; a `:` at offset 1 falls back to core `unserialize()`. So after switching a
  backend to `serialization.igbinary*`, values written earlier by the default phpserialize serializer
  are still readable.
- **compressed vs. plain:** `CompressionTrait::decompressData()` only decompresses when the data has a
  valid zlib header — first byte `\x78` **and** `(CMF << 8 | FLG) % 31 === 0`
  (constants `BYTE_SIZE = 8`, `ZLIB_INTEGRITY_CONSTRAINT = 31`); otherwise it returns the bytes
  untouched. So a `*_gz` service transparently reads previously-uncompressed entries.
- **compress level:** `compressData()` uses `Settings::get('igbinary_compress_level', 1)` as the
  `gzcompress()` level.

These services operate on internally-produced backend data (cache, key/value, queue) — trusted,
not request input.
