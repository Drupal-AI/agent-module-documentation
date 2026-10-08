<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Content Access Control is a **config-only** LocalGov Drupal (LGD) module that wires up
[Workbench Access](https://www.drupal.org/project/workbench_access) into a ready-to-use, section-based
editorial permission model. On install it ships an "Access Control" taxonomy vocabulary, a
`localgov_access_control` node field added to the Subsite Overview, Subsite Page, Service Landing and
Service Page content types, a `site_section` workbench_access **access scheme** (taxonomy-based), and a
new "Devolved Editor" role. The goal: let a subset of editors (e.g. people outside your organisation)
create/edit only content in the sections they are assigned to.

---

The module contains **no PHP access logic of its own** — its `.module` file is empty. All actual
enforcement is delegated to the `workbench_access` contrib module, whose access scheme (`site_section`,
`scheme: taxonomy`, vocabulary `access_control`) gates node edit/create by the term(s) an editor is
assigned to. The vocabulary is hierarchical, so assigning an editor a parent term grants access to all
child terms. Editors are assigned to sections at `/admin/config/workflow/workbench_access` (per-user or
per-role). The `hook_install()` grants the three workbench permissions (`use workbench access`,
`access workbench`, `view workbench access information`) to every role **except** `anonymous` and
`authenticated`. Depends on `workbench` and `workbench_access`. Remember to enable the access-control
field on the "Manage form display" of each content type so editors can see it. Uninstalling does not
remove the created config automatically.

---

- Restrict a subset of editors to only edit content in their assigned site sections.
- Onboard external/partner editors with the bundled "Devolved Editor" role.
- Model an org's section hierarchy as an "Access Control" taxonomy (parent term grants child access).
- Let "News editor" role members edit only the News section via role-based section assignment.
- Add the access-control field to Service Page / Service Landing / Subsite content types out of the box.
- Extend the pattern to additional content types by adding the same field.
- Assign individual editors to one or more sections manually.
- Assign a whole role to a section so all its members inherit that section's access.
- Give a devolved editor create rights for news/events but only edit rights for landing pages.
- Provide a turnkey workbench_access setup without hand-building schemes and fields.
- Delegate editorial control of a subsite to a specific team.
- Keep central editors with full access while scoping others down.
- Prevent editors from touching sections they are not assigned to.
- Use taxonomy hierarchy to grant broad access to a section head and narrow access to a contributor.
- Add more workbench_access schemes ("scenarios") if a single Site Section scheme is not enough.
- Seed a new LGD site with a working content-access baseline on module install.
