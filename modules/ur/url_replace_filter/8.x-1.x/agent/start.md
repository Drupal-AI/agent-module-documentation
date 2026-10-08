<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL Replace Filter (url_replace_filter) — agent index

Text-format **`@Filter` plugin** (`id: url_replace_filter`) that rewrites the leading URL of
**`<a href>` and `<img src>`** attributes at render time. Depends on core `filter`. Configured
**per text format** at `/admin/config/content/formats` (link route `filter.admin_overview`).
Version **8.x-1.2**. Core `^10 || ^11`. Declares `php: 8.2`. License GPL-2.0-or-later.

## What it actually does
- Enable the filter on a format, then in its vertical settings tab enter rows of an **original**
  base-URL string and a **replacement**.
- `process()` runs one **case-insensitive, ungreedy regex per rule** over the raw markup string:
  `!((<a\s[^>]*href)|(<img\s[^>]*src))\s*=\s*"ORIGINAL!iU`, then rewrites only the matched
  attribute + leading-URL span to `<a href="REPLACEMENT` / `<img src="REPLACEMENT`, leaving the
  rest of the URL and tag intact.
- It is a **regex over markup, not a DOM parse**, and touches **only** `href` on `<a>` and `src`
  on `<img>` — never `<script>`, `<link>`, CSS `url()`, inline styles, or link text.
- Replacement may contain **`%baseurl`** → `rtrim(base_path(), '/')` (empty on a root install).
- Rules run **top-to-bottom**; put the most specific original first, and give both original and
  replacement matching trailing slashes.
- Settings stored per format as a **PHP-serialized string** in the `replacements` setting,
  unserialized with `allowed_classes => FALSE`. Config schema: `filter_settings.url_replace_filter`.
- Stored content is never modified; only rendered/filter-cached output changes.

## Type & mechanism
- `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`. No permissions, no Drush, no submodules, no
  services beyond injected `current_route_match` + `messenger` (used by the settings form only).
- `getFormats()` / `hook_requirements` warn if the module is enabled but no format uses the filter.
- The settings form auto-appends up to 3 empty rows after each save and drops empty rows on validate.

## Watch for
- **Filter order** — must run where `<a>`/`<img>` are still present and any HTML-restricting filter
  has already had its say. It does **not** re-open filtering (returns a plain `FilterProcessResult`,
  no `setProcessedText`-as-safe trickery beyond normal filter output).
- **Configuration is admin-gated** by core `administer filters` (trusted-roles-only). Replacement
  strings are author-of-config controlled; see `agent/filters/mechanism.md`.
- **Durable fix instead?** Core `base_url`, or an actual content re-migration — a render-time
  rewrite is a workaround that tends to outlive its justification.

## Files
- `usage.md` — short / dense / use-case bullets.
- `agent/filters/mechanism.md` — the process() regex, `%baseurl`, ordering, storage, and settings form.
