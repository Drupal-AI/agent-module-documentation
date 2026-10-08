# The `extra_image_field_classes` formatter

`src/Plugin/Field/FieldFormatter/ExtraImageFieldClassesFormatter.php` — extends core
`ImageFormatter`, so it keeps all core image-formatter options (image style, link to
content/file) and adds one setting.

## Setting
| Key | Type | Default | Notes |
|---|---|---|---|
| `extra_image_field_classes` | string | `''` | Space-separated CSS class names. Shown on the formatter settings form ("Provide spaces for separating CSS class names") and in the settings summary. |

## Behavior
`viewElements()` calls the parent (core image rendering) then, for each element, appends the
setting to `#item_attributes['class']`:
```php
$element['#item_attributes']['class'][] = $this->getSetting('extra_image_field_classes');
```
So the whole string is added as one class-list entry on the `<img>` element's attributes.

## How to configure
Field UI → the entity's **Manage Display** → set the image field's format to *Extra Image Field
Classes* → click the gear → enter classes → **Update** → **Save**. (Field UI must be enabled to
reach Manage Display; it is not required to render.)

Via exported config, set the field's formatter to `extra_image_field_classes` with
`settings.extra_image_field_classes: 'your classes'` on the relevant
`core.entity_view_display.*` config.

Note: the class string is administrator-entered formatter config; it is emitted onto image
markup as-is.
