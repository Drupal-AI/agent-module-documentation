Media Library Form Element exposes Drupal core's Media Library as a reusable Form API render element (`#type => 'media_library'`), so any custom form — including Webform — can let users select or upload media items.

---

Core's Media Library widget is only wired up to entity reference fields, which makes it hard to reuse the polished "select or add media" experience elsewhere. This module packages that widget as a standard Form API element you can drop into any form array with `'#type' => 'media_library'`. You constrain it with `#allowed_bundles` (the media types allowed), set `#cardinality` for single or multiple selection, and provide a `#default_value` of media entity IDs. The element opens the standard modal media library, supports adding new media, shows selected items with remove buttons and drag-to-reorder weights for multi-value use, and returns the chosen media IDs on submit. It ships its own opener service (`media_library.opener.form_element`), a Twig template and JS for the selected-items UI, and — when Webform is installed — a Webform element plugin so site builders can add a media library element to webforms without code. Because it builds on core Media Library it inherits its access checks and media type configuration. It requires only the core `media_library` module.

---

- Add a media picker to a custom configuration form.
- Let users upload or select an image in a bespoke settings form.
- Build a custom "featured media" selector outside of entity fields.
- Add a media library element to a Webform (no custom code).
- Restrict selection to specific media types via `#allowed_bundles`.
- Allow a single media item with `#cardinality => 1`.
- Allow unlimited media items with `#cardinality => -1`.
- Pre-populate a form with existing media using `#default_value`.
- Reorder selected media by drag-and-drop weight in multi-value mode.
- Remove selected items inline before submitting the form.
- Collect a media reference in a multi-step form/wizard.
- Let site visitors submit media through a front-end webform.
- Add media selection to a custom block configuration form.
- Reuse core's modal media browser in a module's admin UI.
- Capture a logo/avatar selection in a profile-style form.
- Gather multiple gallery images in one form control.
- Add a media field to a form that is not backed by an entity.
- Provide a themable, accessible media selector via the shipped template.
- Integrate media selection into a paragraph or inline entity custom form.
- Let editors pick a document/file media item for a custom workflow.
- Build a "choose from library or upload new" control in a custom element.
- Enforce media type constraints server-side through the element's processing.
