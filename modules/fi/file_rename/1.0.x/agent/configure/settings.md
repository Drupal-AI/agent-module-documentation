<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Rename" widget link

There is **no per-field admin page of its own**; the module exposes exactly one global flag
plus a per-widget third-party setting. The rename form itself needs no configuration.

## Global flag

- Config object: `file_rename.settings`, key `always_show_widget_link` (boolean, default `1`).
- UI: `/admin/config/file_rename/settings` (route `file_rename.settings`, link under
  *Configuration → Media*), form `Drupal\file_rename\Form\SettingsForm`.
- When on, a small "Rename" link is rendered under every already-uploaded file on **every**
  file/image field widget (any widget that is or extends core `FileWidget`).

Drush:

```bash
# read
drush config:get file_rename.settings always_show_widget_link
# enable for all file widgets
drush config:set file_rename.settings always_show_widget_link 1 -y
# disable global, fall back to per-widget opt-in
drush config:set file_rename.settings always_show_widget_link 0 -y
```

## Per-widget opt-in

When the global flag is **off**, you can enable the link for a single field's widget. It is
stored as a third-party setting on that widget component in the entity form display:

`core.entity_form_display.<entity>.<bundle>.<mode>` →
`content.<field>.third_party_settings.file_rename.show_rename_link: true`

- UI: the field's **Manage form display** → widget settings cog → tick **"Show rename link"**.
  The checkbox is only offered on `FileWidget` (or subclass) widgets. If the global flag is on,
  the checkbox is shown ticked and disabled (a note links to the settings form), because the
  global setting overrides it. The manage-form-display summary shows `Show rename link: yes`.

Set it programmatically:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$component = $fd->getComponent('field_my_file');
$component['third_party_settings']['file_rename']['show_rename_link'] = TRUE;
$fd->setComponent('field_my_file', $component)->save();
```

Resolution order (see `_file_rename_widget_link_is_enabled_globally()` /
`_file_rename_link_is_enabled_for_widget()`): the link shows if the **global** flag is set
**or** the widget's `show_rename_link` third-party setting is TRUE.
