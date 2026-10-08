# Attach image styles to a consumer

The module adds a base field to the **consumer** entity
(`consumer_image_styles_entity_base_field_info()`):

- Field name: **`image_styles`**
- Type: `entity_reference` → target type `image_style`
- Cardinality: **unlimited**; widget `options_buttons` (checkboxes) on the consumer form
- Label: "Image Styles" ("Image styles this consumer will need. All images will provide all
  the variants selected here.")

There is **no module settings page** — you configure the field on each consumer at
`/admin/config/services/consumer` (edit a consumer → tick the image styles). The consumers
admin list also gains an "Image Styles" column (`hook_consumers_list_alter()`).

## Set it with Drush / PHP

```php
use Drupal\consumers\Entity\Consumer;
$consumer = Consumer::load($id);
$consumer->set('image_styles', ['thumbnail', 'large']); // image_style ids
$consumer->save();

// Read back:
$ids = array_column($consumer->get('image_styles')->getValue(), 'target_id');
```

Or when creating: `Consumer::create(['label' => 'App', 'client_id' => 'app', 'image_styles' => ['thumbnail','medium']])->save();`

At request time, JSON:API responses for that consumer get a derivative link per attached style
on each image file resource (see [../api/provider.md](../api/provider.md)). To scope styles to a
single image field instead of all images, use the field enhancer
([../plugins/field-enhancer.md](../plugins/field-enhancer.md)).
