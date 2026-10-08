<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Text Cleaner deterministically strips the formatting quirks that LLM output tends to carry — hidden characters, smart quotes, en/em dashes, ellipses, stray asterisks and markdown headings — from content-entity text fields on save.

---

AI Text Cleaner is a small, self-contained module. Despite the name it performs no AI/LLM call and has no external dependencies: all cleaning is done locally with PCRE regular expressions. It provides a text-format filter plugin (`ai_text_cleaner_filter`) whose per-format checkbox settings record which cleanups to apply, and a `hook_entity_presave` that does the actual work — rewriting the `value`/`summary` properties of a saved content entity's text fields before they persist (the filter's own render-time `process()` is a no-op, so display is unchanged). An admin settings form (`/admin/config/content/ai-text-cleaner`, permission `administer site configuration`) additionally lets you clean plain fields that have no text format assigned. A Drush command `ai:text-clean` (alias `ai-text-clean`) processes nodes in bulk with an analysis (dry-run) mode, filters by content type and language, and prints per-option replacement counts. Cleanups available: remove zero-width/hidden characters, convert non-breaking spaces, normalize dashes, normalize quotes and guillemets (with per-language opt-outs, e.g. German/Polish/French), convert the ellipsis character to three periods, remove trailing whitespace, remove asterisks, and strip markdown heading markers.

---

- Strip zero-width and other hidden characters pasted in from an LLM before content is saved.
- Convert non-breaking spaces (NBSP / narrow NBSP) to regular spaces.
- Normalize en dashes and em dashes to a plain hyphen.
- Convert curly "smart" quotes to straight quotes, keeping German/Polish/Finnish/Swedish conventions intact.
- Normalize guillemets to straight quotes while leaving es/fr/it/ru untouched.
- Convert the single ellipsis glyph (…) to three periods.
- Trim trailing spaces/tabs at line ends and end of text.
- Remove stray markdown emphasis asterisks from pasted text.
- Strip leading markdown heading markers (`#`…`######`) at the start of lines.
- Enable the cleaner per input format at *Text formats and editors* and pick which cleanups run.
- Clean plain text fields (no assigned format) site-wide by enabling "Clean plain text fields" in settings.
- Clean content automatically on every content-entity save with no editor action needed.
- Bulk-clean existing nodes with `drush ai:text-clean --analysis=FALSE`.
- Preview what would change without saving using `drush ai:text-clean --analysis=TRUE`.
- Limit a bulk run by content type (`--types=article,page`) and language (`--languages=en,de`).
- Page through large sites with `--offset` and `--limit`.
- Get per-field, per-option replacement statistics as a status message or a Drush table.
- Standardize typography across an editorial team without a WYSIWYG plugin.
- Clean up imported/migrated body text that carries invisible or curly characters.
- Keep display output byte-for-byte as stored (cleaning happens on save, not on render).
- Apply different cleanup sets to different input formats.
