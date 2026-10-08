<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, access hooks, permissions, breadcrumbs & Views

## Services (`drupalorg.services.yml`)

- **`drupalorg.project_service`** — `ProjectService` (args: `@database`, `@entity_type.manager`, `@logger.channel.drupalorg`). Project helpers over nodes + the custom DB tables:
  - `PROJECT_TYPES` const (project_module/theme/distribution/theme_engine/general/drupalorg/translation/core); `projectNodeTypes()`, `isProject()`, `isSandbox()`.
  - `getProjectByMachineName()`, `getProjectByComposerNamespace()`, `getProjectByRepositoryPath()` (reads `drupalorg_project_repositories`).
  - `getProjectMaintainers()` / `isProjectMaintainer()` (reads `project_maintainer`).
  - `getProjectRepositoryInformation()`, `getVersions()` (reads `drupalorg_project_release_supported_versions`), `getProjectType()`, `updateLogo()`.
  - Entity queries here use `accessCheck(FALSE)` (internal lookups feeding access decisions/back-end jobs, not direct rendering to arbitrary users).
- **`drupalorg.user_service`** — `UserService` (args: `@database`, `@entity_type.manager`, `@drupalorg.project_service`). `getUserByUsername()`, `getUserByGitUsername()`, `isSharedAccount()` (`field_shared_account_for_an_org`), `sharedAccountAllowedNodeTypes()`, `isAccountAllowedToEditNode()`.
- **`drupalorg.organization_service`** — `OrganizationService`. `getOrganizationByTitle()`.
- **`drupalorg.breadcrumb`** — `DrupalOrgBreadcrumbBuilder` (priority 1000). `applies()` to node types documentation/guide/casestudy/contribution_record; builds guide-parent chains (`og_group_ref_documentation`), case-study, and project breadcrumbs (contribution_record → `contribution_records\SourceLink` → project). Adds `url` cache context.
- **Event subscribers** — see below.
- `logger.channel.drupalorg`.

## Event subscribers (`src/EventSubscriber/`)

- **`AllowedContentTypes`** (KernelEvents::REQUEST) — enforces `Settings::get('drupalorg_allowed_content_types')`: redirects `user` canonical pages to www.drupal.org for non-`administer users`; redirects nodes/`node.add` of not-allowed bundles to `https://www.drupal.org/i/<nid>` (or shows an admin-only preview for `bypass node access`). Uses `TrustedRedirectResponse`.
- **`SearchApiSubscriber`** (`search_api_opensearch` `QueryParamsEvent`) — when no sort is set, wraps the query in a `function_score` boosting by `active_installs_total` (`log1p`, factor 1.5). No-op unless `search_api_opensearch` fires the event.

## Access hooks & alters (`drupalorg.module`)

- `hook_entity_create_access` / `hook_ENTITY_TYPE_access` (`drupalorg_node_access`) — enforce allowed content types, shared-account edit limits, git-access-agreement requirement for creating projects, and the **security advisory (`sa`) create/edit/view** rules (maintainer-of-project + a valid, existing GitLab security issue matching the project machine name via `_drupalorg_parse_security_issue_url()`; also blocks deleting full projects that still contain GitLab code).
- `hook_entity_field_access` (`drupalorg_entity_field_access`) — field-level rules on `user` and `node`: hides `field_notes`/`field_demographics`/`field_da_listing_opt_out`, gates `field_fingerprint`/`field_reported_registration_ip` behind `administer users`, `field_org_*` behind `administer nodes`/`administer association sponsorships`, `field_logo_url` (automation-only), etc.
- `hook_form_alter` — icon-field classes, project machine-name validation (`drupalorg_project_machine_name_validate`), disables machine name on edit, shared-account status messages, trims menu-link form.
- `hook_cron` (token renewal), `hook_theme` (3 templates), `hook_page_attachments_alter` (attach `drupalorg/icon-field` on admin routes), `hook_options_list_alter` (icon previews), `hook_gitlab_contribution_automated_comment_alter` (adds a forks-management link).
- `hook_views_data_alter` — registers the `drupalorg_node_status` filter on `node_field_data`.

## Permissions (`drupalorg.permissions.yml` + `ExtraPermissions`)

- Static: **`manage security releases`** (security-team access; formerly `update security release types` in D7).
- Dynamic via `permission_callbacks` → `ExtraPermissions::permissions()` (`src/ExtraPermissions.php`): one **`view any unpublished <type> content`** permission per node type (`NodeType::loadMultiple()`).

## Views filter — `DrupalOrgNodeStatus` (`src/Plugin/views/filter/DrupalOrgNodeStatus.php`)

`#[ViewsFilter("drupalorg_node_status")]`, extends core `Status`. `query()` builds a WHERE snippet allowing published rows, the author's own unpublished (`***VIEW_OWN_UNPUBLISHED_NODES***`), `bypass node access`, content-moderation `view any unpublished`, and per-type `view any unpublished <type> content` via a parameterized `type IN (:unpublished_type_access[])` clause.
