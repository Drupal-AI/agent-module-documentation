<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & URL tricks

## Prerequisite: Standalone media URL

The module only works when core Media's **Standalone media URL** is enabled
(`media.settings` → `standalone_url: true`, at `/admin/config/media/media-settings`). Otherwise
media has no canonical URL to override, and `hook_requirements` shows a warning on the status report.

```bash
drush cset media.settings standalone_url true -y
```

## Settings form

Route `media_alias_display.settings_form` at **`/admin/config/media/media_alias_display`**
(permission `administer site configuration`; menu link under *Configuration → Media*). Config
object `media_alias_display.settings`:

| Key | Type | Meaning |
|---|---|---|
| `kill_switch` | boolean | When `true`, disables the module entirely — all media render normally. |
| `media_bundles` | sequence of media type ids | Allow-list of bundles the file-streaming applies to. **Empty = all bundles.** |

Form fields: a "Media Bundles" checkboxes group (unchecked = all) and a "Kill Switch" checkbox.
On submit `media_bundles` is stored as `array_filter($values)` (only the checked ids).

```bash
drush cget media_alias_display.settings
```
```php
\Drupal::configFactory()->getEditable('media_alias_display.settings')
  ->set('kill_switch', FALSE)
  ->set('media_bundles', ['document' => 'document'])  // only the Document bundle; [] = all
  ->save();
```

## Query-string behaviours (append to a media alias)

| Query arg | Effect |
|---|---|
| `?edit-media` | Redirects to the media **edit form** — for users with `edit own/any <bundle> media` or `administer media`. |
| `?dl` or `?download` | Sends the file as an **attachment** (forces download) instead of inline display. |

These are also cache contexts on the response (`url.query_args:edit-media`, `:dl`, `:download`),
alongside `user.permissions` and `media_alias_display_kill_switch_toggle`.
