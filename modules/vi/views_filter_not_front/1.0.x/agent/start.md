<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclude Frontpage Node Views filter (views_filter_not_front) — agent index

A Views filter plugin plus a Search API processor that exclude the site's front-page node from
results. Both delegate to one small service, `FrontPageNode`, which reads `system.site:page.front`
and runs it through the router (`router.no_access_checks`) to find the node the front page resolves
to — so it works for `/node/N`, a path alias, or any path that resolves to a node route. If the
front page is not a node, the service returns `FALSE` and both plugins degrade to a silent no-op.

There is nothing to configure beyond adding the filter to a view (Views UI → Add filter →
"Exclude frontpage node") or enabling the processor on a Search API index. No settings page, no
routes, no forms, no permissions, no schema, no Drush.

- **Depends on:** core `views` (`drupal:views`). The Search API processor additionally needs
  `drupal/search_api` installed, but that is NOT declared in `info.yml` — the processor is simply
  absent on sites without Search API.
- **Core:** `^8.8 || ^9 || ^10 || ^11`. **Package:** `Views`.
- **Settings page / configure route:** none (`configure` is null).
- **Permissions:** none. **Drush:** none. **Config schema:** none.
- **Plugin types defined:** none. It *provides* one Views filter and one Search API processor
  (instances of core/contrib plugin types), plus one service.

## What you'd do → where
- Understand or reuse either plugin, or the shared front-page service → [plugins/exclude-front-page.md](plugins/exclude-front-page.md)

## Key facts (real machine names)
- Service: **`views_filter_not_front.frontpage_node`** → `Drupal\views_filter_not_front\Service\FrontPageNode`
  (args `@config.factory`, `@router.no_access_checks`); public method `getFrontpageNode()` returns a
  `Node` or `FALSE`.
- Views filter plugin id: **`not_front`** (`@ViewsFilter`), class `NotFront`
  (`src/Plugin/views/filter/NotFront.php`); `canExpose()` → FALSE.
- Views data key (from `views_filter_not_front_views_data()` in `.views.inc`):
  **`node_field_data['not_front_filter']`**, `filter => { field: nid, id: not_front }`.
- Search API processor id: **`exclude_front_page_node`** (`@SearchApiProcessor`, stage
  `alter_items`), class `ExcludeFrontPage` (`src/Plugin/search_api/processor/ExcludeFrontPage.php`).
- Config read: **`system.site:page.front`**.

Verify what the service considers the front page:

```bash
ddev drush php:eval 'print \Drupal::config("system.site")->get("page.front");'
```
