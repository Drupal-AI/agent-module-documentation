Adds the CKEditor 5 Text Transformation plugin, which automatically converts typed shorthand into proper typographic characters (autocorrect-style) as authors write.

---

This submodule of CKEditor 5 Plugin Pack registers the Text Transformation editor plugin (class `Plugin/CKEditor5Plugin/TextTransformation`), which watches typed input and replaces predefined patterns with nicer output — for example `(c)` becomes ©, `--` becomes an em dash, `1/2` becomes ½, and straight quotes become curly "smart" quotes. It works transparently in the background with no toolbar button; enabling the module and turning it on for a text format is enough. The set of active transformations is configurable in the plugin settings for the format at Admin → Configuration → Content authoring → Text formats and editors. It depends on the base `ckeditor5_plugin_pack` module and ships its own config schema. Use it to keep published content typographically clean without training every author.

---

- Convert `(c)`, `(r)`, `(tm)` to ©, ®, ™ automatically.
- Turn `--` into an em dash and `-` sequences into en dashes.
- Replace straight quotes with curly "smart" quotes.
- Convert `1/2`, `1/4`, `3/4` into ½, ¼, ¾ fractions.
- Turn `...` into a proper ellipsis character.
- Convert `->` into an arrow symbol.
- Apply consistent typography without author effort.
- Improve the polish of published articles.
- Reduce manual find-and-replace for common symbols.
- Enforce house typographic style automatically.
- Fix quote direction at the start vs. inside words.
- Produce professional dashes in long-form content.
- Standardize symbol usage across many editors.
- Enable only the transformations your style guide allows.
- Prevent inconsistent copyright/trademark symbols.
- Help non-expert authors produce clean typography.
- Keep math-style fractions readable in prose.
- Disable specific transformations that conflict with technical content.
- Apply transformations per text format.
- Improve readability of marketing copy.
