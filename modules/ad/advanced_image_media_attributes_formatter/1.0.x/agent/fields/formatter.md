<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two attribute-adding formatters

## Install & enable

```bash
composer require drupal/advanced_image_media_attributes_formatter
drush en advanced_image_media_attributes_formatter -y
drush cr
```

Depends on core **`image`** and **`media`**. No sub-modules, no permissions, no Drush commands, no
configuration page. `hook_install()` (`.install`) calls `module_set_weight(..., 100)` so the alter
runs after other image modules.

## How it hooks in

`advanced_image_media_attributes_formatter.module` implements `hook_field_formatter_info_alter()` and
replaces the `class` of two **core** formatter plugin ids — it does **not** register a new id:

| Core formatter id | Replaced class |
|---|---|
| `image` | `Drupal\advanced_image_media_attributes_formatter\Plugin\Field\FieldFormatter\ImageFieldWithAttributesFormatter` |
| `entity_reference_entity_view` | `...\MediaWithAttributesFormatter` |

So there is no new formatter to select: pick the normal **Image** formatter on an image field, or the
**Rendered entity** formatter on a media/entity-reference field, and the extra options appear in its
settings (gear icon on *Manage display*, or the field settings in *Views*).

## Image fields — `ImageFieldWithAttributesFormatter`

Extends core `ImageFormatter`. Adds two settings (`defaultSettings()`):

| Key | Default | Options |
|---|---|---|
| `fetchpriority` | `''` | `''` (none), `high`, `low`, `auto` |
| `decoding` | `''` | `''` (none), `async`, `sync`, `auto` |

`settingsForm()` renders them as **select** elements (nested under the core `image_loading` group on
Manage display, or flat in a Views context — `isViewsContext()` detects Views via `form_state`
`view`/`views_ui` form id/`Views*` callback). `settingsSummary()` appends the chosen values.

`viewElements()` calls `parent::viewElements()`, and when either value is set adds
`#fetchpriority`/`#decoding` and the `preRenderAddAttributes` pre-render callback to each element.

## Media / entity-reference fields — `MediaWithAttributesFormatter`

Its base class is resolved **dynamically** at file load: if the contrib module
`media_image_style_formatter` is present it extends
`RenderedMediaWithImageStyleFormatter`, otherwise core `EntityReferenceEntityFormatter`
(via the `MediaWithAttributesFormatterBase` abstract alias). Adds (`defaultSettings()`):

| Key | Default | Meaning |
|---|---|---|
| `override_image_loading` | `FALSE` | Master checkbox; the other options only apply when on. |
| `image_field_name` | `field_media_image` | Which image field **inside** the referenced media to target. |
| `image_loading_attribute` | `lazy` | `lazy` or `eager` (radios). |
| `fetchpriority` | `''` | `''`/`high`/`low`/`auto`. |
| `decoding` | `''` | `''`/`async`/`sync`/`auto`. |

`settingsForm()` builds the image-field option list from the media bundles' actual image fields
(`entity_field.manager` base fields excluding `thumbnail`, plus per-bundle instance fields, limited to
`getAllowedBundles()` from the reference field's `handler_settings.target_bundles`). All options are
constrained selects/radios — there is no free-text attribute entry. `#states` hide the options until
`override_image_loading` is checked.

`viewElements()` attaches `preRenderAddAttributes` only when `override_image_loading` is on **and** an
`image_field_name` is set.

## How attributes reach the markup

Both classes implement `TrustedCallbackInterface` and register the static `preRenderAddAttributes` in
`trustedCallbacks()`. The callback writes values into the render array — never into raw HTML strings:

- theme `image_formatter` → `#item_attributes['fetchpriority'|'decoding'|'loading']`
- theme `image` / `image_style` → `#attributes['fetchpriority'|'decoding'|'loading']`

The media callback iterates numeric deltas under `$element[$image_field_name]`, handling the
`image_formatter`, `image`, `image_style` themes and a nested `[0]['#theme']` structure, and `unset`s
`#cache` on the touched sub-elements so the override is not served from a stale cached render. Drupal's
Attribute/Twig rendering emits these keys, and all values originate from the fixed option lists above.

## Enable via config (example, Manage display)

```yaml
# core.entity_view_display.node.article.default
content:
  field_image:
    type: image
    label: hidden
    settings:
      image_style: large
      image_link: ''
      fetchpriority: high
      decoding: async
```

For a media reference field, use `type: entity_reference_entity_view` with
`settings.override_image_loading: true`, `settings.image_field_name: field_media_image`,
`settings.image_loading_attribute: eager`, etc. Run `drush cr` if new options do not appear.

## Gotchas

- The alter is **global**: the extra settings show on every `image`/`entity_reference_entity_view`
  formatter site-wide (by design, for consistency).
- No config schema is shipped for the added keys; strict schema checkers may warn, but values save.
- The media formatter only rewrites the inner image when `image_field_name` matches a real image field
  on the referenced media bundle; otherwise the referenced entity renders unchanged.
