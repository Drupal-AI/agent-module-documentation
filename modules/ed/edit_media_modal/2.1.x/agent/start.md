# Edit Media Entity in Modal — agent index

Adds an "edit" button to the CKEditor 5 media (drupalMedia) toolbar so an embedded Media entity
can be edited in a modal, and overrides the media `edit` form for AJAX. Depends on core `media`.
No configure route (`configure: null`), no permissions, no Drush. Its settings live inside each
text format's CKEditor 5 editor config.

- **The CKEditor 5 plugin (`media_edit_media_modal`): the edit button + its per-format settings** →
  [plugins/ckeditor5.md](plugins/ckeditor5.md)
- **Routes, the `MediaForm` override, form-display alter, and the reusable "edit in modal" link** →
  [api/routes-and-forms.md](api/routes-and-forms.md)

Key facts:
- CKEditor 5 plugin id `media_edit_media_modal`; adds `editMediaButton` to the `drupalMedia`
  toolbar; requires the core media (`media_media`) plugin to be present.
- Plugin settings are stored in `editor.editor.<format>` at
  `settings.plugins.media_edit_media_modal.editMediaModal`: `dialogSettings.height` (percent
  string, default `'75'`), `extras.skipAccessCheck` (bool, default false), and
  `editMediaModalForms` (media bundle → form-mode map).
- Overrides the media entity `edit` form class with
  `Drupal\edit_media_modal\Form\MediaForm` (`hook_entity_type_alter`).
- Routes: `/edit-media-modal/edit-url/{uuid}`, `/edit-media-modal/check-access/{uuid}`.
