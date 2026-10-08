# Add a CSS class to an image field

No configure route (`configure: null`) and no settings form. You set the class per field, per view
mode, on the entity's **Manage display** page, or directly in the `entity_view_display` config.

## Which formatters expose the "Class" field

Only these four (`image_class_field_formatter_third_party_settings_form()` checks the plugin id):

- `image` — core Image
- `responsive_image` — core Responsive image
- `media_thumbnail` — Media thumbnail
- `media_responsive_thumbnail` — Media responsive thumbnail

For any other formatter the textfield does not appear.

## Where the setting is stored

Config entity: `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: image                 # or responsive_image / media_thumbnail / media_responsive_thumbnail
    settings: { ... }
    third_party_settings:
      image_class:
        class: 'img-fluid rounded'   # space-separated classes
```

## Via the UI

1. Go to the bundle's *Manage display* (e.g. Article: `/admin/structure/types/manage/article/display`).
2. Ensure the image field uses the **Image** (or Responsive/Media thumbnail) formatter.
3. Click the gear/cog on the field's row.
4. Enter space-separated classes in **Class** (description: "Enter space separated classes which will be added to the `<img>` element.").
5. **Update**, then **Save**. The formatter summary then shows "Class: `<value>`".

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_image');            // must use an image/media-thumbnail formatter
$c['third_party_settings']['image_class']['class'] = 'img-fluid rounded';
$vd->setComponent('field_image', $c)->save();
```

Read it back:
```bash
drush cget core.entity_view_display.node.article.default content.field_image
# look for third_party_settings.image_class.class
```

## How it reaches the markup

`hook_preprocess_field()` loads the display component, splits `class` on spaces, **merges** it with
any existing `#item_attributes['class']` (so pre-set classes are preserved), and assigns the result
back to `#item_attributes['class']` for every delta — landing on the `<img>` tag. Schema:
`field.formatter.third_party.image_class` (single string `class`).
