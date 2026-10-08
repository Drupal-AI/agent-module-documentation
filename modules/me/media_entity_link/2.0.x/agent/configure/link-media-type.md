<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Link media type and its source field

The module needs **no configuration** — everything below is installed automatically from
`config/install` when you enable it.

## What ships

| Config | What it is |
|---|---|
| `media.type.link` | the **Link** media type: id `link`, `source: link`, `source_configuration.source_field: field_media_entity_link`. |
| `field.storage.media.field_media_entity_link` | field storage, core `link` type, cardinality 1, on the `media` entity type. |
| `field.field.media.link.field_media_entity_link` | the field on the `link` bundle, `required: true`, label "Link". |
| `core.entity_form_display.media.link.default` / `.media_library` | form displays. |
| `core.entity_view_display.media.link.default` / `.media_library` | view displays (source field rendered with the `link` formatter, label hidden). |

Manage the type at *Structure → Media types → Link* (`/admin/structure/media/manage/link`)
and its fields at `/admin/structure/media/manage/link/fields`. You can add your own fields
(description, category, thumbnail, …) like any media type.

## Restricting internal vs external links

Whether a Link media may point to internal paths, external URLs, or both is the **standard core
Link field** setting `link_type` on `field.field.media.link.field_media_entity_link`:

| `link_type` value | Constant | Meaning |
|---|---|---|
| `1` | `LinkItemInterface::LINK_INTERNAL` | internal paths only |
| `16` | `LinkItemInterface::LINK_EXTERNAL` | external URLs only |
| `17` | `LinkItemInterface::LINK_GENERIC` | both (shipped default) |

Change it in the UI (field settings → *Allowed link type*) or with drush:

```bash
drush cget field.field.media.link.field_media_entity_link settings
drush cset field.field.media.link.field_media_entity_link settings.link_type 16 -y   # external only
```

The Media Library add form reads this setting and adjusts its URL box accordingly (external-only
vs. entity autocomplete for internal, plus the `<front>` / `<nolink>` / `<button>` tokens).

## Creating a Link media entity (scriptable)

```php
$media = \Drupal::entityTypeManager()->getStorage('media')->create([
  'bundle' => 'link',
  'name' => 'Drupal.org',
  'field_media_entity_link' => ['uri' => 'https://www.drupal.org', 'title' => ''],
]);
$media->save();
```

Read a link's URL back:

```php
$media->get('field_media_entity_link')->first()->get('uri')->getValue();   // 'https://www.drupal.org'
```
