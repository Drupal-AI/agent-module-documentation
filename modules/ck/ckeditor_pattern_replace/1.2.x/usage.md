<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Pattern replace adds a text-format filter that runs a list of admin-configured `pattern|replacement` regular-expression rules over field text on output.
---
The filter plugin (`src/Plugin/Filter/CkeditorPatternReplace.php`, id `ckeditor_pattern_replace`, type `TYPE_HTML_RESTRICTOR`) reads a textarea setting where each line is `/RegularExpression/|Replacement`. On `process()` it splits the setting by newline, splits each line on `|`, and calls `preg_replace($pattern, $replacement, $text)` in sequence. It is configured per text format under Administration » Configuration » Content authoring » Text formats and editors.

Because the patterns are PHP regular expressions supplied by whoever can administer text formats, this is an admin-trusted feature: a malformed pattern can break output and a broad pattern can alter markup unexpectedly, so restrict the "administer filters" capability. (PHP's deprecated `/e` modifier that once allowed code execution was removed in PHP 7, so modern PHP cannot execute code through these patterns.) Typical setup is enabling the module, adding the filter to a format, and entering one `pattern|replacement` per line.
---
- Strip or rewrite unwanted markup from editor output.
- Replace a recurring phrase across all content in a format.
- Normalize typography (e.g. straight to curly quotes) via regex.
- Remove empty tags left by the editor.
- Inject shortcode-style tokens into HTML.
- Rewrite legacy URLs on output.
- Enforce a house style with search/replace rules.
- Apply multiple rules in order, one per line.
- Configure rules per text format.
- Clean pasted-from-Word artifacts.
- Convert custom placeholders to HTML.
- Redact or mask a pattern on display.
- Add rel/target attributes via regex.
- Fix common editor markup mistakes automatically.
- Limit the filter to trusted (admin) formats.
- Test patterns carefully to avoid breaking markup.
- Chain with other format filters in the right order.
- Remove tracking query strings from links.
