Relabels the View / Edit / Delete admin tabs on node and taxonomy-term pages to include the bundle or vocabulary name (e.g. "Edit Article", "Delete Tags").

---

`bundle_tabs` ("Bundle name in tabs") is a single-file convenience module with no configuration, routes, permissions, entities, or services. It implements `hook_menu_local_tasks_alter()` and, on any page whose route resolves a `node` or `taxonomy_term` parameter, rewrites the first-level local-task tab titles from the generic "View / Edit / Delete" to "View @label / Edit @label / Delete @label", where `@label` is the content type's label (for nodes) or the vocabulary's label (for terms). The strings pass through `t()` with a placeholder, so they are translatable at `/admin/config/regional/translate` (search for `View @label`, `Edit @label`, `Delete @label`) and the label value is auto-escaped. Nothing else on the site changes. It targets node canonical/edit/delete and taxonomy-term canonical/edit/delete tabs only; other entity types are untouched.

---

- Show the content type on a node's tabs so editors see "Edit Article" instead of a generic "Edit".
- Distinguish tabs on multi-bundle sites where many content types share the same tab layout.
- Clarify the delete action — "Delete Recipe" reads more clearly than a bare "Delete" tab.
- Give taxonomy-term pages tabs that name their vocabulary, e.g. "Edit Tags" or "Delete Categories".
- Reduce editor mis-clicks by making each tab self-describing with its bundle name.
- Improve onboarding for new content editors who don't yet know a site's bundle structure.
- Provide clearer context in screenshots and documentation of admin workflows.
- Localize the tab labels: translate the "View @label" / "Edit @label" / "Delete @label" patterns per language via interface translation.
- Adapt tab wording per language without touching code, since the format strings are translatable.
- Enable on a fresh site with zero configuration — install, enable, done.
- Keep the change purely presentational: no data model, permission, or route changes.
- Pair with heavily-nested taxonomy vocabularies so term admins can tell which vocabulary they are editing.
- Help agencies deliver a slightly more polished editor UX with no custom code.
- Serve as a minimal reference example of `hook_menu_local_tasks_alter()` for developers.
- Use on editorial dashboards where the tab bar is the primary navigation for content operations.
- Complement admin-theme tweaks that already emphasize the local-task tab bar.
- Verify behavior quickly: visit any node or term page and confirm the tabs now carry the bundle/vocabulary name.
