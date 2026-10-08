<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: filter settings

There is **no** standalone config form and **no** `config/install` default object. All settings
live inside the text format's own filter configuration (config entity `filter.format.<id>`, under
`filters.filter_target_attributes.settings`), edited on **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`).

## Enable

1. `composer require drupal/target_attributes_filter`, then `drush en target_attributes_filter -y`
   (or enable via the UI). Core `filter` is the only dependency.
2. Edit a text format at `/admin/config/content/formats/manage/<format>`.
3. Check **"Add target attribute to links"** in the Enabled filters list.
4. Set the options under **Filter settings** and save.

## Settings keys

| Key | Type | Values | Default (fresh enable) |
| --- | --- | --- | --- |
| `filter_target_attribute` | string | `_blank`, `_self`, `_parent`, `_top` | `_self` (annotation default) |
| `filter_target_method` | string | `all`, `internal`, `external` | `all` |
| `filter_target_replace` | boolean | `0` / `1` | `1` (replace existing target) |

Notes:
- The settings-form select is *labelled* new-window-first (`_blank` at top), but the effective
  stored default before anyone saves the form is `_self` (see the annotation vs. `setConfiguration`
  detail in [../plugins/filter.md](../plugins/filter.md)).
- `filter_target_method` controls scope: `all` = every link; `internal` = only links whose host
  equals the request host (leading `www.` stripped from the link host); `external` = only links
  whose host differs from the request host. Relative links and empty-host URLs count as internal.
- `filter_target_replace = 1` overwrites a link's existing `target`; `0` leaves links that already
  have a `target` attribute untouched.

## Config schema

`config/schema/target_attributes_filter.schema.yml` defines:

```yaml
filter_settings.filter_target_attributes:
  type: mapping
  label: 'Filter target attributes'
  mapping:
    filter_target_attribute:
      type: string
    filter_target_method:
      type: string
    filter_target_replace:
      type: boolean
```

`filter_settings.<plugin_id>` is core's convention for per-filter settings schema, so these keys
are validated as part of the text format's exported configuration.

## Example (exported `filter.format.*` fragment)

```yaml
filters:
  filter_target_attributes:
    id: filter_target_attributes
    provider: target_attributes_filter
    status: true
    weight: 20
    settings:
      filter_target_attribute: _blank
      filter_target_method: external
      filter_target_replace: 1
```

This configuration opens only external links in a new tab and replaces any author-set target on
those links. Set `weight` so the filter runs after "Limit allowed HTML tags".
