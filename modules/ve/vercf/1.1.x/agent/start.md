<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views entity reference contextual filter (vercf) — agent index

Views argument-default plugin. Version **1.1.0**. Depends on `views`.

- **Plugin**: `EntityReferenceVERCF` (`@ViewsArgumentDefault id="entityreferencevercf"`). Configure a
  field machine name; `getArgument()` reads `$node->$field->getValue()` from the current route node and
  returns `target_id` (single) or a comma-joined list (multi).
- **Security**: no raw SQL; value flows into Views contextual-filter handling. No request-controlled sink.
- **Bugs**: `if ($target_id_count = 1)` assignment (multi-value returns only first); cache max-age is
  PERMANENT despite `url` context.
