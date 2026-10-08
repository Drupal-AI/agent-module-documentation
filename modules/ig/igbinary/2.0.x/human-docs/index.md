# Igbinary — manual setup guide

**Igbinary** (`igbinary`) is a drop‑in replacement for PHP's standard serializer,
exposed to Drupal as swappable serialization services. Drupal serializes
constantly — every cache entry, queue item, and key‑value record goes through
`serialize()` — and on a busy site that's a real slice of both CPU time and cache
storage. Igbinary encodes the same data structures in a compact **binary** form
instead of PHP's verbose textual one: typically around a 50% reduction in size,
with unserialization at least on par with (and often faster than) the standard
serializer.

The savings matter most when your cache backend lives over a network — Redis or
Memcached — where every byte is transfer and every millisecond of decode counts.
The module supplies the Drupal‑side services (`serialization.igbinary`,
`serialization.igbinary_gz`, and, for comparison, `serialization.phpserialize_gz`)
so a cache or queue backend can be pointed at them from `settings.php`.

Two conditions before it can help, both important:

- **It needs the igbinary PECL extension compiled into PHP.** This is an
  infrastructure decision, not a Composer one — without the extension the services
  are inert and nothing happens. (The `zlib` extension is also needed for the
  gz‑compressed variants.)
- **Existing serialized data is not readable by the new format.** Switching a live
  cache backend makes the old entries unreadable, so pair the change with a cache
  flush — and think carefully anywhere serialized data is *persisted* rather than
  cached (a queue mid‑drain, a long‑lived key‑value store).

There is **no configuration UI** — you opt in by wiring the services into your
container/`settings.php`, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — confirm the PHP extension, install the
   module with Composer, and enable it.

This module has **no settings form** — you point Drupal's serialization at its
services in code, described below.

## Where it lives in the admin menu

Igbinary adds no admin page. It registers serialization **services** that you
reference from `settings.php` (or a services YAML file), typically to make a cache
or queue backend serialize with igbinary instead of PHP's default.

## How to use it

1. Make sure the **igbinary PECL extension** is installed in your PHP runtime (and
   `zlib` for the compressed variants).
2. Enable the module (see [Installation](installation/index.md)).
3. Point the relevant backend at one of the module's services —
   `serialization.igbinary` (binary) or `serialization.igbinary_gz` (binary +
   gzip) — from `settings.php`/your services configuration.
4. **Flush caches** after switching, since data serialized in the old format is
   not readable by the new one.
