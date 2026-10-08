<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wysiwyg Linebreaks is a CKEditor plugin that converts newline-separated plain text into HTML paragraphs when content opens in the editor, and optionally strips those tags back out on save, so legacy content edits cleanly in a WYSIWYG.

---

Install it like any module (`composer require drupal/wysiwyg_linebreaks`, then enable it); it depends only on core's **editor** module and targets Drupal `^9.3 || ^10 || ^11`. There is no settings page: go to **Text formats and editors** (`admin/config/content/formats`), edit a format that uses **CKEditor 5**, and pick a **Conversion Method** in the section that appears below the toolbar. **Force linebreaks** (the default) converts plain text to `<p>`/`<br>` while you edit and then strips those tags back to newlines when you save — so the stored value stays plain text and you should pair the format with a display filter such as core's *Convert line breaks into HTML* to render it. **Convert linebreaks** does the open-time conversion only and saves the editor's HTML as-is, which is what you want when finishing a migration and keeping clean markup. All of this runs client-side in the browser at the editor boundary; the transformed content still passes through the text format's normal filters on output. Legacy CKEditor 4 profiles are still supported, and a CKEditor 4-to-5 upgrade plugin carries the setting across when you migrate a format.

---

- Edit legacy plain-text content in CKEditor without it becoming one undifferentiated block.
- Preserve paragraph breaks from newline-separated migrated text.
- Avoid a spurious diff on every migrated node when it is first opened and re-saved.
- Convert newlines to `<p>`/`<br>` on editor open for correct display while editing.
- Choose the conversion method per text format on the Text formats and editors page.
- Use **Force linebreaks** to keep stored content free of `<p>` and `<br>` tags.
- Use **Convert linebreaks** to save clean editor HTML after a one-off migration.
- Keep plain-text content editable both with and without a WYSIWYG editor.
- Pair force mode with core's "Convert line breaks into HTML" filter for display.
- Bridge content authored before the site had a rich-text editor.
- Edit imported text from a legacy CMS without manual reformatting.
- Support a phased content migration from Drupal 7 to 10/11.
- Reduce migration cleanup work on old articles and body fields.
- Handle plain-text imports coming from a feed or external source.
- Retain the setting when migrating a format from CKEditor 4 to CKEditor 5.
- Configure the method from code via the editor entity's plugin settings.
- Keep the editing user's stored data in a predictable plain-text shape.
- Ease adoption of CKEditor 5 on an older content-heavy site.
