<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig HTML entities decode adds a single Twig filter, `htmlspecialchars_decode`, that runs PHP's `htmlspecialchars_decode()` on a string — turning entity sequences such as `&amp;`, `&lt;`, `&gt;` and `&quot;` back into `&`, `<`, `>` and `"`. It exists for values that arrive already entity-encoded and would otherwise show the literal entities on the page.

---

The whole module is two files of substance: `src/TwigHtmlSpecialCharsDecode.php`, a `Twig\Extension\AbstractExtension` that registers one `TwigFilter` named `htmlspecialchars_decode` bound to a `filter($text)` method returning `htmlspecialchars_decode((string) $text)`, and `twig_htmlspecialchars_decode.services.yml`, which tags the class as a `twig.extension`. There are no routes, permissions, configuration, config schema, hooks, or module dependencies, and it works identically on Drupal 9, 10 and 11. The filter is registered with no `is_safe` flag and no `preserves_safety`, so it returns an ordinary string: in an auto-escaped Twig context the printed result is re-escaped by Twig like any other variable. The module was written because the old Drupal 8 idiom `value|convert_encoding('UTF-8', 'HTML-ENTITIES')` stopped working once Twig moved from `mbstring` to `iconv` in Drupal 9 (iconv rejects the `HTML-ENTITIES` charset), leaving no built-in one-step way to decode entities in a template. The typical situation it addresses is a value that was entity-encoded too early — upstream in a migration, a token, an external feed, or an API response — and the durable fix is usually to stop that double-encoding at its source; this filter is the pragmatic template-side patch when the source cannot be changed.

---

- Render a value that would otherwise show literal `&amp;` on the page.
- Undo entity encoding introduced by an upstream system.
- Replace the Drupal 8 `convert_encoding('UTF-8', 'HTML-ENTITIES')` idiom that broke in Drupal 9.
- Clean up entity-encoded strings coming from a migration.
- Render an imported feed title with the correct characters.
- Handle an API response whose text arrives pre-encoded.
- Convert escaped quotes (`&quot;`) back to `"` in a string.
- Fix a display glitch in a template without altering the stored data.
- Decode entities inside a custom Twig template.
- Decode a value that a token filter returned already encoded.
- Normalise a string's characters before comparing it in Twig.
- Support Drupal 9, 10 and 11 with a single filter.
- Avoid hand-writing a one-function custom Twig extension.
- Repair titles imported from a CMS that entity-encoded them.
- Decode a value before handing it to another Twig filter.
- Correct a page title that renders entities through a view.
- Provide a stopgap while the source system is being fixed.
- Decode entities in a field value surfaced in a template.
- Turn `&lt;` / `&gt;` sequences back into angle brackets for further processing.
- Pre-process a string in a template before slicing or splitting it.
