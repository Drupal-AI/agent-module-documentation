<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Target Attributes Filter (target_attributes_filter) — agent index

A single text-format **filter plugin** that sets a `target` attribute on hyperlinks in rendered
HTML. Depends only on core **`filter`**. Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.9 (doc dir `1.x`). No routes, permissions, services, hooks, blocks,
or Drush.

- **The filter plugin, how it walks anchors, scope logic, config object & schema** →
  [plugins/filter.md](plugins/filter.md)
- **Filter settings (the three keys, defaults, how to enable per format)** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `TargetAttributesFilter` (id **`filter_target_attributes`**, title *"Add target
  attribute to links"*), in `src/Plugin/Filter/TargetAttributesFilter.php`, extending core
  `FilterBase` and implementing `ContainerFactoryPluginInterface`. Filter type is
  **`TYPE_TRANSFORM_IRREVERSIBLE`**.
- Injects the `request_stack` service (via `create()`) to learn the site's HTTP host for the
  internal/external link test.
- Provides config **schema only** (`config/schema/target_attributes_filter.schema.yml`,
  `filter_settings.filter_target_attributes`); no `config/install`, no default config object.

## Mechanism (from source)

- `process($text, $langcode)` loads the markup with **`Html::load($text)`** (DOM parser, not
  regex), iterates `$dom->getElementsByTagName('a')`, and for each `<a>`:
  - if **"replace" is off** and the link already `hasAttribute('target')`, it is skipped;
  - reads `trim(getAttribute('href'))` — empty/whitespace hrefs are skipped;
  - `parse_url($href)`, takes the host with a leading `www.` stripped (`preg_replace('/^www\./i', …)`),
    defaulting to the request host when the URL has no host (relative links → internal);
  - applies the **scope**: `internal` skips when host ≠ request host, `external` skips when
    host = request host, `all` never skips;
  - calls **`setAttribute('target', <configured value>)`**.
- Returns `new FilterProcessResult(Html::serialize($dom))`. Attribute read/write goes through the
  DOM API and `Html::serialize`, so values are handled/encoded by the DOM layer.

## Settings (three keys)

`filter_target_attribute` (select: `_blank` / `_self` / `_parent` / `_top`),
`filter_target_method` (radios: `all` / `internal` / `external`), `filter_target_replace`
(checkbox). See [config/settings.md](config/settings.md) for exact defaults (note the annotation
default value is `_self`, and `filter_target_replace` defaults on).
