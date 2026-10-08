# Setup — vocabulary, icons, and wiring a field

## What install creates

- Taxonomy vocabulary **`icons`** (name "Icons").
- On each `icons` term:
  - `field_symbol_id` — string, **required**, must be **unique** within the vocabulary
    (validated in `icon_select_taxonomy_form_validate`). Becomes the SVG `<symbol id>`. Use
    lowercase, e.g. `ui-check`.
  - `field_svg_file` — a `file` field (public scheme), one SVG per term.

No settings route is registered; the module has no `configure` link.

## Adding an icon

Add a term to the `icons` vocabulary (`/admin/structure/taxonomy/manage/icons/add`), give it a
unique **Symbol ID** and upload one **SVG file**. On save (`hook_ENTITY_TYPE_insert/update/delete`)
the module regenerates the sprite. Prefer SVGs with a `viewBox` (missing viewBox renders a visible
"Missing viewBox" placeholder). Programmatic create:

```php
$term = \Drupal\taxonomy\Entity\Term::create([
  'vid' => 'icons',
  'name' => 'UI Check',
  'field_symbol_id' => 'ui-check',
  'field_svg_file' => ['target_id' => $file->id()],
]);
$term->save();
```

## Sprite path

The sprite is written to `public://<path>` where `<path>` is `icon_select.settings:path`
(default `icons/icon_select_map.svg`). This value is edited on the **icons vocabulary edit
form** (`/admin/structure/taxonomy/manage/icons`), where `icon_select` adds a "Path of SVG
sprite file" textfield; saving re-runs sprite generation. Set it directly with:

```bash
drush cset icon_select.settings path 'icons/icon_select_map.svg' -y
```

## Using an icon on content (widget + formatter)

1. Add an **Entity reference** field to your bundle, target type **Taxonomy term**, target
   bundle **Icons**.
2. On *Manage form display*, switch that field's widget to **Icon Select**
   (`icon_select_widget_default`) — a visual checkbox-style picker.
3. On *Manage display*, switch the formatter to **SVG Icon**
   (`icon_select_formatter_default`) — renders `<svg><use xlink:href="#symbol-id"></svg>`.

Programmatic wiring (form + view display):

```php
$efd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$efd->setComponent('field_my_icon', ['type' => 'icon_select_widget_default'])->save();

$evd = \Drupal::service('entity_display.repository')->getViewDisplay('node', 'article', 'default');
$evd->setComponent('field_my_icon', ['type' => 'icon_select_formatter_default'])->save();
```

Both plugins only accept `entity_reference` fields. The picker and inline preview load the
`icon_select/drupal.icon_select_backend` / `…_frontend` libraries and fetch the sprite via XHR
(works with S3FS if bucket CORS allows the request).
