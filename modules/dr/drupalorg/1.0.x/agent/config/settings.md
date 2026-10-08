<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, install, cron, Drush & utilities

## Install & requirements (`drupalorg.install`)

- `hook_requirements()` — errors if `\Gitlab\Client` (`m4tthumphrey/php-gitlab-api`) is missing; at runtime errors if `drupalorg.gitlab_settings` `host` or `token` is empty.
- `hook_schema()` — creates four tables: `project_usage_week_release`, `project_maintainer`, `drupalorg_project_repositories` (Drupal nid ↔ GitLab project id/namespace/name), `drupalorg_project_release_supported_versions`. Update hooks `9001`–`9003` add the latter three for migration.

```bash
composer require drupal/drupalorg
drush en drupalorg -y
# optional local sample content:
drush en drupalorg_test_content -y
```

## Config objects

### `drupalorg.gitlab_settings` — `GitLabSettingsForm` (`/admin/config/development/drupalorg-gitlab`, perm `administer site configuration`)

Schema `config/schema/drupalorg.gitlab_settings.schema.yml`; install defaults `config/install/drupalorg.gitlab_settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `host` | string | `https://git.drupalcode.org` | GitLab instance base URL. |
| `token` | string | `CHANGE-ME` | GitLab personal access token used by the API client. |
| `renew_token_on_cron` | boolean | `true` | Auto-rotate the token on cron near expiry. |
| `webhook_token` | string | `CHANGE-ME` | Shared secret expected in the `X-Gitlab-Token` webhook header. |

Form behavior: `token`/`webhook_token` fields default to empty and only overwrite the stored value when populated (existing values shown masked via `concealValue()`); shows an error while `token === 'CHANGE-ME'` or the client cannot connect; `renew_token_on_cron` description shows days-to-expiry. The token is stored in plain config (the standard config store); rotate/manage it via this form or a settings override.

### `drupalorg.settings` — `DrupalOrgSettingsForm` (`/admin/config/development/drupalorg-settings`, perm `administer site configuration`)

| Key | Type | Meaning |
|---|---|---|
| `credit_migration_token` | string | Shared secret for legacy (Drupal 7) drupal.org → this site credit-migration webhook POSTs (`Drupalorg-Credit-Migration-Token` header). |

`validateForm()` rejects saving the literal `CHANGE-ME`. (No `config/install` default ships for this object.)

## Settings.php (`\Drupal\Core\Site\Settings`) knobs — not config

- `drupalorg_allowed_content_types` (array, or `['*']`) — which node bundles are viewable/creatable on the new site (see `AllowedContentTypes`, `drupalorg_node_access`, `drupalorg_entity_create_access`).
- `drupalorg_project_browser_unsupported_drupal_versions` (map of semver-constraint ⇒ explanation) — used by `ProjectBrowserController::checkVersion()`.

## Cron (`drupalorg_cron`)

Renews the GitLab token (`GitLabTokenRenew::renewToken()`) and logs when it is within/past 2 days of expiry.

## Drush commands (`src/Drush/Commands/DrushCommands.php`)

- `drupalorg:calculate-active-installs` → `ActiveInstalls::calculateNewActiveInstalls()`.
- `drupalorg:calculate-composer-namespaces` → `ComposerNamespace::calculateNamespace()`.
- `drupalorg:calculate-composer-compatibilities` → `CoreCompatibility::calculateNewCoreCompatibilities()` (state-tracked incremental run).
- `drupalorg:check-gitlab-system-hooks` — reports disabled GitLab system hooks (non-zero exit on failure).
- `drupalorg:fetch-gitlab-avatars` — sets project logos from GitLab avatars for projects lacking `field_logo_url`.
- `drupalorg:security-populate-milestones` — creates weekly `security` group milestones.

## Utilities (`src/Utilities/`)

- **`ActiveInstalls`** — computes per-project weekly active installs from `project_usage_week_release` and writes `field_active_installs`/`field_active_installs_total`.
- **`CoreCompatibility`** — derives `field_core_semver_minimum`/`maximum` from release `core_compatibility` constraints (via `Requtize\SemVerConverter` + the `UpdateXML` trait which GETs `https://updates.drupal.org/release-history/<project>/current`). `MAX_CORE_SUPPORTED = 12`.
- **`ComposerNamespace`** — populates `field_composer_namespace` (falls back to `drupal/<machine_name>`).
- **`UpdateXML`** trait — cached fetch of the update-status XML.
