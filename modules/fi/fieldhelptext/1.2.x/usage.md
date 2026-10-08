<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Help Text gives one screen for editing the description (help) text on the fields of a bundle — and, per field, the field label — across every bundle, instead of opening each field's settings form one at a time.

---

Help text is the cheapest editorial documentation a site has and the most neglected, because improving it normally means visiting `admin/structure/.../fields/{field}` once per field — dozens of page loads to fix wording that takes seconds to write. This module collapses that into a bulk UI with a landing page at `/admin/structure/fieldhelptext` and two forms. The **by-bundle** form (`/admin/structure/fieldhelptext/by-bundle/{entity_type}/{bundle}`) shows a textarea for every non-base field on a bundle, in form-display order, so you can write or fix all of a content type's help text at once. The **by-field** form (`/admin/structure/fieldhelptext/by-field/{entity_type}/{field_name}`) edits one reused field's label and description across every bundle it appears on, with a checkbox per instance so a single bundle can be excluded when it needs different wording. Both work for all fieldable content entities — nodes, taxonomy terms, users, comments, blocks, media, and so on — and both write straight to the field's own configuration. A single narrow permission, `use fieldhelptext`, gates the whole module: help text lives in field configuration, which core only lets you edit with `administer <entity> fields` (a permission that also allows adding, changing, and deleting fields), so this lets a content designer or technical writer improve guidance without being handed the ability to alter the data model. Core requirement is `^10.3 || ^11`, with no dependencies.

---

- Improve help text across a whole content type at once.
- Edit one reused field's description everywhere it appears.
- Rename a reused field's label across every bundle in one go.
- Exclude a single bundle from a cross-bundle field edit.
- Let a technical writer edit field guidance safely.
- Give content designers a narrow permission instead of field admin.
- Fix inconsistent field descriptions across bundles.
- Document a bundle's fields for editors.
- Reduce clicks when reviewing help text.
- Audit which fields have no help text.
- Standardise wording and tone across bundles.
- Onboard editors with better field guidance.
- Update guidance after a workflow change.
- Reduce editor questions about a field's purpose.
- Review help text as part of a content audit.
- Apply a style guide to field descriptions.
- Fix typos across many fields quickly.
- Add examples to complex fields.
- Add token-based hints to field descriptions.
- Edit help text on non-node entities (terms, users, comments, media).
- Keep documentation next to the field it describes.
- Batch-edit descriptions ahead of a config deployment.
