<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contribution Records (contribution_records) — agent index

Credit-tracking backend for the **new www.drupal.org**. Stores per-issue contribution credit
as `contribution_record` **nodes** whose contributors are `contributor` **Paragraphs**, synced
from Drupal.org (`api-d7`) and GitLab (git.drupalcode.org) issues/MRs. Version **1.0.0**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Package `DrupalOrg`.

Depends on `paragraphs`, core `node`, and `drupalorg` (which supplies the project/user/
organization services, the GitLab client trait, and the `drupalorg.settings` /
`drupalorg.gitlab_settings` config consumed here). Also needs the `m4tthumphrey/php-gitlab-api`
and `marufmax/emoticon-php` libraries. **Assumes the surrounding site config already exists**:
the `contribution_record` content type, the `contributor` paragraph type, all `field_*` fields,
and the `contribution_records` / `contribution_records_metrics` views plus `jsonapi_views`
displays. This module ships **no** `config/install` or `config/schema`, entity types, or fields.

## What it provides

- **Service class `SourceLink`** (`src/SourceLink.php`, `ContainerInjectionInterface`, resolved
  via `class_resolver`, not a `*.services.yml` entry) wrapping per-source classes in
  `src/SourceLink/` (`DrupalOrgIssue`, `GitDrupalCodeIssue`, `GitDrupalCodeMergeRequest`, plus
  `Dev*` variants) behind `SourceLinkInterface`. Detects/validates/fetches issue data and
  creates/syncs records + contributor paragraphs.
- **Controller** `ContributionRecordController` — 9 routes (process, import, by-user/-org
  listings, metrics, source-activity, save-order). See [api/routes.md](api/routes.md).
- **Two forms**: `SettingsForm` (`contribution_records.settings`) and `QuickCreditsForm`
  (maintainer credit table, embedded on the record via `hook_preprocess_node`).
- **Plugins**: QueueWorker `contribution_records_import_queue_worker`; EntityReferenceSelection
  `default:node_user_organization`. See [plugins/plugins.md](plugins/plugins.md).
- **Drush** command class `contribution_records:sync-contribution-records` and
  `:check-import-status` (`src/Drush/Commands/DrushCommands.php`).
- **Hooks** in `.module`: `entity_access`, `entity_delete`, `node_presave`, `form_alter`,
  `preprocess_node`/`_paragraph`/`_field`, `theme`, `menu_local_tasks_alter`,
  `views_pre_build`, `gitlab_contribution_automated_comment_alter`.
- **Permission**: `administer contribution records` (edit/delete any record as a non-maintainer).

## Docs

- **Settings form, `contribution_records.settings`, dev sources, `$settings` keys, requirements** →
  [config/settings.md](config/settings.md)
- **Routes, permissions, import token, listing/metrics endpoints** → [api/routes.md](api/routes.md)
- **`SourceLink` service, source classes, sync/create/import logic** → [api/sourcelink.md](api/sourcelink.md)
- **Queue worker, entity-reference selection, Drush commands** → [plugins/plugins.md](plugins/plugins.md)
