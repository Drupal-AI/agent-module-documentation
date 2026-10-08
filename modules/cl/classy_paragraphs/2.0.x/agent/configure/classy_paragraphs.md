# Configure classy_paragraphs

Two pieces: (1) create **styles** (the class catalog), (2) add a **reference field** to a
Paragraph type so editors can pick them.

## The style config entity

- Entity type: `classy_paragraphs_style` (config entity).
- Config name pattern: `classy_paragraphs.classy_paragraphs_style.<id>`.
- Exported keys: `id`, `label`, `classes`, `uuid`.
- `classes` is a single **string**, one CSS class per line (split on `\r\n` at render time).
- Admin UI: `/admin/structure/classy_paragraphs_style` (collection), add at
  `/admin/structure/classy_paragraphs_style/add`. Route: `entity.classy_paragraphs_style.collection`.
- Access: core **administer site configuration** (`admin_permission` on the entity type).

Create a style via drush (no bespoke command; use the entity storage):

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("classy_paragraphs_style")
  ->create(["id"=>"loud","label"=>"Loud","classes"=>"loud-background\ntext-uppercase"])->save();'
```

Read one back:

```bash
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("classy_paragraphs_style")->load("loud");
  print $s->label()."|".$s->getClasses();'
```

Delete: `->load("loud")->delete();`. List all: `->loadMultiple()`.

Equivalent config YAML (`classy_paragraphs.classy_paragraphs_style.loud.yml`):

```yaml
langcode: en
status: true
dependencies: {  }
id: loud
label: Loud
classes: "loud-background\ntext-uppercase"
```

## The field (there is no custom field type)

Editors select a style through a **core `entity_reference` field** whose storage setting
`target_type` is `classy_paragraphs_style`. Add it to any Paragraph type (or node/block):

- Field storage: `type: entity_reference`, `settings.target_type: classy_paragraphs_style`,
  `cardinality: -1` for stacking multiple styles.
- Field instance: `field_type: entity_reference`, `settings.handler:
  default:classy_paragraphs_style` (core default) **or** `classy_paragraphs` (this module's
  handler, for filter/sort options — see plugins doc).
- Form widget: `options_buttons` (checkboxes) or `options_select` (select list) so editors
  see all styles.
- Manage display: set the field to **Disabled/Hidden** — its value is applied via
  `#attributes['class']`, not printed as field output.

Programmatic field creation (drush):

```bash
drush php:eval '
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create(["field_name"=>"field_cp_classes","entity_type"=>"paragraph",
  "type"=>"entity_reference","settings"=>["target_type"=>"classy_paragraphs_style"],
  "cardinality"=>-1])->save();
FieldConfig::create(["field_name"=>"field_cp_classes","entity_type"=>"paragraph",
  "bundle"=>"my_paragraph_type","label"=>"Classes",
  "settings"=>["handler"=>"default:classy_paragraphs_style","handler_settings"=>[]]])->save();
'
```

## Twig

Classes land in `{{ attributes.class }}`. In a custom paragraph template ensure the wrapper
uses `{{ attributes.addClass(classes) }}` (or just `{{ attributes }}`) on a real HTML
element — not inside `{% block paragraph %}`/`{% block content %}`. Clear cache after adding
styles: `drush cr`. Not compatible with Display Suite / Panelizer-configured paragraphs.
