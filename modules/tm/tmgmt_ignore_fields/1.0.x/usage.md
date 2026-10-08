<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT Ignore Fields extends the Translation Management Tool so administrators can globally mark specific fields to be excluded from translation jobs.

---

When TMGMT builds a translation job it gathers the translatable fields of an entity and sends them to a translator. Some of those fields should not go: an internal reference code, a field that holds the same value in every language, a machine-oriented string, or a field whose "translation" would only ever be a copy of the original. Sending them wastes translator effort and word-count budget, and on a paid translation service that is real money. This module adds one settings form at **Configuration → Content authoring → Ignore Fields Settings** (`/admin/config/content/tmgmt-ignore-fields`, permission `administer site configuration`) that lists every base and configurable field of every content entity type as checkboxes; the checked fields are saved as a flat list of field machine names in `tmgmt_ignore_fields.settings:ignore_fields`. Under the hood it swaps TMGMT's content-source plugin for its own subclass, which removes those fields from the data each job would otherwise contain. Because the saved value is just the field machine name, ignoring a field excludes it from **every** content entity that has that field — the choice is global, not per entity type or bundle. It depends on `tmgmt` and `tmgmt_content`, the pairing that produces the field lists it filters. The process is otherwise unchanged: the workflow is the same, each job is simply smaller. The one thing to verify after configuring is that nothing genuinely translatable was excluded by an over-broad choice — an ignored field is silently absent from the job, so a mistake shows up as missing translations rather than an error.

---

- Exclude a field from translation jobs.
- Skip an internal reference field.
- Skip a language-neutral field.
- Reduce translator word count.
- Cut paid translation cost.
- Keep machine fields out of jobs.
- Configure ignored fields centrally on one settings form.
- Stop copying untranslatable values.
- Trim a TMGMT job to what needs translating.
- Ignore referenced entities such as paragraphs.
- Pair with tmgmt_content sources.
- Avoid wasting translator effort.
- Review that nothing translatable was excluded.
- Keep the translation workflow unchanged.
- Exclude a field across all content types at once.
- Streamline large translation jobs.
- Prevent redundant translation of copies.
- Manage exclusions in one settings form.
- Audit ignored fields after config changes.
- Set the ignore list from code via configuration.
- Send only meaningful content to translators.
- Lower cost on a paid translation service.
