<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable Paragraph View Mode on a paragraph type

`configure: null` — there is no module settings page. The switch is a checkbox that
`hook_form_paragraphs_type_edit_form_alter()` injects into the paragraph type edit form.

## What "enabled" actually means

Enabled == the field config `paragraph.<bundle>.paragraph_view_mode` exists.
`StorageManager::getField($bundle)` is literally `FieldConfig::loadByName('paragraph', $bundle,
'paragraph_view_mode')`, and the checkbox's `#default_value` is that check.

> **Gotcha:** `config/schema/paragraph_view_mode.schema.yml` declares
> `paragraphs.paragraphs_type.*.third_party.paragraph_view_mode.enabled`, but no code path
> ever writes it. The paragraph type's third-party settings stay empty. Check for the
> FieldConfig, not for a third-party setting.

## Via the UI

1. `/admin/structure/paragraphs_type/<bundle>` (Edit on the paragraph type).
2. Tick **Enable Paragraph view mode field on this paragraph type.** → Save.
3. Go to *Manage form display* and, if needed, drag **Paragraph view mode** out of Disabled.
4. Click its cog to set *Available view modes*, *Default value*, *Bind with the form mode*,
   *Apply to preview mode*.

Unticking the checkbox and saving deletes the FieldConfig (and its data).

## Via code / drush php:eval

```php
$sm = \Drupal::service('paragraph_view_mode.storage_manager');
$sm->addField('my_bundle');            // creates field storage (once) + FieldConfig
$sm->addToFormDisplay('my_bundle');    // places it on paragraph.my_bundle.default
```

`addToFormDisplay()` only works if the form display config entity already exists; otherwise it
logs an error and warns "please place it manually". A brand-new paragraph type that has never
had its *Manage form display* saved may have no form display yet — create/save it first.

Disable again:

```php
\Drupal::service('paragraph_view_mode.storage_manager')->deleteField('my_bundle');
```

Deleting the last instance also removes the shared `FieldStorageConfig`
`paragraph.paragraph_view_mode` (core behaviour), so re-enabling recreates it.

## Where the widget settings live

Config entity `core.entity_form_display.paragraph.<bundle>.default`, component
`paragraph_view_mode`:

```yaml
content:
  paragraph_view_mode:
    type: paragraph_view_mode
    weight: -100
    region: content
    settings:
      view_modes:           # ticked view modes; array of machine name => label
        default: Default
        teaser: Teaser
      default_view_mode: default
      form_mode_bind: true      # default TRUE
      apply_to_preview: false   # default FALSE
```

Read it back:

```bash
drush cget core.entity_form_display.paragraph.<bundle>.default content.paragraph_view_mode
```

Set a setting from code:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('paragraph.my_bundle.default');
$c = $fd->getComponent('paragraph_view_mode');
$c['settings']['default_view_mode'] = 'teaser';
$c['settings']['view_modes'] = ['default' => 'Default', 'teaser' => 'Teaser'];
$fd->setComponent('paragraph_view_mode', $c)->save();
```

## Setting meanings

| Setting | Default | Effect |
|---|---|---|
| `view_modes` | all view modes available for the bundle | Options offered in the editor's select. Empty → the select falls back to a single `default` option. Only view modes enabled in *Custom display settings* on Manage display are offered. |
| `default_view_mode` | `default` | Pre-selected value for new paragraph items. |
| `form_mode_bind` | `true` | Adds AJAX to the select that reloads the paragraph subform, which lets `hook_entity_form_mode_alter()` switch the **form** mode to one with the same machine name as the chosen view mode. |
| `apply_to_preview` | `false` | When FALSE the module refuses to override the `preview` view mode, keeping Paragraphs' preview intact. |
