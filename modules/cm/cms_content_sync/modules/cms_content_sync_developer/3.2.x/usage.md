<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Developer tooling for Content Sync: warns site builders when a Flow's entity-type configuration has drifted out of date (a "version mismatch"), and adds Drush helpers to update flows and force-delete entities.

---

This submodule watches configuration changes (e.g. adding a field to a content type used in a Flow) and, via its `VersionComparison` and `VersionWarning` event subscribers, records a `version_mismatch` in its own `cms_content_sync.developer` config and shows admins a warning message so they know to re-export the affected Flow(s). It integrates with `config_ignore` (a hard dependency) through `hook_config_ignore_settings_alter()`, adding `cms_content_sync.developer:version_mismatch` to the ignore list so the transient warning state is not captured by config export. It also provides two Drush commands: `cms_content_sync_developer:update-flows` (alias `csuf`) which re-exports/updates all flow configurations and clears version warnings, and `cms_content_sync_developer:force-entity-deletion` (alias `csfed`) which force-deletes an entity (by type + `--entity_uuid` or `--bundle`) from the sync bookkeeping. It has no permissions and no admin form of its own; the config entity is internal state.

---

- Alert site builders when a content type used in a Flow has changed and the Flow needs re-exporting.
- Detect entity-type version drift automatically after editing fields on a synced bundle.
- Re-export all Content Sync Flow configurations in one step with `drush csuf`.
- Clear stale version-mismatch warnings after updating flows.
- Force-delete a specific synced entity by UUID with `drush csfed node --entity_uuid=...`.
- Force-delete all synced entities of a bundle with `drush csfed node --bundle=basic_page`.
- Keep the transient `version_mismatch` state out of exported config via config_ignore.
- Give developers a faster feedback loop while iterating on Flow configuration.
- Diagnose "why won't this entity sync" by clearing its bookkeeping and retrying.
- Avoid manually visiting each Flow edit form to push configuration updates.
- Use in CI/deploy scripts to programmatically refresh flow versions after config import.
- Warn editors before they push content whose entity-type version no longer matches the backend.
- Inspect `cms_content_sync.developer:version_mismatch` to see which flows are flagged.
- Recover from a stuck entity that normal deletion won't remove from Content Sync.
- Support a config-management workflow where flow versions must be kept in sync with code.
- Reduce accidental drift between a site's content model and its syndication configuration.
- Provide a maintenance command surface for site reliability engineers running Content Sync.
- Combine with the health submodule to both detect and then resolve version mismatches.
- Teach new developers which config key holds the version-warning state.
