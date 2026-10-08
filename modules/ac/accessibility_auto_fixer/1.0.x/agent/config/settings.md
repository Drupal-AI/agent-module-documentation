<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable
`drush en accessibility_auto_fixer` then `drush updb` (creates `a11y_results`, `a11y_fixes`
via `hook_schema` in `accessibility_auto_fixer.install`; `update_10001` back-fills `a11y_fixes`).
Depends on `node`. `hook_uninstall` deletes the `accessibility_auto_fixer.settings` config.

## Settings form
`Form\AccessibilitySettingsForm` (`ConfigFormBase`, form id `accessibility_auto_fixer_settings`)
at route `accessibility_auto_fixer.settings` → `/admin/config/development/a11y-settings`, gated by
`administer accessibility settings` (`restrict access: true`). Editable config:
`accessibility_auto_fixer.settings` (the only name in `getEditableConfigNames()`).

The module ships **no** `config/install/*` and **no** `config/schema/*`. All defaults are the
`$cfg->get('key') ?? <default>` fallbacks in `buildForm()`; the config object is only written when
the form is saved (`submitForm`). Because there is no schema, values are stored untyped.

### Config keys (object `accessibility_auto_fixer.settings`)
| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | TRUE | Master enable; also gates the node scan tab (`NodeScanController::access`). |
| `auto_scan` | bool | FALSE | "Scan every page on load for logged-in users" (a UI intent flag). |
| `min_score` | int | 70 | Threshold below which pages are highlighted (select 0..100 step 10). |
| `exclude_roles` | array | [] | Roles excluded from auto-scan (checkboxes of `user_role` labels). |
| `enabled_node_types` | array | all types | Node bundles that show the "Scan this page" tab. |
| `scan_aria` | bool | TRUE | Toggle ARIA-label checks. |
| `scan_contrast` | bool | TRUE | Toggle colour-contrast checks. |
| `scan_alt` | bool | TRUE | Toggle missing-alt checks. |
| `autofix_aria` | bool | TRUE | Allow auto-fixing missing ARIA labels. |
| `autofix_alt` | bool | TRUE | Allow auto-fixing missing alt text. |
| `fail_on_critical` | bool | TRUE | Drush scans exit 1 on critical issues (documented intent). |
| `report_email` | string | '' | Email for scan summaries (stored; no mailer in this version). |

Note: several toggles (`scan_*`, `autofix_*`, `min_score`, `auto_scan`, `exclude_roles`,
`fail_on_critical`, `report_email`) are persisted by the form but are **not** read by the
scanners/controllers in this release — the client and server scanners always run their full check
set. Only `enabled` and `enabled_node_types` are consumed, by `NodeScanController::access()`.

## Node scan tab access
`NodeScanController::access(NodeInterface $node, AccountInterface $account)` allows the
`/node/{node}/a11y-scan` tab only when: the account has `access accessibility reports`, config
`enabled` is truthy, and the node's bundle is in `enabled_node_types` (empty list = all types).
Route also requires `_entity_access: node.view`. The tab renders a single "Scan this page" button
(`accessibility_auto_fixer/dashboard` library attached).

## Admin menu / task links
- `accessibility_auto_fixer.links.menu.yml`: Dashboard under `system.admin_reports`, with
  Scan Logs and Settings as children.
- `accessibility_auto_fixer.links.task.yml`: the `Accessibility Scan` local task on
  `entity.node.canonical`.
