<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Cache adds cache metadata (max-age, contexts, tags) to field formatter settings.

---

Field Cache **adds cache metadata to field formatters** — letting builders set cache max-age, contexts and
tags on a field formatter's settings and applying them to the field's render output, for fine-grained field-level
caching. It works across core 9–11.

Use it to tune field caching. It is a performance/developer feature; it sets render cache metadata and has no
content or access role. Note: incorrect cache contexts/tags can cause stale or over-varied output — set them
carefully. Configure the field cache settings.

---

- Add cache metadata to field formatters.
- Set max-age/contexts/tags.
- Enable field-level caching.
- Serve performance/developers.
- Apply cache metadata.
- Tune field caching.
- Set render cache metadata.
- Set contexts/tags carefully (wrong values cause stale/over-varied output).
- Have no content/access role.
- Configure the field cache settings.
- Handle field caching.
- Cache fields.
- Configure the cache.
- Set metadata.
- Handle the formatter.
- Tune caching.
- Configure performance.
- Handle the cache.
- Vary output.
- Provide field caching.
