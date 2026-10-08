<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Image Link Formatter

There is **no settings page** (`configure: null`). You configure it on the entity's **Manage
display** page, per image field, per view mode.

## Prerequisites

- The `image` and `link` core modules are enabled (module dependencies).
- The entity/bundle has **both** an image field and at least one **Link field**. The Link field is
  what supplies the URL.

## Via the UI

1. Go to the bundle's *Manage display*, e.g. Article:
   `/admin/structure/types/manage/article/display`.
2. For the **image field**, choose the formatter **"Image wrapped within link field"**.
3. Click the field's settings cog. In the **"Link image to"** dropdown, the module has added your
   entity's Link fields (shown as `Label (field_machine_name)`) alongside core's Content/File/Nothing
   options. Pick the Link field to wrap the image with.
4. Update, then Save. The settings summary shows "Linked to &lt;Link field label&gt;".

## Config location

`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_banner_image:
    type: image_link_formatter        # the formatter
    label: hidden
    settings:
      image_style: large              # inherited from core image formatter (optional)
      image_link: field_banner_link   # <-- the Link field whose URL wraps the image
    third_party_settings: {  }
```

The `image_link` setting is core's existing "Link image to" key; this module simply lets it hold a
**link field machine name** in addition to `''` / `content` / `file`.

Programmatic setup (drush php:eval):

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_banner_image', [
  'type' => 'image_link_formatter',
  'label' => 'hidden',
  'settings' => ['image_style' => '', 'image_link' => 'field_banner_link'],
])->save();
```

Read it back:

```bash
drush cget core.entity_view_display.node.article.default content.field_banner_image
# type: image_link_formatter ; settings.image_link: field_banner_link
```

## How it renders (delta pairing)

`ImageLinkFormatterTrait::viewElements()` renders the image via core, then, if a link field is
selected, sets each image's `#url` to the **same-delta** Link item's URL:

- image delta 0 ⇒ wrapped in link delta 0
- image delta 1 ⇒ wrapped in link delta 1, etc.

If a given delta's Link item is empty, that image is left unwrapped.

## Integrations

- **Link Attributes / Link Target**: attributes on the Link item (e.g. `target="_blank"`, `rel`) are
  carried onto the image link automatically, because the link's `Url` object retains them.
- **Paragraphs / custom blocks / any entity**: works anywhere you can attach an image field and a
  link field and manage its display.

## Not available

- No configure route, no permissions, no Drush, no config schema (it reuses the core image
  formatter's schema). If you need responsive images, use the
  **responsive_image_link_formatter** submodule instead.
