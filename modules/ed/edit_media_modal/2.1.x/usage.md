Edit Media Entity in Modal lets content editors edit an embedded Media entity in a modal/AJAX dialog — most notably adding an "edit" button to the CKEditor 5 media (drupalMedia) toolbar so a media item can be edited in place without leaving the text editor.

---

The module has two parts. First, it ships a **CKEditor 5 plugin** (`media_edit_media_modal`) that adds an `editMediaButton` to the `drupalMedia` toolbar; when a text format's editor has the media button, an "edit" button appears and opens the media entity's edit form in a modal. The plugin is configurable per text format (in the CKEditor 5 plugin settings on the text-format edit page): a `skipAccessCheck` toggle, the dialog `height` (percent), and a per-media-bundle map (`editMediaModalForms`) choosing which media **form mode** to load in the modal — this configuration is stored inside the `editor.editor.<format>` config under `settings.plugins.media_edit_media_modal`. Second, it overrides the Media entity's **`edit` form class** with its own `MediaForm` (via `hook_entity_type_alter`) and alters the media form display to honor the selected form mode (`hook_entity_form_display_alter`, keyed off a `text_format` query parameter). It exposes helper routes `/edit-media-modal/edit-url/{uuid}` and `/edit-media-modal/check-access/{uuid}` (the CKEditor plugin resolves a media UUID to its edit URL and checks edit access), and a `ResponseSubscriber` that makes the modal submission behave as AJAX. Beyond CKEditor, you can add an "Edit this media" link anywhere by rendering the media's `edit-form` link with a `edit_media_in_modal=TRUE` query parameter and the AJAX dialog attributes. It depends only on core `media` and defines no configuration object, permissions, or Drush of its own.

---

- Add an "edit" button to embedded media in the CKEditor 5 editor so authors can fix media inline.
- Edit a Media entity in a modal dialog without navigating away from the content form.
- Choose which media form mode opens in the modal per media bundle (`editMediaModalForms`).
- Set the modal dialog height (percent) for the media edit dialog.
- Skip the per-item edit access check in CKEditor for simple sites (`skipAccessCheck`).
- Let editors correct alt text or metadata on an embedded image without leaving the article.
- Provide an "Edit this media" AJAX link on a custom form via `edit_media_in_modal=TRUE`.
- Redirect to a chosen destination after saving the media in the modal (via `destination` query).
- Present a streamlined media form (a lightweight form mode) inside the modal for quick edits.
- Keep editors in the flow of writing while managing embedded media.
- Use different edit forms for images vs documents vs remote video in the modal.
- Resolve a media UUID to its edit URL programmatically via `/edit-media-modal/edit-url/{uuid}`.
- Check whether the current user may edit a given media UUID via the access-check route.
- Improve the media library edit experience with modal editing.
- Override the default media edit form with the module's AJAX-aware `MediaForm`.
- Configure modal editing independently for each text format that uses CKEditor 5 media.
- Reduce context-switching for editorial teams working with lots of embedded media.
- Enforce (or bypass) media edit permissions inside the WYSIWYG per format.
- Give a large modal (e.g. 90% height) for complex media forms.
- Reuse the modal editing pattern in custom admin UIs that list media.
