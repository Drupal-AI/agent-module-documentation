<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Insert Media

Insert Media has **no** global config object or configure route. Everything is a per-widget
third-party setting on a `media_library_widget` component, set on *Manage form display*.

## Where the setting is stored

```
core.entity_form_display.<entity_type>.<bundle>.<form_mode>
  -> content.<field_name>.third_party_settings.insert_media
```

Keys (defaults from `INSERT_MEDIA_DEFAULT_SETTINGS`):

| Key | Meaning | Default |
|---|---|---|
| `view_modes` | map of **enabled** media view modes (`{id: id}`); may hold the special `<all>` key; empty ⇒ Insert Media disabled | `[]` |
| `default` | view mode used by default / when only one is enabled | `full` |

The selectable options are the media entity's **view modes** (e.g. `full`, `embedded`, `thumbnail`,
`media_library`, `default`), returned by `insert_media_insert_styles()` for the `media` insert type.

## Requirements

- The field must be an entity_reference field targeting `media` and use the **`media_library_widget`**
  widget (that plugin id is the only Insert Media source, per `hook_insert_widgets`).
- `insert` and `media_library` must be enabled.

## Via the UI

1. On *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`), set the
   media field's widget to **Media library**.
2. Click the cog → open **Insert Media**.
3. Tick the view modes to offer and pick a **Default view mode**.
4. **Update**, then **Save**. The summary reads `Insert Media: <view modes>` or `Insert Media: disabled`.

## Via drush php:eval (scriptable)

```php
$s = \Drupal::entityTypeManager()->getStorage('entity_form_display');
$fd = $s->load('node.article.default');
$c = $fd->getComponent('field_media');            // must be media_library_widget
$c['third_party_settings']['insert_media'] = [
  'view_modes' => ['full' => 'full', 'thumbnail' => 'thumbnail'],
  'default' => 'full',
];
$fd->setComponent('field_media', $c)->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_media
# look for third_party_settings.insert_media.view_modes / .default
```

No config schema ships for this third-party key, so the array is stored as-is.
