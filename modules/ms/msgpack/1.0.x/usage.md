<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MessagePack provides a `serialization.msgpack` service implementing Drupal's serialization interfaces on top of the `msgpack` PHP extension, offering a compact binary alternative to PHP/JSON serialization.
---
The single class `Serialization\MessagePack` implements `SerializationInterface` and `ObjectAwareSerializationInterface`, delegating `encode()`/`decode()` to `msgpack_pack()`/`msgpack_unpack()` and reporting file extension `msgpack`. It is intended to be consumed by other subsystems (for example as a cache serializer) that accept a serialization service, rather than used directly by site builders.

It requires the PECL `msgpack` extension to be installed and enabled in PHP; there are no routes, permissions, config or UI. Because `msgpack_unpack()` can reconstruct PHP objects when the extension is configured to do so, only feed it trusted data (as with any binary deserializer). Setup: install the PHP extension, enable the module, and point a consumer at the `serialization.msgpack` service.
---
- Provide a MessagePack serializer service to other modules.
- Serialize data to compact binary with `encode()`.
- Deserialize MessagePack binary with `decode()`.
- Use MessagePack as a cache serialization backend.
- Reduce cache/storage size versus PHP serialize/JSON.
- Swap a service's serializer to `serialization.msgpack`.
- Encode structured data for a fast binary transport.
- Interoperate with non-PHP MessagePack consumers.
- Report the `.msgpack` file extension for outputs.
- Back an entity/queue store with MessagePack encoding.
- Speed up (de)serialization of large data structures.
- Require the msgpack PHP extension as a prerequisite.
- Provide an object-aware serialization implementation.
- Alternative to core's PHP/JSON serialization services.
- Use in performance-sensitive serialization paths.
