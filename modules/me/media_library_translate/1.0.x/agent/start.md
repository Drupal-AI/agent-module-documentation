<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Library Translate (media_library_translate) — agent index

Adds a **translate** button to the selected item inside the core **Media Library widget**
(`media_library_widget`). Clicking it opens the media entity's core **content-translation overview**
page in an AJAX modal, so an editor can translate media metadata (alt text, name, caption) without
leaving the node form. Depends on core `media`, `media_library` and `content_translation`. Core
requirement `^9 || ^10 || ^11`; package `Media`.

Key facts:
- **No `src/` directory, no routes, no controllers, no permissions, no config schema.** The whole
  module is `media_library_translate.module` (four hook implementations), one JS behavior, one
  stylesheet, one SVG icon and a `.libraries.yml`.
- It is a **shortcut to core's existing translation UI**, not a new translation mechanism. The
  button is a plain `#type => link` to the media entity's `drupal:content-translation-overview`
  link template (resolves to `/media/{media}/edit/translations`). Access, CSRF and storage are all
  core `content_translation`'s.
- **Opt-in per field widget.** Off by default. Enabled through a third-party setting
  (`show_translation`) on the `media_library_widget` in a form display — see the configure doc.
- The button only renders when the selected item's media entity passes `access('update')` **and**
  its entity type declares a `drupal:content-translation-overview` link template.
- Accessibility relevance: untranslated alt text is a real barrier for screen-reader users on the
  non-default language, so this is more than editorial tidiness.

## What you'd do → where

- **Turn the translate button on for a field, and the exact hooks/settings behind it** →
  [configure/media_library_translate.md](configure/media_library_translate.md)

## Key facts (real machine names)

- Hooks implemented (all in `media_library_translate.module`):
  - `hook_field_widget_third_party_settings_form` — adds the `show_translation` checkbox to the
    `media_library_widget` settings.
  - `hook_field_widget_settings_summary_alter` — adds "Show translation button" to the widget summary.
  - `hook_field_widget_single_element_form_alter` — renders the `media_translate` link element on
    each selected item when `show_translation` is on.
  - `hook_help` (`help.page.media_library_translate`).
- Third-party settings provider/key: `media_library_translate` → `show_translation` (bool), stored on
  the field widget in the form display config entity.
- Rendered link element: `$element['selection'][$key]['media_translate']`, an ajax-dialog link
  (`use-ajax`, `data-dialog-type = modal`, `target = _blank`), CSS classes
  `js-media-library-translate-link` / `media-library-translate__link`, dialog sized via
  `MediaLibraryUiBuilder::dialogOptions()`.
- Library: `media_library_translate/admin` (attaches `js/media_library_translate.js`,
  `css/media_library_translate.admin.css`, `icons/translate.svg`; depends on `media_library/ui`).
  The link also attaches `core/drupal.dialog.ajax`.
- JS behavior: `Drupal.behaviors.mediaLibraryTranslate` — after the modal opens, rewrites the
  translation-overview dropbutton links to `target=_blank` and appends `destination=<current path>`
  so the editor returns to the form after translating.
