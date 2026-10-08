<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & file matching

## Config form

- **Path:** `/admin/config/development/performance/critical-css`
- **Route:** `critical_css.settings` (the `configure` route)
- **Permission:** core `administer site configuration`
- **Config object:** `critical_css.settings` (has schema; **no** config/install defaults, so
  the object does not exist until you save the form once).

## Config keys (`critical_css.settings`)

| Key | Type | Meaning |
|---|---|---|
| `enabled` | boolean | Master on/off. Rebuild cache after changing. |
| `dir_path` | string | Directory (relative to the **active theme**) holding the critical CSS files. **Must start with `/`** and must **not** contain `..` (validated). E.g. `/css/critical`. |
| `excluded_ids` | string | Entity ids to skip, **one per line**; those entities load normal (synchronous) CSS. |
| `enabled_for_logged_in_users` | boolean | Also apply for authenticated users (off by default — files are generated for an anonymous view). |
| `preload_non_critical_css` | boolean | Preload the async CSS at highest priority (only for FOUC fixes). |

Set via Drush:
```bash
drush cset critical_css.settings enabled true
drush cset critical_css.settings dir_path '/css/critical'
```

## Which file is inlined

Files live at `{active_theme_path}{dir_path}/`. For each request `CriticalCssProvider`
builds candidate names in this order and inlines the **first existing, non-empty** one:

1. `{entity_id}.css` — e.g. `123.css` (node/term id on entity routes)
2. `path-{sanitized_path}.css` — internal path like `/node/123` → `path-node-123.css`
3. `{sanitized_path}.css` — `node-123.css`
4. `path-{sanitized_path_info}.css` — request path info, e.g. `path-my-article.css`
5. `{sanitized_path_info}.css` — `my-article.css`
6. `{bundle}.css` — content type / vocabulary, e.g. `article.css`
7. `default-critical.css` — the catch-all fallback

Path sanitizing strips the leading slash and non `[a-zA-Z0-9/-]` chars, turns `/` into `-`,
and uses `front` for the empty path. You generate these files yourself (the module never
creates them). With Twig debug on, the candidate list is printed as an HTML comment (look
for `NONE MATCHED`).
