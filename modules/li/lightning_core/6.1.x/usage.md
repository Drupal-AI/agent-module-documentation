Lightning Core is the shared base module for the Lightning distribution: it supplies cross-cutting APIs (entity descriptions, entity-form/view-mode overrides, an administrator access check) and a handful of optional feature submodules, rather than a single end-user feature.

---

Lightning Core underpins the Lightning distribution but is a normal contrib module you can install on any Drupal 9.3/10/11 site. It overrides the `user_role`, `entity_view_mode` and `entity_form_mode` entity classes so they gain a human-readable **description** stored in `third_party_settings.lightning_core.description`, and lets view/form modes be flagged `internal` or carry a `revision_ui` toggle. It adds an `_is_administrator` route access check (backed by the `AdministrativeRoleCheck` service) so routes can be gated on "is this user in an admin role", and hangs a **Lightning** settings menu at `/admin/config/system/lightning` (route `lightning_core.settings`). It ships a `Long (12-hour)` core date format, a `RoleForm` that adds a description field to the role edit form, bulk add/edit forms for display modes, a `YieldToArgument` Views bundle-filter enhancement, a default user avatar, and Drush command hooks that add a `base-profile` field to `drush core:status` and prune plugin caches before `drush updatedb`. Four optional submodules build turnkey features on top of it: **Lightning Roles** (auto content roles), **Basic Page** (a page content type), **Lightning Search** (Search API index), and **Contact Form** (site-wide contact form). Most of Lightning Core's value is API/plumbing that other modules and site builders consume.

---

- Provide a shared base layer required by other Lightning distribution modules.
- Add a human-readable description to a user role (stored under `lightning_core.description`).
- Add descriptions to entity view modes and form modes so editors know what each is for.
- Flag a view mode or form mode as `internal` so it is hidden from normal display-mode UIs.
- Enable a per-form-mode `revision_ui` toggle to show/hide the revision UI on entity forms.
- Gate a custom route on "the current user has an administrator role" with `_is_administrator: 'true'`.
- Look up the site's administrator role(s) programmatically via the `AdministrativeRoleCheck` service.
- Give site admins a single **Lightning** config landing page at `/admin/config/system/lightning`.
- Install a ready-made `Long (12-hour)` date format (`F j, Y \a\t g:i A`).
- Show a description field on the user-role add/edit form.
- Provide bulk creation/edit forms for entity display (view/form) modes.
- Ship a default user avatar image for sites that want one.
- Add a `base-profile` column to `drush core:status` output for distribution-based sites.
- Automatically clear plugin discovery caches before database updates run (`drush updatedb`).
- Expose the `DisplayHelper` service to read/manipulate entity view displays in code.
- Use `OverrideHelper` to swap an entity's class, form handler, or a plugin class from a hook.
- Read/write config-entity descriptions through `EntityDescriptionInterface`.
- Enhance a Views exposed bundle filter to yield to a contextual argument.
- Bootstrap a Lightning-style site with content roles, a basic page type, and search by enabling its submodules.
- Add a simple "Basic page" content type (via the Basic Page submodule).
- Auto-create creator/reviewer roles per content type (via the Lightning Roles submodule).
- Provide a turnkey site-wide search index (via the Lightning Search submodule).
- Provide a site-wide contact form with sensible defaults (via the Contact Form submodule).
