<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Termcase (termcase) — agent index

**Enforces a per-vocabulary text-case convention on taxonomy term names on save, with optional bulk conversion of existing terms.**

- **Version:** 2.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Package:** Taxonomy — depends on `taxonomy`.
- **How:** `hook_form_taxonomy_vocabulary_form_alter` adds the "Term case settings" select; `hook_ENTITY_TYPE_presave` (`termcase_taxonomy_term_presave`) recases the name. Modes: none/ucfirst/lowercase/uppercase/propercase.
- **Config:** `termcase.settings:vocabularies` (per-vid `{option, update}`).
- **Bulk:** vocabulary-form checkbox runs Batch API; a Drush command (`termcase/drush.services.yml`) does the same from CLI.
- **Extension:** `hook_termcase_convert_string_alter` (see `termcase.api.php`).

**Security:** no routes, services or public endpoints; all behavior rides the core taxonomy vocabulary/term forms which enforce standard taxonomy admin permissions. No mutating anonymous surface. No security findings.
