# Configure the responsive image class formatter

This submodule adds exactly one field formatter, **`responsive_image_class`** (label
"Responsive image (with class)"), for **`image`** fields. There is **no settings page** — it is
selected per field on a bundle's *Manage display*
(`/admin/structure/types/manage/<type>/display`): pick "Responsive image (with class)" on the
image field row, click the gear, choose a **Responsive image style** and **Link image to** option
(the standard core Responsive Image controls), fill in **Element class** (space-separated), Update,
Save.

The choice is stored in the `entity_view_display` config entity:

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  <image_field>:
    type: responsive_image_class
    settings:
      responsive_image_style: wide        # core setting
      image_link: ''                       # core setting: '', 'content', or 'file'
      class: 'img-fluid rounded'           # the added element class(es)
```

## Settings

| Setting | Source | Notes |
|---|---|---|
| `responsive_image_style` | core `ResponsiveImageFormatter` | Machine name of a `responsive_image.styles.*` entity. |
| `image_link` | core `ResponsiveImageFormatter` | `''` (none), `content`, or `file`. |
| `class` | this submodule (via `ElementEntityClassTrait`) | Space-separated CSS classes, textfield, `#maxlength` 200, default `''`. |

The **Element class** field is added by `ElementClassTrait::elementClassSettingsForm()` (title
"Element class", description "A space separated set of classes."). When set, the settings summary
line reads `Element class: <class>` via `elementClassSettingsSummary()`.

## What happens at runtime

`ResponsiveImageClassFormatter` extends core `ResponsiveImageFormatter` and mixes in
`Drupal\element_class_formatter\Plugin\Field\FieldFormatter\ElementEntityClassTrait`:

- `defaultSettings()` → `elementClassDefaultSettings(parent::defaultSettings())` adds `class => ''`.
- `settingsForm()` / `settingsSummary()` → call `parent`, then append the class textfield / summary.
- `viewElements()` → calls `parent::viewElements()` to build the normal responsive-image render
  array, gets the referenced files via `getEntitiesToView()`, then
  `setEntityClass($elements, $class, $entities)` appends the class to
  **`$elements[$delta]['#item_attributes']['class'][]`** for each item. The core
  `responsive_image_formatter` theme applies `#item_attributes` to the rendered `<img>`, so the
  class lands on the image element (not the field wrapper). Verified by the module's functional
  test asserting `img.<class>` exists.

Because the class is applied through `#item_attributes`, Drupal's render/Attribute layer escapes
the value on output; the setting is only reachable to users who can edit display config.

## Set it with drush / PHP

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_image', [
  'type' => 'responsive_image_class',
  'label' => 'hidden',
  'settings' => [
    'responsive_image_style' => 'wide',
    'image_link' => '',
    'class' => 'img-fluid rounded',
  ],
  'weight' => 0,
  'region' => 'content',
])->save();
```

Read it back:
`drush cget core.entity_view_display.node.article.default content.field_image`
(look for `type: responsive_image_class` and `settings.class`).

## Config schema

`config/schema/element_class_formatter_responsive_image.schema.yml` declares
`field.formatter.settings.responsive_image_class`, which **extends**
`field.formatter.settings.responsive_image` (inheriting `responsive_image_style` / `image_link`)
and adds a single `class` string. No standalone config object.

## Installation note

The submodule depends on `element_class_formatter` and core `responsive_image`. On existing sites
the parent module's `element_class_formatter_update_8001()` auto-installs this submodule when
`responsive_image` is already enabled. The formatter reuses core image fields (there is no separate
"responsive image" field type), which is why its `field_types` is `image`.

The class-adding mechanism is the same one the parent module's entity/image formatters use — see the
parent's `configure/formatters.md` and `extend/traits.md` for the shared `ElementEntityClassTrait`
pattern.
