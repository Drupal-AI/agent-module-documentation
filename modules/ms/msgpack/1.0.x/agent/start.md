<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MessagePack (msgpack) — agent index

**Registers a `serialization.msgpack` service backed by the msgpack PHP extension.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10.3 || ^11
- **Requires:** PECL `msgpack` PHP extension.
- **Service:** `serialization.msgpack` → `Drupal\msgpack\Serialization\MessagePack` (implements `SerializationInterface`, `ObjectAwareSerializationInterface`).
- **Security:** library-only module; no routes, permissions, config or UI. `decode()`/`msgpack_unpack()` can rebuild PHP objects — only deserialize trusted data.
