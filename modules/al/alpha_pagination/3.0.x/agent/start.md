<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alpha Pagination (alpha_pagination) — agent index

Adds an alphabetic **A-Z (+ optional 0-9 / "All") jump menu** to a View's header or footer. Each
letter links to the same View with that character as the last URL argument (glossary-style), so a
listing can be filtered by the first character of a chosen field. Content-display / Views navigation.

- **Version:** 3.0.1 · **Core:** `^9 || ^10 | ^11` · **License:** GPL-2.0-or-later
- **Depends on:** core `views` only. No routes, no permissions, no config forms, no config schema.
- **Submodule:** `alpha_pagination_sample_view` (optional example view) — see
  [`modules/alpha_pagination_sample_view/3.0.x/agent/start.md`](../modules/alpha_pagination_sample_view/3.0.x/agent/start.md).

## What it provides

- **Views area handler** `AlphaPaginationArea` (`@ViewsArea("alpha_pagination")`, id `alpha_pagination`,
  group "Custom Global") — the actual paginator, added to a View's header/footer. All configuration is
  its handler options (`paginate_*`). See [`agent/plugins/views-area.md`](plugins/views-area.md).
- **Views field handler** `AlphaPaginationGroup` (`@ViewsField("alpha_pagination_group")`, id
  `alpha_pagination_group`) — an auto-computed, excluded-by-default field emitting the first grouping
  character (and optional `#`-anchor) per row. See [`agent/plugins/views-field.md`](plugins/views-field.md).
- **Service** `alpha_pagination` → `Drupal\alpha_pagination\AlphaPagination` — shared helper that
  builds the character list, runs the entity/prefix queries, resolves URLs/labels/tokens, and caches.
  Plus value object `AlphaPaginationCharacter`, hooks and tokens. See [`agent/api/service.md`](api/service.md).

## Files

- `alpha_pagination.views.inc` — `hook_views_data()` registers both handlers under `views.*`.
- `alpha_pagination.module` — help, `hook_entity_presave` cache invalidation, token info/replace.
- `alpha_pagination.api.php` — the two alter hooks.
- `alpha_pagination.libraries.yml` / `css/alpha_pagination.css` — component CSS attached on render.
