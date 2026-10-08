<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Summary (revision_summary) — agent index
**Developer service to compute changed fields / value diffs between two entity revisions (wraps Diff).**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^8 || ^9 || ^10 || ^11 · **Depends on:** diff
- **Service:** `revision_summary.compare_revisions` (`CompareRevisions`)
- **API:** `listChangedFields()`, `listChangesInField()`, `listChangesInFieldAsMarkup()`, `giveFieldNameWithChangesInlineAsMarkup()`, `latestRevisionIdWithChangedField()`
- **No routes / permissions / UI.**

**Security:** Code-facing only. Callers must apply their own access control (helpers load revisions without user access checks). `latestRevisionIdWithChangedField()` interpolates the field-name argument into raw SQL (CompareRevisions.php:176-178) — developer-only, field name is a code argument, not request input; do not feed it untrusted data. See [api/service.md](api/service.md).
