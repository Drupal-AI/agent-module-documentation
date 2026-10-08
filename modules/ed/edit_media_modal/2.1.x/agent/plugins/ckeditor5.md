# The CKEditor 5 plugin & its settings

## Plugin

Defined in `edit_media_modal.ckeditor5.yml` as **`media_edit_media_modal`** (provider `media`):

- Adds the CKEditor 5 plugin `editMediaModal.EditMediaModal`.
- Injects `editMediaButton` into the `drupalMedia.toolbar` — i.e. an "edit" button appears on the
  balloon toolbar of an embedded media item.
- `conditions.plugins: [media_media]` — it only activates when the core Drupal Media (drupalMedia)
  CKEditor plugin is enabled on that text format.
- Config class `Drupal\edit_media_modal\Plugin\CKEditor5Plugin\EditMediaModalSettings`
  (implements `CKEditor5PluginConfigurableInterface`), library
  `edit_media_modal/edit_media_modal_ckeditor5`.

There is **no separate settings form/route** for the module. You configure it on the text
format: *Configuration → Content authoring → Text formats and editors → (a CKEditor 5 format) →
edit*, in the CKEditor 5 plugin settings section for "Edit Media Modal".

## Settings (per text format)

Stored inside `editor.editor.<format>` at
`settings.plugins.media_edit_media_modal.editMediaModal`:

```yaml
settings:
  plugins:
    media_edit_media_modal:
      editMediaModal:
        dialogSettings:
          height: '75'          # modal height in percent (form input 1–100); default '75'
        extras:
          skipAccessCheck: false # bool: skip the per-item media edit access check in CKEditor
        editMediaModalForms:      # media bundle -> form mode id (or 'default')
          image: default
          document: quick_edit   # example: use a custom media form mode for documents
```

- `dialogSettings.height` — the modal window height (percent).
- `extras.skipAccessCheck` — when true, the CKEditor edit button appears without checking whether
  the user can edit each media entity (fine for simple sites, not for complex permissions).
- `editMediaModalForms` — for each media bundle, which **form mode** to load inside the modal
  (`default` or any media form mode). `hook_entity_form_display_alter` swaps the media form
  display to this mode based on the `text_format` query parameter passed to the edit URL.

Read / write via drush (config path uses dots):

```bash
drush cget editor.editor.full_html settings.plugins.media_edit_media_modal
drush cset editor.editor.full_html settings.plugins.media_edit_media_modal.editMediaModal.dialogSettings.height 90 -y
```

Config schema: `ckeditor5.plugin.media_edit_media_modal` (in `config/schema`) defines
`editMediaModal.dialogSettings.height`, `editMediaModal.extras.skipAccessCheck`, and the
`editMediaModalForms` sequence.
