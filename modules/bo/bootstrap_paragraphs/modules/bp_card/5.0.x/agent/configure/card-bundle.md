<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_card` bundle — fields, values, wiring

No settings form (`configure: null`). Everything is config imported from `config/optional/`.

## Fields

| Field | Type | Label | Storage owner |
|---|---|---|---|
| `bp_card_style` | `list_string` | Card Style | bp_card |
| `bp_card_title` | `string` | Card Title | bp_card |
| `bp_card_text` | `string_long` | Card Text | bp_card |
| `bp_card_image` | `image` | Card Image | bp_card |
| `bp_card_link` | `link` | Card Link | bp_card |
| `bp_card_button_style` | `list_string` | Card Button Style | bp_card |
| `bp_link_entire_card` | `boolean` | Link Entire Card | bp_card |
| `bp_margin` | `list_string` | Margin | parent `bootstrap_paragraphs` |
| `bp_padding` | `list_string` | Padding | parent `bootstrap_paragraphs` |

All storages are cardinality 1. **There is no `bp_width`, `bp_background` or `bp_header` on
this bundle.**

### `bp_card_style` allowed values (value === CSS class)

```
card--large-top    label "Card with Large Top Image"
card--small-left   label "Card with Small Left Image"
```

The template renders **nothing at all** unless one of these two is selected — both layout
branches are `{% if card_style == '…' %}` guards.

### `bp_card_button_style` allowed values (value === CSS classes)

```
btn btn-primary   btn btn-secondary  btn btn-success  btn btn-info
btn btn-light     btn btn-dark       btn btn-danger   btn btn-warning
```

Labels: Primary, Secondary, Success, Info, Light, Dark, Danger, Warning.

### Shared `bp_margin` / `bp_padding` allowed values

```
bp_margin :  "mt-1 mb-1"  "mt-3 mb-3"  "mt-5 mb-5"  mt-1  mt-3  mt-5  mb-1  mb-3  mb-5
bp_padding:  "pt-1 pb-1"  "pt-3 pb-3"  "pt-5 pb-5"  pt-1  pt-3  pt-5  pb-1  pb-3  pb-5
```

### `bp_card_image` instance settings

```yaml
file_directory: 'card/[date:custom:Y]-[date:custom:m]'
file_extensions: 'png gif jpg jpeg'
alt_field: true
alt_field_required: true      # alt text is mandatory
title_field: false
```

### `bp_card_link` instance settings

`link_type: 17` (internal + external), `title: 1` (link text optional).

## Form display (`paragraph.bp_card.default`)

| Field | Widget | Weight |
|---|---|---|
| `bp_card_style` | `options_select` | 0 |
| `bp_card_title` | `string_textfield` (size 60) | 1 |
| `bp_card_link` | `link_default` | 2 |
| `bp_link_entire_card` | `boolean_checkbox` (`display_label: true`) | 3 |
| `bp_card_text` | `string_textarea` (rows 5) | 4 |
| `bp_card_image` | `image_image` (preview style `thumbnail`) | 5 |
| `bp_card_button_style` | `options_select` | 6 |
| `bp_margin` | `options_select` | 8 |
| `bp_padding` | `options_select` | 9 |

Hidden: `created`, `status`. A **`field_group` third-party setting** wraps `bp_margin` and
`bp_padding` in a collapsed `details` group:

```yaml
third_party_settings:
  field_group:
    group_styles:
      children: [bp_margin, bp_padding]
      label: Styles
      format_type: details
      format_settings: { open: false }
      weight: 7
```

This is why `field_group` is a hard dependency of the parent module.

## Update hooks (`bp_card.install`)

- `bp_card_update_5001()` — creates the `bp_link_entire_card` and `bp_card_button_style`
  storages/instances and re-applies the card form display from the shipped YAML.
- `bp_card_update_5002()` — creates the `bp_margin` and `bp_padding` instances on `bp_card`
  and re-applies the form display.

Both use the helpers `bp_card_update_entity_from_yml()` / `bp_card_update_configuration_from_yml()`,
which read the *current* `config/optional/*.yml` and `setComponent()` them onto the live
display. Run with `drush updb`.

## Make the bundle available to editors

```bash
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_page_content");
  $s = $f->getSetting("handler_settings");
  $s["target_bundles"]["bp_card"] = "bp_card";
  $f->setSetting("handler_settings", $s)->save();'
```

## Read the live configuration

```bash
drush cget field.storage.paragraph.bp_card_style settings.allowed_values
drush cget field.storage.paragraph.bp_card_button_style settings.allowed_values
drush cget field.field.paragraph.bp_card.bp_card_image settings
drush cget core.entity_form_display.paragraph.bp_card.default third_party_settings
```

## Create a card programmatically

```php
use Drupal\paragraphs\Entity\Paragraph;

$card = Paragraph::create([
  'type' => 'bp_card',
  'bp_card_style' => 'card--large-top',
  'bp_card_title' => 'Annual Report',
  'bp_card_text' => 'Our results for the year.',
  'bp_card_link' => ['uri' => 'https://example.com/report', 'title' => 'Read it'],
  'bp_card_button_style' => 'btn btn-primary',
  'bp_link_entire_card' => TRUE,
  'bp_margin' => 'mt-3 mb-3',
  'bp_padding' => 'pt-3 pb-3',
]);
$card->save();
```

`bp_card_image` takes `['target_id' => $file->id(), 'alt' => 'required alt text']`.
