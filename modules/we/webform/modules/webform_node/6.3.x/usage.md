Webform Node adds a "Webform" content type (and a Webform entity-reference field) so any webform can be embedded in a node, giving each form its own page, URL alias, menu placement, and per-node submissions.

---

The core Webform module renders forms at `/webform/{id}`, but many sites want a form to behave like ordinary content — with a node URL, path alias, menu link, revisions, and access control. Webform Node provides a `webform` content type built around a **Webform entity-reference field**, letting editors pick which webform (and default submission data/state) a node displays. Submissions made through the node are tracked against that node, so results, downloads, and clearing are available per-node at `/node/{node}/webform/results/*`. The module also exposes a **references** report at `/admin/structure/webform/manage/{webform}/references` listing every node pointing at a given webform. It ships six granular permissions (view/edit/delete submissions for any vs. own node) layered on top of core Webform access. Because the webform reference is a field, you can add it to other content types too, and configure whether the node shows the form, a preview, or default data. It integrates with tokens, path, and node revisions.

---

- Give each form its own node page with a clean URL alias and menu link.
- Embed a shared webform in multiple landing-page nodes via the reference field.
- Track submissions per node rather than only per webform.
- View per-node results at `/node/{node}/webform/results/submissions`.
- Download per-node submission exports (CSV/Excel).
- Clear submissions for a single node without affecting other nodes.
- Grant editors "edit webform submissions own node" for self-service moderation.
- Let users view only submissions on nodes they authored (own node permissions).
- Add a Webform field to an existing content type (e.g. Landing Page).
- Set default submission data or a default form state per node.
- Show a confirmation page at `/node/{node}/webform/confirmation`.
- Let authenticated users see their own drafts/submissions under the node.
- Audit which nodes reference a given webform via the references report.
- Add new webform-referencing nodes from the references add form.
- Place contact or registration forms in the site menu as normal pages.
- Apply node-level access control and revisions to form pages.
- Use path alias patterns (Pathauto) on webform nodes.
- Test a node's form via `/node/{node}/webform/test`.
- Duplicate a webform node to spin up a variant form page.
- Expose per-node submission views (table/text/YAML) to reviewers.
- Combine with layout/blocks so a form page can carry extra content.
- Provide role-scoped dashboards of "my form submissions" per node.
