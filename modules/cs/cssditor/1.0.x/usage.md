<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom CSS Adder (project: cssditor)

Note: the Drupal **machine name is `custom_css_adder`** (the project/repo is `cssditor`). Adds a CSS editor to each theme's settings page.

- Administrators paste custom CSS for a theme and it is applied on the front end.
- Includes an optional CodeMirror editor, a plain-text toggle, and a live-preview iframe.
- CSS is saved to `public://custom_css_adder/<theme>.css` and attached with a high weight so it overrides theme styles.

---

## Installation & configuration

- Install/enable; the machine name in `system.modules` is `custom_css_adder`.
- Editing requires access to the theme settings form (`administer themes`).
- Go to **Appearance → Settings** for a theme; a **CSS customization** details section appears.
- Toggle **enabled**, paste CSS, optionally enable plain-text editor and automatic preview.
- On save, the CSS is written to a public file and stored in config `custom_css_adder.theme.<theme>`.
- Libraries `custom_css_adder_/codemirror` and `custom_css_adder_/custom_css_adder_` provide the editor UI.

---

## Usage & behaviour / caveats

- `hook_page_attachments` attaches the theme's generated CSS library on front-end pages when enabled.
- `hook_library_info_alter` bumps the custom stylesheet weight to 9999 so it wins the cascade.
- The generated file path and enabled flag are read by `_custom_css_adder_get_stylesheet()`.
- Only users who can reach theme settings (a trusted admin permission) can set the CSS, so stored-CSS risk is limited to trusted admins.
- The preview uses an `<iframe>` pointed at the front page with a `theme` query argument.
- CAVEAT: `src/Theme/ThemeCssEditor.php` references an undefined `$stack` variable in `applies()`/`determineActiveTheme()`, which would fatal if the theme negotiator is invoked — the preview theme-switch path appears broken.
- The negotiator is registered via `custom_css_adder.services.yml` with a `theme_editor` tag.
- CSS is stored per-theme; switching themes uses separate config/files.
- `drupal_flush_all_caches()` is called on submit so changes take effect immediately.
- To remove custom CSS, clear the textarea or disable the checkbox and save.
- Files live under `public://custom_css_adder/`; ensure the public filesystem is writable.
- No custom routes or permissions beyond core theme administration.
- Uninstall leaves generated public CSS files behind; remove them manually if desired.
- Machine name mismatch: repo/project is `cssditor` but the enabled module is `custom_css_adder`.
- Read: `custom_css_adder.module`, `src/Theme/ThemeCssEditor.php`.
