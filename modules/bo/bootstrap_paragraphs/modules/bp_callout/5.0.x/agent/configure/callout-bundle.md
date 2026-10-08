<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_callout` bundle — fields, values, wiring

No settings form (`configure: null`). Everything is config the module imports from
`config/optional/` at install time.

## Config objects installed

| Config name | What it is |
|---|---|
| `paragraphs.paragraphs_type.bp_callout` | the bundle (`id: bp_callout`, `label: Callout`, no behavior plugins) |
| `field.storage.paragraph.bp_callout_style` | `list_string`, cardinality 1 |
| `field.storage.paragraph.bp_callout_content` | `entity_reference_revisions` → `paragraph`, **cardinality -1** |
| `field.field.paragraph.bp_callout.{bp_callout_style,bp_callout_content,bp_header,bp_width,bp_background}` | the 5 field instances |
| `core.entity_form_display.paragraph.bp_callout.default` | form display |
| `core.entity_view_display.paragraph.bp_callout.default` | view display |

`bp_header`, `bp_width` and `bp_background` reuse **storages owned by the parent
`bootstrap_paragraphs` module** — this submodule only adds the bundle-level instances.

## Fields

| Field | Type | Label | Notes |
|---|---|---|---|
| `bp_callout_style` | `list_string` | Callout Style | 9 allowed values, below |
| `bp_callout_content` | `entity_reference_revisions` | Callout Content | unlimited; 13 allowed nested bundles |
| `bp_header` | `string` | Header | rendered as `<h2>` |
| `bp_width` | `list_string` | Width | shared, 5 values |
| `bp_background` | `list_string` | Background | shared, 58 values |

### `bp_callout_style` allowed values (value === CSS class)

```
callout-style--primary  callout-style--secondary  callout-style--success
callout-style--danger   callout-style--warning    callout-style--info
callout-style--dark     callout-style--light      callout-style--white
```

Labels are Primary / Secondary / Success / Danger / Warning / Info / Dark / Light / White.

### `bp_callout_content` nestable bundles

`settings.handler: 'default:paragraph'`, `handler_settings.target_bundles`:

```
bp_simple  bp_image  bp_blank  bp_accordion  bp_carousel  bp_column_wrapper
bp_columns bp_columns_three_uneven bp_columns_two_uneven  bp_block
bp_modal   bp_tabs   bp_view
```

`bp_accordion_section` and `bp_tab_section` are explicitly **disabled** (they belong inside
accordions/tabs only).

### Shared list values

- `bp_width`: `paragraph--width--tiny|narrow|medium|wide|full`
- `bp_margin`/`bp_padding` are **not** on this bundle (they are on `bp_card` / `bp_media`).
- `bp_background`: 58 values, e.g. `paragraph--color paragraph--color--primary`,
  `paragraph--color paragraph--color--rgba-black-slight`, `paragraph--color--transparent`.

## Form display (`paragraph.bp_callout.default`)

| Field | Widget | Weight |
|---|---|---|
| `bp_background` | `options_select` | 0 |
| `bp_width` | `options_select` | 1 |
| `bp_callout_style` | `options_select` | 2 |
| `bp_header` | `string_textfield` (size 60) | 3 |
| `bp_callout_content` | `entity_reference_paragraphs` (`edit_mode: closed`, `add_mode: dropdown`) | 4 |

Hidden: `created`, `status`, `uid`. View display renders every field with `label: hidden`;
`bp_callout_content` uses `entity_reference_revisions_entity_view` (view mode `default`).

## Making the bundle available to editors

The bundle exists but is unusable until some entity has a paragraphs field that allows it.
Add `bp_callout` to an existing paragraphs field's target bundles:

```bash
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_page_content");
  $s = $f->getSetting("handler_settings");
  $s["target_bundles"]["bp_callout"] = "bp_callout";
  $f->setSetting("handler_settings", $s)->save();'
```

Or in the UI: *Structure → Content types → … → Manage fields → your Paragraphs field →
tick **Callout** → Save settings.*

## Read the live configuration

```bash
drush cget paragraphs.paragraphs_type.bp_callout
drush cget field.storage.paragraph.bp_callout_style settings.allowed_values
drush cget field.field.paragraph.bp_callout.bp_callout_content settings.handler_settings.target_bundles
drush cget core.entity_form_display.paragraph.bp_callout.default content
```

## Create a callout programmatically

```php
use Drupal\paragraphs\Entity\Paragraph;

$inner = Paragraph::create(['type' => 'bp_simple']);
$inner->save();

$callout = Paragraph::create([
  'type' => 'bp_callout',
  'bp_callout_style' => 'callout-style--warning',
  'bp_header' => 'Heads up',
  'bp_width' => 'paragraph--width--medium',
  'bp_callout_content' => [
    ['target_id' => $inner->id(), 'target_revision_id' => $inner->getRevisionId()],
  ],
]);
$callout->save();
// then attach to a node's paragraphs field:
// $node->field_page_content[] = ['target_id' => $callout->id(), 'target_revision_id' => $callout->getRevisionId()];
```

## Adding a new style

Append to the storage's allowed values and add matching CSS — the value string *is* the class:

```bash
drush php:eval '
  $s = \Drupal\field\Entity\FieldStorageConfig::loadByName("paragraph", "bp_callout_style");
  $v = $s->getSetting("allowed_values");
  $v[] = ["value" => "callout-style--brand", "label" => "Brand"];
  $s->setSetting("allowed_values", $v)->save();'
```
