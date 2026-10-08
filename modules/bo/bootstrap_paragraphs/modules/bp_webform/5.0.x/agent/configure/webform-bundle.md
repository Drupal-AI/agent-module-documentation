<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_webform` bundle — fields, displays, and how to use it

Everything is config in **`config/install/`** (not `config/optional/` like the other bp_*
submodules). No settings form (`configure: null`); the bundle appears at
`/admin/structure/paragraphs_type/bp_webform`.

## Config objects installed

```
paragraphs.paragraphs_type.bp_webform            # id: bp_webform, label: Webform
field.storage.paragraph.bp_webform               # type: webform, cardinality: 1
field.field.paragraph.bp_webform.bp_webform      # label "Webform"
field.field.paragraph.bp_webform.bp_width        # parent storage (list_string)
field.field.paragraph.bp_webform.bp_background   # parent storage (list_string)
core.entity_form_display.paragraph.bp_webform.default
core.entity_view_display.paragraph.bp_webform.default
```

`bp_width` and `bp_background` reuse the storages installed by **bootstrap_paragraphs**, so
their allowed values are shared with every bp_* bundle
(`paragraph--width--{tiny,narrow,medium,wide,full}`; backgrounds such as
`paragraph--color paragraph--color--info`). List them with
`drush cget field.storage.paragraph.bp_width settings.allowed_values`.

## The webform reference field

`field.storage.paragraph.bp_webform`:

```yaml
type: webform                     # provided by contrib webform
settings: { target_type: webform }
cardinality: 1
translatable: true
```

`field.field.paragraph.bp_webform.bp_webform`:

```yaml
field_type: webform
settings:
  handler: 'default:webform'
  handler_settings:
    target_bundles: null          # any webform may be selected
    auto_create: false
  default_data: ''                # per-reference prepopulated data (YAML)
  status: open                    # open | closed | scheduled
  open: ''                        # ISO datetime, used when status: scheduled
  close: ''
```

`default_data`, `status`, `open` and `close` are **columns on the field item**, not just
instance defaults — each individual paragraph can carry its own values, so the same Webform
can be open on one page and closed on another.

To restrict which webforms editors may pick:

```bash
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "bp_webform", "bp_webform");
  $s = $f->getSettings();
  $s["handler_settings"]["target_bundles"] = ["contact" => "contact"];
  $f->set("settings", $s)->save();
'
```

## Default form display (`…form_display.paragraph.bp_webform.default`)

| Field | Widget | Weight |
|---|---|---|
| `bp_background` | `options_select` | 0 |
| `bp_width` | `options_select` | 1 |
| `bp_webform` | **`webform_entity_reference_select`** | 2 |

`created`, `status` and `uid` are hidden. `webform_entity_reference_select` is a plain
select of the available webforms; swap it for `webform_entity_reference_autocomplete` if the
site has many forms.

## Default view display (`…view_display.paragraph.bp_webform.default`)

| Field | Formatter | Settings |
|---|---|---|
| `bp_background` | `list_key` | — |
| `bp_width` | `list_key` | — |
| `bp_webform` | `webform_entity_reference_entity_view` | `source_entity: false` |

All labels hidden; `created` and `uid` hidden.

`source_entity: false` means the rendered form is **not** told the host node is its source
entity, so submissions are not attached to that node and per-node submission limits do not
apply. Flip it to attach them:

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")
    ->load("paragraph.bp_webform.default");
  $c = $vd->getComponent("bp_webform");
  $c["settings"]["source_entity"] = TRUE;
  $vd->setComponent("bp_webform", $c)->save();
'
```

**No template.** This module ships no twig and no library, so unlike `bp_quicklinks` /
`bp_statistics` the `bp_width` and `bp_background` values are *printed as text* by `list_key`
rather than being mapped into wrapper CSS classes. If you want the usual Bootstrap Paragraphs
styling, add your own `paragraph--bp-webform.html.twig` modelled on the parent module's
templates (whitelist the values, merge them into `attributes.addClass()`), or hide those two
fields on the view display.

## Exposing the bundle to editors

```bash
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  FieldStorageConfig::create([
    "field_name" => "field_page_sections", "entity_type" => "node",
    "type" => "entity_reference_revisions", "cardinality" => -1,
    "settings" => ["target_type" => "paragraph"],
  ])->save();
  FieldConfig::create([
    "field_name" => "field_page_sections", "entity_type" => "node",
    "bundle" => "article", "label" => "Sections",
    "settings" => [
      "handler" => "default:paragraph",
      "handler_settings" => ["target_bundles" => ["bp_webform" => "bp_webform"]],
    ],
  ])->save();
'
```

## Creating one programmatically

```php
use Drupal\paragraphs\Entity\Paragraph;
$p = Paragraph::create([
  'type' => 'bp_webform',
  'bp_width' => 'paragraph--width--medium',
  'bp_background' => 'paragraph--color paragraph--color--info',
  'bp_webform' => [[
    'target_id' => 'contact',      // webform machine name
    'status' => 'open',
    'default_data' => '',
  ]],
]);
$p->save();
$node->set('field_page_sections', [$p])->save();
```

Read it back: `$p->get('bp_webform')->target_id` (and `->status`, `->open`, `->close`,
`->default_data`).

## Uninstall note

Because the config is in `config/install`, `drush pmu bp_webform` **does** remove the
`bp_webform` paragraph type, its fields and its displays — along with any paragraph content
of that bundle. That is the opposite of the `config/optional` behaviour of `bp_quicklinks`,
`bp_statistics` and the other siblings.
