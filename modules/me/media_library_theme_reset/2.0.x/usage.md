Media Library Theme Reset makes Drupal core's Media Library look and behave correctly when it is rendered in a front-end theme, by borrowing Claro's administrative styling. (Installed release documented here: 2.0.0-beta1 — a beta.)

---

Core's Media Library is built and styled for the admin theme (Claro). Whenever it is shown in a front-end theme its layout breaks: this happens with Layout Builder, when "Use the administration theme when editing or creating content" is disabled, when a user lacks permission to use an admin theme, when a front-end theme is set as the admin theme, or on end-user webforms that use media. This module fixes that without asking every theme to ship its own templates and CSS. It registers a set of Twig templates copied from Claro (via `hook_theme()`), attaches Claro's `claro/media_library.theme` CSS library plus its own `media-library-fixes.css` whenever the Media Library add-form loads, and re-adds the CSS classes Claro's preprocess/form-alter code would normally add (through `hook_form_alter()`, `hook_views_pre_render()`, and several `hook_preprocess_*()` implementations). It also conditionally loads an Olivero-specific fixes stylesheet when Olivero is in the active theme chain. It has no configuration UI, no permissions, no Drush commands, and no plugins — enabling it is the whole setup. Templates it provides can be overridden by copying them into your own theme, and theme-specific display problems can be patched with an extra fixes CSS file.

---

- Fix a broken-looking Media Library modal when editing content in a front-end (non-admin) theme.
- Make the Media Library render correctly inside Layout Builder, which uses the front-end theme.
- Style the Media Library on end-user-facing webforms that embed the media system.
- Support sites that intentionally disable "Use the administration theme when editing or creating content."
- Give anonymous or low-permission users a usable Media Library when they cannot use an admin theme.
- Handle sites that deliberately set a front-end theme as the admin theme.
- Restore Claro's grid, spacing, and focus styling to the media grid in the modal dialog.
- Add proper styling to the "Add media" upload form (file upload variant).
- Add proper styling to the "Add media" oEmbed URL form (remote video, etc.).
- Style the list of unsaved media items before they are saved.
- Style pre-selected media items and the click-to-select checkboxes in the modal grid.
- Style the media-type menu (the tabs of available media types) inside the modal.
- Apply consistent styling to the Media Library views (both the page and widget displays).
- Fix the exposed filters form spacing in the Media Library view.
- Provide Olivero-specific spacing fixes when the site's front-end theme is Olivero.
- Serve as a base you override: copy its Twig templates into your theme to customize markup.
- Add a theme-specific `themename-fixes.css` file to patch display issues unique to your theme.
- Work around Stable 9-based themes that shadow the media library templates (copy two templates into your theme).
- Avoid writing and maintaining your own copy of Claro's media-library CSS in a custom theme.
- Ship a media-editing experience in a decoupled/front-end-first build without a separate admin theme round-trip.
- Provide a reasonable Media Library appearance in custom themes that do not extend Claro.
- Reduce visual inconsistency between admin-theme and front-end-theme media editing.
