<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_quicklinks` bundle — fields, displays, and how to use it

Everything this module does is config in `config/optional/`. There is no settings form
(`configure: null`) and no admin page of its own; the bundle appears at
`/admin/structure/paragraphs_type/bp_quicklinks`.

## Config objects installed

```
paragraphs.paragraphs_type.bp_quicklinks              # id: bp_quicklinks, label: Quicklinks
field.storage.paragraph.bp_quick_link                 # link, cardinality: -1, translatable
field.field.paragraph.bp_quicklinks.bp_quick_link     # label "Quick link"
field.field.paragraph.bp_quicklinks.bp_header         # reuses parent storage (string)
field.field.paragraph.bp_quicklinks.bp_width          # reuses parent storage (list_string)
field.field.paragraph.bp_quicklinks.bp_background     # reuses parent storage (list_string)
core.entity_form_display.paragraph.bp_quicklinks.default
core.entity_view_display.paragraph.bp_quicklinks.default
```

Only `bp_quick_link` has its own storage; `bp_header`, `bp_width` and `bp_background` reuse
the storages that **bootstrap_paragraphs** installs, so their allowed values are shared with
every other bp_* bundle.

## Field settings that matter

`field.field.paragraph.bp_quicklinks.bp_quick_link`:

```yaml
field_type: link
settings:
  link_type: 17   # LinkItemInterface::LINK_GENERIC — internal OR external URLs
  title: 1        # DRUPAL_OPTIONAL — link text is offered but not required
```

`field.storage.paragraph.bp_quick_link`: `type: link`, `cardinality: -1` (unlimited),
`translatable: true`.

`bp_width` allowed values (from the parent storage) — `paragraph--width--tiny`,
`--narrow`, `--medium`, `--wide`, `--full`.
`bp_background` allowed values are the long parent list, e.g.
`paragraph--color paragraph--color--primary`, `… --secondary`, `… --success`, `… --info`,
`… --warning`, `… --danger`, plus the `… --rgba-<color>-{slight,light,strong}` family and
`paragraph--color--transparent`. Read them with
`drush cget field.storage.paragraph.bp_background settings.allowed_values`.

## Default form display (`…form_display.paragraph.bp_quicklinks.default`)

| Field | Widget | Weight |
|---|---|---|
| `bp_header` | `string_textfield` (size 60) | 0 |
| `bp_background` | `options_select` | 1 |
| `bp_width` | `options_select` | 2 |
| `bp_quick_link` | **`link_attributes`** | 3 |

`created`, `status`, `uid` are hidden. The `link_attributes` widget settings ship as:

```yaml
enabled_attributes:
  target: true
  rel: true
  id: false
  name: false
  class: false
  accesskey: false
  aria-label: false
```

To offer editors more per-link attributes, flip the ones you want to `true`:

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")
    ->load("paragraph.bp_quicklinks.default");
  $c = $fd->getComponent("bp_quick_link");
  $c["settings"]["enabled_attributes"]["class"] = TRUE;
  $c["settings"]["enabled_attributes"]["aria-label"] = TRUE;
  $fd->setComponent("bp_quick_link", $c)->save();
'
```

## Default view display

All four fields are `label: hidden`. `bp_quick_link` uses the core `link` formatter with
`trim_length: null, url_only: false, url_plain: false, rel: '0', target: '0'`; `bp_header`
uses `string`; `bp_width`/`bp_background` use `list_default`. In practice the formatters
barely matter — the bundle's twig template rebuilds the markup (see
[../theming/template.md](../theming/template.md)).

## Exposing the bundle to editors

The module does **not** attach anything to a content type. Add an
`entity_reference_revisions` (Paragraphs) field and allow the bundle:

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
      "handler_settings" => ["target_bundles" => ["bp_quicklinks" => "bp_quicklinks"]],
    ],
  ])->save();
'
```

Then place the field on the node form display (widget `paragraphs` or
`entity_reference_paragraphs`) and on the node view display
(`entity_reference_revisions_entity_view`).

## Creating a Quicklinks paragraph programmatically

```php
use Drupal\paragraphs\Entity\Paragraph;
$p = Paragraph::create([
  'type' => 'bp_quicklinks',
  'bp_header' => 'Helpful Resources',
  'bp_width' => 'paragraph--width--wide',
  'bp_background' => 'paragraph--color paragraph--color--info',
  'bp_quick_link' => [
    ['uri' => 'internal:/node', 'title' => 'All content'],
    ['uri' => 'https://www.drupal.org', 'title' => 'Drupal.org'],
  ],
]);
$p->save();
$node->set('field_page_sections', [$p])->save();
```

Read it back: `drush php:eval '…$p->get("bp_quick_link")->getValue();'` or
`drush cget core.entity_form_display.paragraph.bp_quicklinks.default content.bp_quick_link`.

## Uninstall note

The config is `optional`, not `install` — Drupal imports it once and then it belongs to the
site. `drush pmu bp_quicklinks` leaves the `bp_quicklinks` paragraph type and its fields in
place; delete them yourself if you want them gone.
