<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage & apply Fences presets

A **Fences Preset** is a `fences_preset` config entity storing a reusable bundle of the eight
Fences wrapper values. Manage them at **Configuration → User interface → Fences → Presets**
(`/admin/config/user-interface/fences/presets`, route `entity.fences_preset.collection`) —
add / edit / duplicate / delete. Requires permission `administer fences_preset`.

## Preset config keys

`fences_presets.fences_preset.*` (config prefix `fences_preset`). Note these keys have **no**
`fences_` prefix, unlike the per-field third-party settings on the parent module:

`id`, `label`, `description`, `status`, then `field_tag`, `field_classes`,
`field_items_wrapper_tag`, `field_items_wrapper_classes`, `field_item_tag`,
`field_item_classes`, `label_tag`, `label_classes`. Each tag value is an HTML tag from the
Fences registry or `none`.

## The four default presets (shipped in `config/install`)

| id | label | markup effect |
|---|---|---|
| `default` | Default | core-like: field `div`, item `div`, label `div`, items wrapper `none` |
| `inline` | Inline | field `span`; item/label/items-wrapper `none` — fields sit next to each other |
| `inline_label` | Inline Label | label `span`, item `span`, field `div` — label beside value |
| `none` | None | every tag `none` — just label text + value, no markup |

## How applying a preset works

On a field's Manage-display **Fences** section, fences_presets injects a **"Select Preset"**
dropdown (via `hook_fences_field_formatter_third_party_settings_form_alter`, with all active
presets passed to `drupalSettings.fencesPresets`). Its JS copies the chosen preset's tag
values into the field's Fences form controls. The selector is rendered through an
`inline_template` specifically so its own value is **not** persisted — it only pre-fills the
real Fences settings, which you then save with the normal **Save** button. So a preset is a
one-shot template: changing a preset later does **not** retroactively change fields that used
it.

## Scripting a preset with drush

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("fences_preset")->create([
    "id" => "card_item", "label" => "Card item", "status" => TRUE,
    "description" => "Grid card items",
    "field_tag" => "div", "field_classes" => "cards",
    "field_items_wrapper_tag" => "none", "field_items_wrapper_classes" => "",
    "field_item_tag" => "div", "field_item_classes" => "card",
    "label_tag" => "none", "label_classes" => "",
  ])->save();
'
```

List them: `drush config:get fences_presets.fences_preset.inline` or
`drush php:eval 'print implode(",", array_keys(\Drupal::entityTypeManager()->getStorage("fences_preset")->loadMultiple()));'`.
