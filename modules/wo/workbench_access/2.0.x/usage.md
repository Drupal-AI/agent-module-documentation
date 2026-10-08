Workbench Access adds editorial access control based on hierarchies: content is placed in an editorial "section", and users or roles assigned to that section (or its parents) may edit it. Sections come from an existing structure — a taxonomy vocabulary or a menu — described by an `access_scheme` config entity.

---

Workbench Access lets a site partition editorial permissions by content "section" rather than granting blanket edit rights. You define one or more **access schemes** (the `access_scheme` config entity), each driven by an **AccessControlHierarchy** plugin that turns some existing hierarchy into sections: the bundled `taxonomy` plugin uses vocabulary terms, and the bundled `menu` plugin uses menu-tree items. A scheme names its plugin in the `scheme` key and stores per-plugin options in `scheme_settings` (e.g. which vocabularies and which entity fields hold the section reference, or which menus and node bundles participate). Editors are then assigned to sections per-user (a `section_association` entity) or per-role, and when they create or edit content they must file it under a section they belong to; users in that section or any ancestor section can edit it. Access is additive — Workbench Access only *denies* untrusted users, so an editor still needs a normal permission such as "Article: Edit any content", and the `bypass workbench access` permission grants access to every section. The whole thing is administered at `/admin/config/workflow/workbench_access` and is extensible: any module can add a new hierarchy source by writing an AccessControlHierarchy plugin. It can run stand-alone with no dependency on the wider Workbench suite.

---

- Restrict which editors can edit which articles by filing content under taxonomy-based editorial sections.
- Build a "Department" or "Editorial section" vocabulary and use it as an access hierarchy.
- Use an existing site menu as the access hierarchy so sections mirror the site's navigation tree.
- Create multiple access schemes at once (e.g. one taxonomy scheme and one menu scheme) on the same site.
- Grant a role blanket edit rights within one section while other roles stay locked out.
- Assign an individual user to a specific section without changing their role.
- Give editors of a parent section edit rights over all child sections beneath it.
- Deny access to content that has not been assigned to any section (`deny_on_empty` setting).
- Let super-editors skip all section checks with the `bypass workbench access` permission.
- Show each content page's editorial section status to reviewers (`view workbench access information`).
- Batch-assign many nodes to a section from the content overview page.
- Add a new hierarchy source (e.g. domains, org chart) by writing a custom AccessControlHierarchy plugin.
- Filter or display a node's editorial section in Views via the module's Views field/filter plugins.
- Place the "Workbench Access" block to show the current user's assigned sections.
- Configure which node bundles and which entity fields carry the section reference for a scheme.
- Reuse the scheme across content types by mapping the section field on each bundle.
- Restrict user-reference and taxonomy-reference widgets to only the sections an editor may use (entity_reference selection handlers).
- Install a demo taxonomy hierarchy and field quickly with `drush workbench_access:installTest`.
- Flush all section assignments during testing with `drush workbench_access:flush`.
- Delegate section-assignment administration with `assign workbench access` / `assign selected workbench access`.
- Alter a scheme's stored settings programmatically via `hook_workbench_access_scheme_update_alter()`.
- Model editorial ownership for a large multi-team newsroom where each desk owns its section.
- Enforce that freelance or junior editors can only touch content in their assigned area.
- Combine taxonomy sections with node access so section membership gates edit access site-wide.
- Query a user's or role's assigned sections programmatically through the user/role section storage services.
