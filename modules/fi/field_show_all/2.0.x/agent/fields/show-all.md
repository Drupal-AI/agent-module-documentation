<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling the "Show all / show less" toggle on a field

## Install & enable

```bash
composer require drupal/field_show_all
drush en field_show_all -y
```

No module dependencies, no sub-modules, no permissions, no Drush commands, no admin/config form.
Everything is configured **per field, per view display** on the *Manage display* screen.

## Precondition: unlimited cardinality

The settings appear **only for fields whose storage cardinality is `-1` (unlimited)**. In
`field_show_all_field_formatter_third_party_settings_form()` the elements are built solely inside
`if ($cardinality == -1)`. For a single-value or fixed-count field, no Field Show All options are
shown. Create or pick an unlimited-cardinality multi-value field first (e.g. a text field with
"Allowed number of values" = Unlimited, or the Tags reference field).

## Enable it on a field (UI)

*Structure → Content types → (bundle) → Manage display* → click the gear/settings for the target
multi-value field. The formatter settings form gains four extra elements (added by the hook):

| Element key | Type | Meaning |
|---|---|---|
| `field_show_all_enabled` | checkbox | *"Enable Show All widget for the field"* — turns the feature on. The three fields below are `#states`-hidden until this is checked. |
| `items_show` | textfield | *"Number of items to display by default"* — if the field has more delta items than this, the extras are hidden and a link is shown. |
| `link_text` | textfield | *"Link Text"* — text of the expand link (shown while collapsed). |
| `link_text_close` | textfield | *"Link Text Close"* — text shown on the link once items are expanded. |

On save, the Manage-display summary line for the field shows `Field show all enabled:Yes`
(`hook_field_formatter_settings_summary_alter()`).

![Manage display formatter settings with Field Show All options](../../../../../../../screenshots/field_show_all/2.0.x/manage-display-settings.png)

## Where the settings are stored

They are formatter **third-party settings** (not a config-schema-backed object) on the view-display
component, under key `field_show_all`. Example fragment of
`core.entity_view_display.node.article.default`:

```yaml
content:
  field_tags:
    type: entity_reference_label   # any base formatter; Field Show All wraps it
    label: above
    settings: { link: true }
    third_party_settings:
      field_show_all:
        field_show_all_enabled: true
        items_show: '3'
        link_text: 'Show all'
        link_text_close: 'Show less'
```

Note there is **no `config/schema/`** in the module, so strict config-schema validation may warn
about the `field_show_all` third-party settings; they still save and work.

## Render mechanism (`hook_preprocess_field`)

At render time `field_show_all_preprocess_field()`:

1. Resolves the display component with
   `EntityViewDisplay::collectRenderDisplay($element['#object'], $element['#view_mode'])` and reads
   `third_party_settings['field_show_all']`. If not enabled, it does nothing.
2. Adds class `field-show-all` to the field wrapper and attaches library
   `field_show_all/field-show-all`.
3. Publishes per-field JS config to
   `drupalSettings.field_show_all['field--name-<field-with-dashes>']` =
   `{ limit, link_text, link_text_close }`.
4. Iterates `$variables['items']`; for every delta whose index `> items_show - 1` it sets the item's
   `attributes` to `class="element-invisible"` (hidden by the module CSS `display:none`).
5. If the item count exceeds `items_show`, appends an extra pseudo-item: a `div.field-show-all-link`
   with `id="field-show-all-link-<field-class>"`, a `data-field-class` attribute, and the expand
   `link_text` as its value.

## Toggle behavior (`js/field-show-all.js`)

`Drupal.behaviors.fieldShowAllLoader` binds a click handler to each `.field-show-all-link`. On
click it reads `limit` / `link_text` / `link_text_close` from `drupalSettings` for that field, and
toggles: expanded → removes `element-invisible` from all hidden items and sets the link's
`textContent` to `link_text_close`; collapsed again → re-adds `element-invisible` to items past the
limit and restores `link_text`. Link text is swapped via `textContent` (not innerHTML).

## Notes / caveats

- **Unlimited cardinality only** — no options appear on limited-cardinality fields.
- `items_show` is a free-text field (stored as a string) and is used in numeric comparisons; enter a
  plain integer.
- The appended link item adds a `#cache` tag `"<items_show>-<field_name>"`, which is a non-standard
  (entity-less) cache tag string — harmless but not a conventional cache tag.
- Works with any base formatter that renders one markup element per delta; it wraps that formatter's
  output rather than replacing it.
