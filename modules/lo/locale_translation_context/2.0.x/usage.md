<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Locale Translation Context adds a "Context" filter to Drupal core's interface-translation Translate and Export screens (and a matching Drush export option), letting translators narrow the string list by gettext context (`msgctxt`) — something core stores but never exposes in its UI.

---

Gettext contexts exist because one English source string is often several different words in another language: "Order" is a sequence and a purchase, "Post" is a verb, a noun, and a piece of mail, "Right" is a direction and an entitlement. Drupal supports this in code — `t('Order', [], ['context' => 'Commerce order'])` writes a `context` onto the `locales_source` row — but core's translation UI gives the translator no way to see or filter by that context, so a search for "Order" returns every occurrence undifferentiated and one meaning gets applied to all of them. This module closes that gap in three places without any configuration. On the Translate screen (`admin/config/regional/translate`) it swaps core's controller and forms for subclasses (`ContextTranslateFilterForm`, `ContextTranslateEditForm`) that add a **Context** select and pass it as an extra query condition (`$conditions['context']`) into core's string storage. On the Export screen it alters `locale_translate_export_form` to add a **Context** select and replaces the submit handler with one that filters the exported `.po`/`.pot` through a bundled `PoDatabaseReader` honoring a `context` option. And it adds a Drush command, `locale:context-export` (alias `locale-context-export`), plus a `--context` option grafted onto core's `locale:export`, for the same filtering on the command line. The context list itself is built by querying distinct non-empty `context` values out of `locales_source`, so the dropdown only ever offers contexts that already exist. Two caveats worth knowing: **context is set by the developer, not the translator** — the filter exposes what the code declared, it cannot create contexts, and adding a context to an existing string makes it a *new* untranslated string; and **`.po` files carry contexts** as `msgctxt`, so import/export round-trips preserve them, which makes this useful when translation happens outside Drupal and comes back as files. Requires the core `locale` module and the core `translate interface` permission; it defines no permissions or config of its own.

---

- Filter the interface-translation list by gettext context.
- Disambiguate a source word with several meanings ("Order", "Post", "Right").
- Translate `t('Order', [], ['context' => 'Commerce order'])` strings correctly per context.
- Show only the strings belonging to one custom project's context.
- Find and translate one module's context-tagged strings together.
- Export a single context's strings to a `.po` file for external translators.
- Export a `.pot` template limited to one context.
- Run `drush locale:context-export nl --context=custom_project` to export Dutch strings for one context.
- Run `drush locale:export --context=custom_project` (core command, now context-aware).
- Diagnose an odd-sounding translation by reviewing one context in isolation.
- Review a multilingual site's translations context by context.
- Find untranslated strings within a specific context.
- Support a professional/outsourced translation workflow with `msgctxt`-preserving round-trips.
- Keep custom-code strings separated from core and contrib strings during translation.
- Narrow a very large string list down to a manageable, meaningful subset.
- Verify a `.po` import preserved its contexts by filtering on them afterward.
- Batch-translate all strings sharing a context in one pass.
- Audit which contexts exist on a site (the dropdown lists every context in use).
- Improve overall language quality on a site with ambiguous UI wording.
- Hand a single context off to a translator without exporting the whole catalog.
