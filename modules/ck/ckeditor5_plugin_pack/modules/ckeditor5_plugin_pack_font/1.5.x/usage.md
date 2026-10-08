Adds the CKEditor 5 Font plugins — Font Family, Font Size, and Font Color (text and background) — to Drupal's rich text editor.

---

This submodule of CKEditor 5 Plugin Pack registers three editor plugins: Font Family, Font Size, and Font Color (which covers both text color and background/highlight color). Once enabled, their buttons can be dragged into any CKEditor 5 text format toolbar at Admin → Configuration → Content authoring → Text formats and editors, where each plugin exposes settings such as the allowed list of font families, size options, and color palette. It depends on the base `ckeditor5_plugin_pack` module and ships its own config schema and toolbar icons. Use it when editors need inline control over typography and color without hand-editing HTML, while still constraining choices to an approved set.

---

- Let editors choose a font family from an approved list.
- Restrict font choices to brand-approved typefaces.
- Offer preset font sizes (small, big, or specific px/em values).
- Set text color from a curated palette.
- Set background/highlight color behind text.
- Provide a color picker for arbitrary hex colors when allowed.
- Emphasize warnings or callouts with colored text.
- Match editorial content to brand colors.
- Give press-release or marketing pages typographic flexibility.
- Add color-coded labels inside body content.
- Keep font choices consistent by limiting the family dropdown.
- Allow larger headings-in-body via font size in constrained formats.
- Color-code table cell text in content.
- Provide accessible color choices via a defined palette.
- Let authors reset to default font/size/color easily.
- Configure allowed fonts per text format (e.g. richer for staff, limited for public).
- Style pull quotes with a distinct font and color.
- Add emphasis in multilingual content where bold/italic is insufficient.
- Apply background color to highlight terms without the Highlight plugin.
- Standardize typography controls across many content types.
