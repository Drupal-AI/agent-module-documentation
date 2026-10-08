<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key Value Field Feeds Extension (key_value_feed_ext) — agent index

**Feeds target plugins for the `key_value` and `key_value_long` field types.**

- **Version:** 1.0.x (1.0.0-beta2) · **Core:** ^9 || ^10 || ^11 · **Depends:** feeds, key_value_field
- **Plugins:** `KeyValue` (id `key_value`) and `KeyValueLong` — `@FeedsTarget` mappers exposing `key`, `value`, `description`; `key` is a unique property (usable for de-dup).
- **Behavior:** `prepareValue()` trims `key`, skips blank-key deltas, string-casts `value`/`description`.
- **Routes/permissions/config:** none — pure Feeds mapping plugins.
- **Security:** no routes, services, or external calls; input handling limited to trim/string-cast. No security findings.
