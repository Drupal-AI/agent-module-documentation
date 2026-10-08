# Configure the class formatters

There is **no settings page**. You pick one of these formatters on a field row of a bundle's
*Manage display* (`/admin/structure/types/manage/<type>/display`), click the gear, set the
**Element class** (space-separated) plus any formatter-specific options, Update, Save. The choice
is stored in the `entity_view_display` config entity:

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  <field_name>:
    type: link_class            # the formatter id
    settings:
      class: 'btn btn-primary'  # the added element class(es)
      # ... plus formatter-specific settings ...
```

## Formatters (id → field types → notable settings)

| Formatter id | Field types | Extra settings (besides `class`) |
|---|---|---|
| `link_class` | link | core Link settings: `trim_length`, `url_only`, `url_plain`, `rel`, `target` |
| `link_ally_class` | link, string | `link_text`, `screenreader_text`, `tag` (wrapper) |
| `link_list_class` | link | `list_type` (`ul`/`ol`), plus core Link settings |
| `image_class` | image | all core Image formatter settings (image style, link) |
| `file_link_class` | file | `use_description_as_link_text`, `show_filesize`, `show_filetype`, `use_label_as_fallback` |
| `email_link_class` | email | – (adds class to the mailto link) |
| `telephone_link_class` | telephone | `title` |
| `entity_reference_label_class` | entity_reference | `link` (bool), `tag` (for non-linked label) |
| `entity_reference_list_label_class` | entity_reference | `link` (bool), `list_type` |
| `string_list_class` | string, string_long | `list_type`, `link` (bool) |
| `list_string_list_class` | list_string | `list_type`, `link` (bool) |
| `wrapper_class` | email, string, string_long, text, text_long, text_with_summary | `tag` (`span`/`div`/`p`/`strong`/`h1`–`h5`), `link` + `link_class`, `summary`, `trim` |

(Submodule adds `responsive_image_class` for image fields — see the submodule doc.)

The **"Element class"** field is added by `ElementClassTrait::elementClassSettingsForm()`; the
class is applied to `#options.attributes.class` (links), `#item_attributes.class` (entities/images),
the list wrapper, or the `html_tag` element (wrapper), depending on the trait used.

## Set it with drush / PHP

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_links', [
  'type' => 'link_class',
  'label' => 'hidden',
  'settings' => ['class' => 'btn btn-primary', 'target' => '_blank'],
  'weight' => 0, 'region' => 'content',
])->save();
```

Read it back:
`drush cget core.entity_view_display.node.article.default content.field_links`
(look for `type: link_class` and `settings.class`).

## Config schema

Each formatter validates against `field.formatter.settings.<id>` in
`config/schema/element_class_formatter.schema.yml` (e.g. `field.formatter.settings.wrapper_class`
maps `class`, `tag`, `link`, `link_class`, `summary`, `trim`). `image_class` extends
`field.formatter.settings.image`; the submodule's `responsive_image_class` extends
`field.formatter.settings.responsive_image`.
