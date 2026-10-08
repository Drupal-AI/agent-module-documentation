<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Word Count shows a live word and character count in CKEditor 5, with optional limits.

---

CKEditor 5 Word Count adds a **word/character-count** feature to CKEditor 5. As an editor types, it
displays a live count of words and characters below the editor and can show the count against a
configured limit (for example `Words: 245 / 500`). When a count nears its limit the editor turns
yellow, and when it passes the limit it turns red — the limits are advisory only, so they warn but
never block saving. Counting is Unicode-aware for accurate results with international content. It
depends only on core's CKEditor 5.

Use it wherever content has a target or cap on length — blog posts, news headlines and teasers,
templated content. It is a content-editing/CKEditor feature that affects the editing UI only; it has
no content or access role of its own.

---

- Add the **Word Count** item to a CKEditor 5 text format's configuration
  (Configuration → Text formats and editors); the counter then appears automatically below that
  format's editors — there is no toolbar button.
- Set site-wide limits at **Configuration → Content authoring → CKEditor 5 Word Count**
  (`/admin/config/content/ckeditor5-wordcount`): enable a word limit and/or a character limit, set
  the maximums, and choose the warning-threshold percentage (default 90%).
- The counter updates live as you type and colours the editor yellow (approaching a limit) or red
  (over a limit); limits are visual guidance and do not prevent submitting content.
- Requires only core's CKEditor 5. The bundled plugin JS is served locally from the module.
