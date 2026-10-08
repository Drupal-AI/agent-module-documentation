<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible external link formatter and filter (external_link_a11y) — agent index

Two plugins that make **external links open in a new tab accessibly**: a **Link-field formatter** and a
**text-format filter**. Both add `target="_blank"` to in-scope links, an announced "Open in new window"
cue for screen readers, optional `rel` values, and optional CSS classes. Depends only on core **`link`**.
Version **1.2.0**. Core requirement `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.

- **The field formatter** (`ExternalLinkA11yFormatter`, id `external_link_a11y`) → [fields/formatter.md](fields/formatter.md)
- **The text-format filter** (`ExternalLinkA11yFilter`, id `external_link_a11y`) → [filters/filter.md](filters/filter.md)

## What it actually is

- **Formatter** — `src/Plugin/Field/FieldFormatter/ExternalLinkA11yFormatter.php`, PHP-attribute plugin
  `#[FieldFormatter(id: 'external_link_a11y', label: 'Link (target blank when external a11y)', field_types: ['link'])]`,
  **extends core `LinkFormatter`**. Selected per view-display on *Manage display* for Link fields.
- **Filter** — `src/Plugin/Filter/ExternalLinkA11yFilter.php`, annotation plugin
  `@Filter(id = "external_link_a11y", type = TYPE_TRANSFORM_REVERSIBLE)`, extends `FilterBase`. Enabled
  per text format at `/admin/config/content/formats`.
- **Config schema** — `config/schema/external_link_a11y.schema.yml` defines
  `field.formatter.settings.external_link_a11y` (extends `field.formatter.settings.link`) and
  `filter_settings.external_link_a11y`.
- **No** routing, permissions, services, hooks, install file, entities, submodules, Drush commands or
  libraries of its own. Only dependency is core `link`.

## Install

```bash
composer require drupal/external_link_a11y
drush en external_link_a11y -y
```

## Detection / behaviour (shared idea)

A link is **in scope** when its `href` is external (core `UrlHelper::isExternal()` / `Url::isExternal()`);
the filter additionally treats a link already carrying `target="_blank"` as in scope. For in-scope links the
plugins can add `target="_blank"` (only when no `target` is already set), append a visually-hidden
`Open in new window` span and a matching `title`, add configured `rel` values, and add CSS classes; the
filter can also append an HTML suffix. See the per-plugin docs for the exact setting keys and defaults.
