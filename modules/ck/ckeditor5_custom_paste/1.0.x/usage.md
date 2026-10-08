<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Custom Paste rewrites content as it is pasted, flattening it to plain paragraphs so formatting from the source does not enter the body field.

---

When enabled on a text format, the module's CKEditor 5 plugin hooks the clipboard `inputTransformation` step and rewrites the incoming HTML: every tag is collapsed to a paragraph boundary — only `<br>` line breaks survive — and the result is delivered as a run of `<p>` paragraphs. In practice this means all inline formatting (bold, italics, links, spans, font tags, colours, inline `style` attributes) **and** block structure (headings, lists, tables) are discarded; what lands in the editor is the text, split into a paragraph at each former tag. This is aggressive by design and is closest to a "paste as plain paragraphs" behaviour, not a selective Word/Docs cleanup that keeps semantic headings or table shape. Configuration is per text format: editing a CKEditor 5 format shows a **Ckeditor 5 Custom Paste** settings tab with an **enable** checkbox and an **Excluded tags** field; the filter acts only when the checkbox is ticked. Two things to keep straight. **This is editorial hygiene, not a security control** — it runs in the browser and is trivially bypassed by the source-editing button or an API write, so the real defence against dangerous pasted markup remains the text format's server-side filter chain (`filter_html` et al.), applied on render. And a **known caveat in 1.0.3**: the *Excluded tags* list never reaches the browser (the JavaScript reads it from a different config key than the PHP publishes), so in this release the exclusion field is effectively inert and everything is flattened regardless of what you enter — plan around a full flatten, not a selective one. Version **1.0.3** (2024) on core `^9.3 || ^10 || ^11`, depending on core `ckeditor5`.

---

- Force pasted content down to plain paragraphs in a chosen text format.
- Strip Word formatting when authors paste from Office documents.
- Remove inline `style` attributes carried in from a paste.
- Drop `mso-*` and font/colour markup pasted from Word.
- Clean up Google Docs span-nesting on paste.
- Prevent `<font>` and hard-coded colour tags entering the body.
- Keep the body field free of pasted inline widths that break layout.
- Enforce a plain-paragraph paste policy per text format.
- Reduce manual markup cleanup after editors paste.
- Stop copied CSS classes and IDs surviving into content.
- Keep pasted content from defeating the theme's typography.
- Improve markup consistency across many editors.
- Improve content portability by discarding source-specific markup.
- Apply a strict paste rule to a "plain" or comment-style format while leaving rich formats untouched.
- Give a restricted authoring role a paste path that cannot smuggle in styling.
- Normalise line breaks (kept as `<br>`) while discarding everything else on paste.
- Turn a wall of richly formatted pasted text into clean paragraphs an editor can re-format deliberately.
- Prevent redesigns from being defeated by styling baked into old pasted content going forward.
- Evaluate paste-cleanup options alongside CKEditor 5 Paste Filter before choosing one.
