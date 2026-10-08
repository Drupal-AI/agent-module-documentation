# Configure: system page targets

Three cooperating surfaces. All three only appear/act when the matching permission is held.

## Permissions (system_page_override.permissions.yml)
- `administer system page override settings` — the eligible-bundles settings form.
- `administer system page overrides` — the overview (direct-path) form.
- `administer node as system page` — the per-node "Systempage settings" checkboxes.

## 1. Settings form — which bundles are eligible
- Route `system_page_override.settings` → `/admin/config/system/system-page-override/settings`
  (`SettingsForm`, requires `administer system page override settings`).
- Lists every `node_type` bundle as a checkbox under three groups: Home page, 403 page, 404 page.
- Saves config `system_page_override.settings` (schema provided) with three sequence keys:
  - `enabled_node_bundles_front`
  - `enabled_node_bundles_403`
  - `enabled_node_bundles_404`
  each an array of enabled bundle IDs. A bundle must be listed here before its nodes can be
  flagged as that system page.

## 2. Node edit form — flag a specific node
- Added by `hook_form_node_form_alter` → `SystemPageOverrideNodeFormExtension::alter()`.
- Only shown when the current user has `administer node as system page` AND the node's bundle
  is enabled for at least one system page.
- Adds a details group titled "Systempage settings" (in the `advanced` vertical-tabs group).
  For each language and each system page the bundle is enabled for, a checkbox appears
  (labeled per language on multilingual sites). Checking → store this node as that page;
  unchecking → revert only if this node is currently the stored target.
- On submit, calls `SystemPageManager::override($page, $langcode, '/node/<id>')` or `->revert()`.

## 3. Overview form — edit paths directly
- Route `system_page_override.overview` → `/admin/config/system/system-page-override`
  (`OverviewForm`, requires `administer system page overrides`).
- One free-text textfield per system page per language, prefilled with the current stored path
  (e.g. `/node/12`). Submitting writes each value straight to State via `SystemPageManager::override()`.
  This edits/overrides whatever the node checkboxes set, and vice versa.

## Where targets are stored
Not in config — in **Drupal State**, key `system_page_override:<page>:<langcode>`
(`<page>` = `front` | `403` | `404`). Because State is per-environment, targets are NOT
exported with configuration.

## Verify (drush, from the DDEV site)
- Config: `ddev drush cget system_page_override.settings`
- Read a stored front-page target: `ddev drush sget system_page_override:front:en`
- Set one directly: `ddev drush sset system_page_override:404:en /node/5`
  (equivalent to the overview form; clear with `ddev drush sdel system_page_override:404:en`).
