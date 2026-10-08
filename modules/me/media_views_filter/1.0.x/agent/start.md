<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Views Filter (media_views_filter) — agent index

A small Views-integration module (package `OHSU`, version **1.0.0-rc1**, core `^9 || ^10 || ^11`,
GPL-2.0-or-later, **not** security-advisory covered). It registers **three Views handlers** on the
core `media_field_data` table via a single `hook_views_data()` — no admin UI, no settings, no
permissions, no config schema, no services beyond injected `database` and
`plugin.manager.views.join`.

`info.yml` declares **no** `dependencies:` key, but the code hard-requires the core **media**,
**views** and **file** modules to function.

## What it actually provides

1. **Filter `media_file_name`** — class `MediaFileNameFilter` (`@ViewsFilter`), extends core
   `StringFilter`. Registered in `hook_views_data()` as `media_field_data.media_file_name_filter`,
   title "Media name/file name". This is the point of the module. See `views/filter.md`.
2. **Field `media_file_name`** — class `MediaFileName` (`@ViewsField`), title "File name". Renders
   an `<a>` link to the source file's `createFileUrl()`. See `views/fields.md`.
3. **Field `media_alt_text`** — class `MediaAltText` (`@ViewsField`), title "Alt text". Renders the
   media thumbnail's `alt` attribute. See `views/fields.md`.

## The mechanism in one paragraph

The filter exposes **only the "contains" operator** (all others are unset in `operators()`). Its
`query()` LEFT-joins `media_field_data.mid` → `file_usage.id`, INNER-joins `file_usage.fid` →
`file_managed.fid`, adds `GROUP BY media_field_data.mid` (+ `.changed`) to de-duplicate, strips the
default WHERE on `media_field_data.name`, then opens an **OR** where-group and matches the entered
value with `LIKE '%value%'` against five columns: `media_field_data.name`,
`file_managed.filename`, a `REPLACE(REPLACE(file_managed.uri,'public://',''),'private://',''))`
expression, `media_field_data.thumbnail__alt` and `media_field_data.thumbnail__title`.

## Intended setup (no code, all Views UI)

1. Edit a core media view (e.g. `/admin/structure/views/view/media`, or the `media_library` modal
   view).
2. Add filter criteria → **"Media name/file name"** → configure → tick **"Expose this filter"**.
3. Remove the stock **"Media: Name"** filter.
4. Save the view; export config afterward.
5. Optionally add the **"File name"** and **"Alt text"** fields to show what the filter matched.

## Files

- `media_views_filter.module` — the entire `hook_views_data()`.
- `src/Plugin/views/filter/MediaFileNameFilter.php` — the filter.
- `src/Plugin/views/field/MediaFileName.php`, `MediaAltText.php` — the two fields.
- No `composer.json`, no `config/`, no `.install`, no `.libraries.yml`.

## Notes for agents

- Search values are escaped with `Connection::escapeLike()` and **bound as query parameters** — no
  SQL injection surface (see `views/filter.md` for the exact call shape).
- Because the filter is a `StringFilter` subclass it participates normally in exposed-filter forms,
  Better Exposed Filters, and Views caching.
- The `REPLACE(...)` and `GROUP BY` are MySQL/MariaDB-oriented; the code carries `@todo`s about
  Acquia/`admin/content/media` grouping quirks and about not hardcoding stream prefixes.
