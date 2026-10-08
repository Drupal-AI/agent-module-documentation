<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Transliterate Twig adds a single Twig filter named `tl` that transliterates a string (converting accented and non-ASCII characters to their closest ASCII equivalents) directly inside theme templates, without needing the PECL/intl extension.

---

Generating an ASCII identifier, a slug, a filename, or an anchor from text that contains accents or non-Latin characters requires transliteration. Transliterate Twig registers one Twig filter, `tl`, implemented by `Drupal\transliterate_twig\TwigExtension\TransliterateFilter`, which delegates to Drupal core's own `\Drupal\Component\Transliteration\PhpTransliteration::transliterate()`. This gives the same result as core's transliteration service but in a pure-PHP form usable from any template — for example `{{ 'résidence' | tl }}` outputs `residence`. There is nothing to configure: enable the module and the filter is available in every Twig template. It is a theming utility used by template authors (a trusted layer); the filter returns a plain string that Twig continues to autoescape as normal.

---

- Transliterate a string in a Twig template with `{{ value | tl }}`.
- Convert accented Latin characters (é, ü, ñ) to plain ASCII.
- Turn `résidence` into `residence` for display or comparison.
- Build an ASCII-only slug from a node title inside a template.
- Generate a clean anchor/`id` attribute from heading text.
- Produce an ASCII filename fragment for a download link.
- Normalize non-Latin (Cyrillic, Greek) text toward ASCII in templates.
- Avoid installing the PECL/intl extension just to transliterate in Twig.
- Replace the PECL-based Transliterate Twig Filter module with a pure-Drupal equivalent.
- Chain with core filters, e.g. `{{ title | tl | lower }}`.
- Combine with `replace`/`trim` to build URL-safe strings in a template.
- Transliterate a field value before printing it in a custom template.
- Create stable, ASCII CSS class fragments from user-supplied labels.
- Prepare text for systems that only accept ASCII (legacy exports, IDs).
- Show a simplified, accent-free version of a name in a listing.
- Use the same transliteration logic as core without writing PHP.
- Apply transliteration in a paragraphs/component template.
- Enable the module only when a template actually needs the filter.
- Keep the module disabled if no template transliterates strings.
- Confirm the transliteration output matches expectations for your languages.
- Test transliteration of edge-case scripts before relying on it in production.
- Pair with core's Pathauto/URL-alias tooling where a Twig-level transform is needed.
- Review templates using `tl` after core upgrades that change transliteration tables.
