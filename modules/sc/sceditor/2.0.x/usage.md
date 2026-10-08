<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SCEditor integrates the lightweight SCEditor JavaScript library as a Drupal text-editor plugin for BBCode and (X)HTML editing.

---

The module is a single Editor plugin (`Drupal\sceditor\Plugin\Editor\ScEditor`) that attaches the SCEditor library to textareas of a text format. It declares `supports_content_filtering = FALSE`, `supports_inline_editing = FALSE`, and importantly `is_xss_safe = FALSE`, so Drupal treats output from this editor as untrusted and applies the text format's own filters when rendering — the editor performs no server-side sanitization itself. The library assets are loaded via `sceditor.libraries.yml`, which pulls the SCEditor CSS/JS from the jsDelivr CDN plus a small local `js/sceditor.js` initializer.

To use it, create or edit a text format at `/admin/config/content/formats`, choose "SCEditor" as the text editor, and configure the format's filters. Because the editor is not XSS-safe, you must keep an appropriate filter (e.g. Limit allowed HTML tags, or a BBCode filter) enabled on any format assigned to untrusted roles. Note the library is pinned to `@latest` on an external CDN, so the exact frontend version is not locked by the module.

---
- Add SCEditor as the WYSIWYG editor for a text format.
- Provide BBCode editing for forum-style or comment content.
- Offer a lightweight alternative to CKEditor for simple content.
- Enable SCEditor on a restricted text format for authenticated users.
- Pair SCEditor with a strict "Limit allowed HTML tags" filter for safety.
- Use SCEditor for (X)HTML editing of body fields.
- Assign SCEditor to comment text formats.
- Configure per-format which roles may use the SCEditor format.
- Keep sanitization filters enabled because the editor is not XSS-safe.
- Load the editor on any textarea-based field widget via its format.
- Override or extend the local `js/sceditor.js` initializer in a subtheme.
- Self-host the SCEditor library instead of the CDN by overriding the library.
- Provide a distraction-free minimal editor for short text fields.
- Use SCEditor where a full CKEditor toolbar is unnecessary.
- Localize the editor UI via the language manager integration.
