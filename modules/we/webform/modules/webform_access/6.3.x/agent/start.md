# webform_access — agent start

Group-based access control for **webform nodes**. Requires `webform` + `webform_node`.

Two config entities:
- `webform_access_type` — a category of access groups (e.g. "Region", "Department").
- `webform_access_group` — bundles **users** + **source webform nodes** + **permissions**
  (view/update/delete/administer) over the submissions of those nodes.

Manage at **Admin → Structure → Webforms → Access**
(`/admin/structure/webform/access/group`, `/admin/structure/webform/access/type`).

- Access is evaluated per webform-submission against the user's group membership, layered on top
  of core webform permissions.
- Provides a Block plugin (`src/Plugin/Block/`) to expose access-group context on node pages.
- Config schema in `config/schema/`; groups/types are exportable configuration.
- Typical use: multi-tenant forms where each team/office/client sees only its own submissions.
