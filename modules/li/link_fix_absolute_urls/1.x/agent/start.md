<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link: Fix Absolute URLs (link_fix_absolute_urls) — agent index

On every entity save, rewrites **same-site absolute URLs stored in `link`-type fields** into portable
internal references (`entity:node/…`, `internal:/…`). The whole module is one `hook_entity_presave()`
(`link_fix_absolute_urls.module:28`) that delegates to a reusable service, `LinkProcessor::process()`
(`src/LinkProcessor.php:51`). For each `link` field item whose URI `isExternal()` and whose host matches
the site's own base URL, it strips the `http://`/`https://`/`www.` prefixes and the base URL, then maps
the leftover path back to Drupal: existing local file → `internal:/<path>`; empty path → `internal:/`
(front page); a node route (resolved through `path_alias.manager` for aliases) → `entity:node/<id>`;
any other routed path or non-existent path → `internal:/<path>`. The link **title is preserved**; only
the `uri` value changes. Off-site links and non-`link` fields are left untouched. There is **no UI, no
config, no route, no permission** — enabling the module is the entire setup. `Redirect` entities are
explicitly skipped (`link_fix_absolute_urls.module:42`).

- **Depends on:** `drupal:link`, `drupal:path_alias` (info.yml).
- **Core:** `^9.3 || ^10 || ^11`. **Package:** `Fields`.
- **Settings page / configure route:** none (`configure` is null — README: "No configuration is required or available").
- **Permissions:** none. **Drush:** none. **Plugin types:** none. **Config schema:** none.
- **Hooks implemented:** `hook_help()` (help.page text), `hook_entity_presave()`.
- **Reusable service:** `link_fix_absolute_urls.link_processor` → `Drupal\link_fix_absolute_urls\LinkProcessor`.
- No security surface (operates only on structured `link` field data, emits safe `internal:`/`entity:` URIs, never manipulates markup).

## What you'd do → where
- Call the processor directly / bulk-fix existing content → [agent/api/service.md](api/service.md)
- Understand the presave trigger, skip rules, and URI mapping → [agent/api/service.md](api/service.md)

## Key facts (real machine names)
- **Service id:** `link_fix_absolute_urls.link_processor` (args: `@path_alias.manager`, `@entity_type.manager`).
- **Service class / method:** `Drupal\link_fix_absolute_urls\LinkProcessor::process(ContentEntityInterface $entity): bool` (returns whether any value changed; does NOT save).
- **Trigger:** `link_fix_absolute_urls_entity_presave(EntityInterface $entity)` — runs on ALL entities that expose a public `getFieldDefinitions()`; returns early otherwise, and for `\Drupal\redirect\Entity\Redirect`.
- **Field target:** field definitions whose `getType() == 'link'`.
- **URI outputs:** `entity:node/<id>`, `internal:/<path>`, `internal:/` (front page), `internal:/<file-path>`.
- **Help route:** `help.page.link_fix_absolute_urls`.
