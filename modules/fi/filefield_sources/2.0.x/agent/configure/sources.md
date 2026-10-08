# Enable file sources on a widget

There is no admin settings page. You enable sources **per field, per form mode**, on the widget of a
File or Image field, from the entity's *Manage form display* page — or directly in the
`entity_form_display` config.

## Where it is stored

Config entity `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`, within the widget
component:

```yaml
content:
  field_attachment:
    type: file_generic            # or image_image
    settings: { ... }
    third_party_settings:
      filefield_sources:
        filefield_sources:
          sources:                # enabled source ids (disabled ones are 0)
            upload: upload
            remote: remote
            reference: reference
          source_reference:       # per-source settings groups (optional)
            autocomplete: '0'
            search_all_fields: '0'
          source_attach:
            path: ''
            absolute: 0
            attach_mode: move
          source_remote:
            transfer_options: ...
```

- `sources` is a checkboxes value: an enabled source is `id => id`, a disabled one is `id => 0`.
- `upload` (core's default) is auto-added by `_filefield_sources_enabled()` whenever the setting
  exists, so it is effectively always on.
- Built-in ids: `upload`, `remote`, `reference`, `attach`, `imce`, `clipboard`. `imce` is only
  offered when the IMCE module is installed and the user passes `Imce::access()`.

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. Click the gear on a **File** or **Image** field row (widget `file_generic` / `image_image`).
3. Open **File sources**, tick the sources to enable, set any per-source options.
4. **Update**, then **Save**. The widget summary then shows "File field sources: …".

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_attachment');          // a file_generic / image_image widget
$c['third_party_settings']['filefield_sources']['filefield_sources']['sources'] = [
  'upload' => 'upload', 'remote' => 'remote',
];
$fd->setComponent('field_attachment', $c)->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_attachment
# look for third_party_settings.filefield_sources.filefield_sources.sources
```

## Config schema

`field.widget.third_party.filefield_sources` maps `filefield_sources` as a sequence of
`filefield_sources.setting.<key>`, so `sources` and the per-source setting groups
(`source_attach`, `source_reference`, `source_remote`, …) are validated when saving the form
display.
