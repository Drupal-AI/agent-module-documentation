<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Summary provides a small service API to find which fields changed between two revisions of a content entity, and the added/removed values within a field.
---
The `revision_summary.compare_revisions` service (`CompareRevisions`) wraps the Diff module's `diff.entity_comparison`. `listChangedFields()` returns a map of changed field machine names → labels; `listChangesInField()` returns `['added' => …, 'removed' => …]` for one field; and there are markup helpers (`listChangesInFieldAsMarkup`, `giveFieldNameWithChangesInlineAsMarkup`) for rendering. There are **no routes, permissions, forms, or blocks** — this is a code-facing developer utility to be called from your own modules/Twig/preprocess.

Security notes for integrators: the revision-loading helpers query with `accessCheck(FALSE)` implicitly via Diff and load node revisions by id, so callers are responsible for their own access control before exposing results. `latestRevisionIdWithChangedField()` builds a raw SQL string that interpolates the field name into the table/column (`node_revision__{field}` / `{field}_value`, revision_summary/src/CompareRevisions.php:176-178); the method is documented as developer-only and the field name is a function argument (not request data), but do not pass untrusted input into it. Several methods are node-specific (hard-coded `node`/`nid`).

Typical setup: enable the module (and Diff), then call the service from your code.
---
- List field names that changed between two node revisions.
- Restrict comparison to a set of watched fields.
- Get added vs removed values for a single field.
- Render field changes as HTML markup.
- Render an inline "field: added X; removed Y" summary.
- Build a revision changelog for editors (with your own access checks).
- Feed changed-field data into notifications.
- Detect the latest revision where a field value changed.
- Reuse Diff's comparison without its UI.
- Integrate revision summaries into custom dashboards.
- Compare only a subset of watched fields.
- Wrap Diff without exposing its full UI.
- Build editor-facing change summaries with your own access checks.
- Detect the latest revision changing a given field.
- Power notification emails on field changes.
- Reuse the service from Twig or preprocess.
