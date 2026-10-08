# Field formatters

The module ships two formatters. One renders the `representative_image` field itself; the other lets a
plain entity-reference field render *its target entities'* representative images.

| Formatter id | For field type | Class | Config schema |
|---|---|---|---|
| `representative_image` | `representative_image` | `RepresentativeImageFormatter` | `field.formatter.settings.representative_image` |
| `entity_representative_image` | `entity_reference` | `EntityReferenceRepresentativeImage` | `field.formatter.settings.entity_representative_image` |

## `representative_image` (RepresentativeImageFormatter)

`Plugin/Field/FieldFormatter/RepresentativeImageFormatter` extends the core image
`ImageFormatter`, so it exposes the **same settings** as the core Image formatter — `image_style` and
`image_link` (`''` | `content` | `file`). Schema `field.formatter.settings.representative_image`
extends `field.formatter.settings.image` (`schema.yml:26`). This is the `default_formatter` of the
field type.

`viewElements()` (`RepresentativeImageFormatter.php:42`) resolves the image via
`representative_image.picker->getImageFieldItemList($items)`; if nothing resolves it renders nothing.
Otherwise it themes `#theme => 'image_formatter'` with the chosen `image_style` and, for `image_link`,
links to the host entity (`content`) or the image file (`file`).

Set it from code:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_representative_image', [
    'type' => 'representative_image',
    'label' => 'hidden',
    'settings' => ['image_style' => 'large', 'image_link' => 'content'],
  ])->save();
```

## `entity_representative_image` (EntityReferenceRepresentativeImage)

`Plugin/Field/FieldFormatter/EntityReferenceRepresentativeImage` extends
`EntityReferenceFormatterBase` and applies to `entity_reference` fields. Use it in a view/listing (e.g.
a view referencing mixed content) to show *each referenced entity's* representative image with one
formatter, regardless of that entity's own image structure.

- `isApplicable()` (`EntityReferenceRepresentativeImage.php:66`) only offers the formatter when the
  referenced entity type actually has a `representative_image` field
  (`entity_field.manager->getFieldMapByFieldType('representative_image')`).
- Settings (`defaultSettings`): `type` (an inner **image** formatter id, default `image`, chosen from
  `plugin.manager.field.formatter->getOptions('image')`) and `settings` (that inner formatter's
  settings). The settings form rebuilds the inner formatter's sub-form over AJAX
  (`onFormatterTypeChange`). Schema `field.formatter.settings.entity_representative_image`
  (`schema.yml:30`): `type` (string) + `settings` (`field.formatter.settings.[%parent.type]`).
- `viewElements()` (`EntityReferenceRepresentativeImage.php:199`): for each referenced entity that has
  a representative image field, resolves it via the picker and renders it with the chosen inner image
  formatter (`label => hidden`).

```php
->setComponent('field_related', [
  'type' => 'entity_representative_image',
  'settings' => [
    'type' => 'image',
    'settings' => ['image_style' => 'thumbnail', 'image_link' => ''],
  ],
])
```

## Views

Because these are field formatters, the representative image is available as a normal field in Views
(add the `representative_image` field and pick an image style), and in any view mode / Layout Builder
component. No Views-specific plugins are provided.
