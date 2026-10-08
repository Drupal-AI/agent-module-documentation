Override Node Options grants granular permissions over the Authoring information and Publishing options on the node add/edit form, letting non-administrators control fields like published status, promoted, sticky, author, date, and revisions without the all-powerful "administer nodes" permission.

---

By default Drupal hides the Authoring information and Publishing options fieldsets from anyone who lacks the `administer nodes` permission — an all-or-nothing switch that is far too broad to grant to ordinary editors. Override Node Options breaks that fieldset apart into individual, permission-gated controls. It works entirely through Drupal's field- and form-access systems: `hook_entity_field_access_alter()` selectively grants access to the `status`, `promote`, `sticky`, `uid` (authored by), `created` (authored on), and revision-log fields, and `hook_form_alter()` exposes the revision checkbox, each based on a matching permission. Permissions come in two flavours, toggled on a small settings form: **general** permissions that apply across all content types (e.g. "Override all published options"), and **content-type-specific** permissions generated per node type (e.g. "Override Article published option"). This means you can let, say, editors set the publish state and author on Articles while withholding those controls elsewhere. The module has no effect on which nodes a user can edit — it only reveals options on forms they already have edit access to. It is a lightweight, long-standing building block for editorial workflows and custom role design.

---

- Let editors publish or unpublish their own content without `administer nodes`.
- Allow a role to set the "Authored by" user on nodes they edit.
- Permit changing the "Authored on" date for backdating articles.
- Give editors the "Promoted to front page" checkbox for Articles only.
- Expose the "Sticky at top of lists" option to forum moderators.
- Allow trusted authors to create a new revision when editing.
- Let a role enter revision log messages per content type.
- Grant publishing control on Articles but not on Pages.
- Build a "Contributor" role that can draft but not publish.
- Build an "Editor" role that can publish and set authorship.
- Restrict front-page promotion to a marketing team role.
- Allow guest bloggers to be assigned as the author of migrated content.
- Enable per-type revision permissions for an audit-heavy content type.
- Keep the powerful `administer nodes` permission off day-to-day roles.
- Let a legal-review role toggle sticky/promoted flags on policy pages.
- Delegate authorship reassignment to a content-operations role.
- Turn off content-type-specific permissions to keep the list short.
- Use only general permissions on a small single-content-type site.
- Combine with core's per-type edit permissions for fine-grained workflows.
- Allow scheduling teams to set authored-on dates for planned posts.
- Give reviewers revision-log access without full node administration.
- Support decoupled editors who set publish state via the standard node form.
