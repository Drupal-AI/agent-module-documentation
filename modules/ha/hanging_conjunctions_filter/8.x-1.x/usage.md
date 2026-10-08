<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hanging Conjunctions Filter is a text-format filter that moves dangling one-letter conjunctions and prepositions off the end of a line by inserting a non-breaking space (`&nbsp;`), improving typography (notably for Polish).
---
The module registers a single `TYPE_TRANSFORM_IRREVERSIBLE` filter plugin (`hanging_conjunctions_filter`, weight 50). When applied to text it runs `TextReplacement::processHangingConjunctions()`, which splits the HTML into tag/text chunks with `preg_split` so that tags and attributes are never touched, and skips the interiors of `a`, `script`, `style`, `code` and `pre` tags. Inside remaining text chunks it runs `preg_replace` for each term in a built-in Polish word list, gluing the term to the following word with `&nbsp;`.

The filter is language-aware: it only acts on text whose langcode has a term list. Out of the box only `pl` is defined; other languages are opt-in. Site builders extend it by implementing `hook_hanging_conjunction_filter_terms_alter(&$terms)` to add terms keyed by langcode. Operationally it is safe: it is a pure string transform with no routes, permissions, services, or external calls, and it should be ordered after HTML-correcting filters in the text-format pipeline.

Because it is irreversible, enable it only on formats where the `&nbsp;` insertion is desired in stored/rendered output.
---
- Enable the filter on a text format at `/admin/config/content/formats`.
- Order the filter after "Correct faulty and chopped off HTML" in the pipeline.
- Prevent single-letter Polish conjunctions from ending a line.
- Automatically insert `&nbsp;` after prepositions like "na", "do", "za".
- Keep abbreviations such as "dr", "prof.", "ul." attached to the next word.
- Improve justified-text typography in body fields.
- Apply orphan-fixing only to Polish-language content via langcode.
- Add support for another language's terms via the alter hook.
- Register custom orphan terms in a module with `hook_hanging_conjunction_filter_terms_alter()`.
- Exclude code/pre/script/style regions from processing automatically.
- Leave links (`a` tags) untouched while fixing surrounding prose.
- Combine with a WYSIWYG format for editor-entered content.
- Use on node body, comment, or block description fields.
- Verify tag attributes are never altered by the filter.
- Chain with other typography filters for full punctuation cleanup.
- Disable on formats where literal spacing must be preserved.
- Preview filter effects with the format's test/preview.
- Restrict the filter to trusted formats since it rewrites markup.
- Audit the built-in Polish term list before relying on it for other languages.
- Provide per-langcode term arrays for multilingual sites.