Layout Builder Modal makes the Layout Builder add/configure-block forms open in a centered modal dialog instead of the default off-canvas tray, giving editors more room to work.

---

By default core Layout Builder opens block add/edit forms in a narrow off-canvas sidebar, which is cramped for complex blocks (rich text, media, multi-field custom blocks). This small module swaps that interaction so those forms open in a resizable jQuery UI modal dialog centered over the layout. An `AjaxResponseSubscriber` intercepts the relevant Layout Builder AJAX responses and retargets them to a modal, and a settings form at `/admin/config/user-interface/layout-builder-modal` lets you tune the experience: modal width and height, whether the dialog auto-resizes to its content, and whether it renders using the admin theme or the active front-end theme. It requires only core `layout_builder` and `system`, adds one permission for its settings, and otherwise needs no per-block configuration — enabling it changes the editing UX globally. It is a popular quality-of-life addition for sites that build pages with Layout Builder.

---

- Give editors a wide modal instead of the cramped off-canvas tray when adding blocks.
- Make configuring rich-text/WYSIWYG blocks easier with more screen space.
- Set a fixed modal width for consistent block-editing dialogs.
- Set a fixed modal height for tall block forms.
- Enable auto-resize so the modal fits its content.
- Render block forms in the front-end theme to preview theme styles while editing.
- Render block forms in the admin theme for a consistent admin look.
- Improve editing of media-heavy custom blocks in Layout Builder.
- Reduce horizontal scrolling when configuring blocks with many fields.
- Provide a more focused, centered editing surface for content authors.
- Standardize the block-editing dialog size across a team.
- Improve UX on smaller laptops where the off-canvas tray is too narrow.
- Let complex paragraph/inline-block forms display comfortably.
- Restrict who can change the modal settings via a dedicated permission.
- Keep Layout Builder's behavior otherwise unchanged while widening the form area.
- Deploy the modal configuration between environments as config.
- Pair with Layout Builder Styles so style selectors show in a roomier dialog.
