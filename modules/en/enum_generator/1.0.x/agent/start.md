<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enum Generator (enum_generator) — agent index

**Turns a taxonomy vocabulary's terms into a downloadable PHP enum or class-constants file.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends:** taxonomy; composer `nette/php-generator`.
- **Routes:** `/admin/structure/enum-generator` (menu), `/admin/structure/enum-generator/taxonomy` (`TaxonomyGeneratorForm`). Both `access enum generator` (restrict access).
- **Permission:** `access enum generator`.
- **Output:** builds the file with `nette/php-generator`, writes to `temporary://`, streams a `text/plain` attachment. Namespace validated (no leading backslash); case names UPPER_SNAKE with `_` prefix for leading digits.
- **Security:** Admin-gated dev tool. Generated file written to the temporary stream and downloaded (not into the codebase); filename derived from the vocab label, not raw user input. No mutation of site state.

See [configure/generate.md](configure/generate.md).
