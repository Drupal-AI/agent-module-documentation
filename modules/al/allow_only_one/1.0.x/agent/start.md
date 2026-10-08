<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allow Only One (allow_only_one) — agent index

**Enforces uniqueness of a field-value combination (optionally the title) across a node type or vocabulary, blocking duplicates on save.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** node, taxonomy
- **Package:** Field types
- **Field type:** `allow_only_one` (widget `allow_only_one_widget`, formatter `allow_only_one`)
- **Constraint:** `AllowOnlyOne` (`AllowOnlyOneConstraintValidator`), supports `node` + `taxonomy_term` only
- **Config:** field-level third-party settings under the `allow_only_one` namespace (checked field machine names, `title`, `case_sensitive`, `limit_validation_to_published`). No routes, no permissions, no settings page.

**Security:** no routes/endpoints; validation-only. The uniqueness query runs with `accessCheck(FALSE)` and the violation message links to the matched entity, so it can disclose a URL/title the editor could not otherwise access (low impact).

See [configure/field.md](configure/field.md)
