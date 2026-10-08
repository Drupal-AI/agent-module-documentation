# Lightning Core — agent index

Shared base/plumbing module for the Lightning distribution (installable standalone).
No end-user feature of its own; it adds cross-cutting APIs plus optional submodules.
Machine name `lightning_core`. Config landing page: `/admin/config/system/lightning`
(route `lightning_core.settings`, gated by `_is_administrator`). Provides Drush command
hooks and config schema; **no** permissions or plugin types of its own.

- **Configure / config it manages** — Lightning settings menu, `_is_administrator` access
  check, the `long_12h` date format, and entity descriptions / `internal` / `revision_ui`
  third-party settings on roles and display modes: [configure/lightning_core.md](configure/lightning_core.md)
- **API surface** — `EntityDescriptionInterface` + `ConfigEntityDescriptionTrait`, the
  `Role` / `EntityViewMode` / `EntityFormMode` overrides, `AdministrativeRoleCheck`,
  `DisplayHelper`, `OverrideHelper`, and the Drush `core:status` base-profile hook:
  [api/lightning_core.md](api/lightning_core.md)

Submodules (each documented separately, recipe-only): `lightning_roles` (auto content
roles), `lightning_page` (Basic Page type), `lightning_search`, `lightning_contact_form`.
