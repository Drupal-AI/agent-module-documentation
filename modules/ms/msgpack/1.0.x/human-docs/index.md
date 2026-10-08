# MessagePack — manual setup guide

**MessagePack** (`msgpack`) is a small developer‑oriented module that registers a
**MessagePack serialization service** in Drupal, backed by the `msgpack` PHP
extension. MessagePack is an efficient binary serialization format — think of it
as a faster, smaller cousin of JSON: small integers encode into a single byte and
short strings need just one extra byte, so the encoded output is compact and
quick to read and write.

The module provides a single service, `serialization.msgpack`, implemented by the
class `Drupal\msgpack\Serialization\MessagePack`. It implements Drupal's standard
serialization interfaces (`SerializationInterface` and
`ObjectAwareSerializationInterface`) and simply delegates encoding and decoding to
the extension's `msgpack_pack()` and `msgpack_unpack()` functions, reporting the
file extension `msgpack`. It is meant to be *consumed* by other subsystems — for
example as a cache serializer, or by any module that accepts a serialization
service — rather than used directly by a site builder.

Because of that, there is **no user interface, no settings form, no routes, and
no permissions**. Enabling the module makes the service available; the useful work
happens when another module or a service definition points at
`serialization.msgpack`. One security note worth knowing: `msgpack_unpack()` can
reconstruct PHP objects when the extension is configured to allow it, so — as with
any binary deserializer — only ever feed it data you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the PHP extension, require the
   module with Composer, and enable it.

This module has **no configuration page** — it has no settings form. Once enabled,
you wire the `serialization.msgpack` service into whichever consumer needs it,
using your normal service configuration.

## Where it lives in the admin menu

MessagePack adds no admin page. Its only footprint is the
`serialization.msgpack` service in the container.
