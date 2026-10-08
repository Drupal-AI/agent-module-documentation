<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertising Entity: Usage Example for Generic ads (ad_entity_generic_example) — agent index

Developer **example** submodule, nested under **ad_entity_generic**. Demonstrates how to register a
custom load/remove handler for the generic ad provider. Package `Advertising`. Depends on
`ad_entity:ad_entity_generic`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x`
(release 8.x-1.6). **No config, no permissions, no routes, no services, no config schema** — just
one page attachment plus a commented JS reference file.

- **The loader handler pattern (the whole point of this module)** →
  [api/loader.md](api/loader.md)

## What it actually is (from source)

- `ad_entity_generic_example.module`: a single `hook_page_attachments()` that attaches the
  `ad_entity_generic_example/loader` library on every page.
- `ad_entity_generic_example.libraries.yml`: library `loader` → `js/example.loader.js`, depends on
  `ad_entity_generic/base`.
- `js/example.loader.js`: a heavily commented reference implementation that registers a load
  handler and a remove handler on `window.adEntity.generic`, documents the `ad_tag` object
  contract, and shows how to consume the incoming queue and the global `toLoad`/`toRemove` queues.
  The handlers only `console.log` — the file explicitly says not to use the logger in production.

## Notes

- This is a learning/scaffold module: enable it in development to observe the generic ad lifecycle,
  then copy the pattern into your own integration module and disable this one.
- It ships no demo Ad Entities and no config entities — the generic slots to observe must be
  created separately with the generic ad type (see the ad_entity_generic docs).
