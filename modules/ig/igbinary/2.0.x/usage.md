<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Igbinary registers swappable Drupal serialization services backed by the igbinary PHP extension and zlib compression, so a cache, key/value, or queue backend can store its data in a compact binary form instead of PHP's textual `serialize()` output.

---

Drupal serializes constantly — every cache entry, key/value record, and queue item goes through a serializer, and on a busy site that is a measurable share of both CPU and storage. This module supplies three drop-in `SerializationInterface` services: `serialization.igbinary` (igbinary binary encoding), `serialization.igbinary_gz` (igbinary plus zlib compression), and `serialization.phpserialize_gz` (standard PHP serialize plus compression, for hosts without the igbinary extension). Igbinary typically yields a large reduction in serialized size and faster unserialization, which matters most where the backend is over a network such as Redis or Memcached and every byte is transfer. The module itself changes nothing until you wire a backend to one of its services, either by including the shipped `example.services.yml` from `settings.php` (`$settings['container_yamls'][]`) or by copying backend-factory overrides into `sites/default/services.yml`. A single settings value, `igbinary_compress_level` (default 1), tunes the zlib level for the compressed variants. Two conditions apply: the `serialization.igbinary*` services need the igbinary PECL extension compiled into PHP (an infrastructure decision, declared as `ext-igbinary`/`ext-zlib` in composer.json), and although reads auto-detect old formats, switching a live cache backend is best paired with a cache rebuild. This branch has no stable release yet — the current build is 2.0.0-alpha3, core `^10.3 || ^11.0 || ^12`.

---

- Reduce cache entry size.
- Speed up cache unserialization.
- Cut Redis memory usage.
- Reduce network transfer to Memcached.
- Store cache data in compact binary form.
- Compress serialized cache data with zlib.
- Point the database cache backend at igbinary.
- Point the database key/value store at igbinary.
- Point the expirable key/value store at igbinary.
- Point a Redis cache backend at igbinary.
- Reduce the database cache table size.
- Speed up queue item processing.
- Lower cache backend hosting costs.
- Improve page generation time on a busy site.
- Tune zlib compression level per environment.
- Use PHP-serialize compression where the igbinary extension is unavailable.
- Serialize large render arrays efficiently.
- Improve key/value store throughput.
- Migrate a cache backend format without a hard cutover (reads auto-detect old data).
- Compare serialization strategies during a performance audit.
- Reduce cache warm-up cost.
- Lower memory pressure from serialized data.
