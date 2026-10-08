<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report page & routes

The module has **no settings form** (`configure: null`). Its UI is a report + confirm-fix flow.

## Routes (`meaofd.routing.yml`)

- `meaofd.report` -> `/admin/reports/mismatched-entity-and-or-field-definitions`
  (Reports menu link `meaofd.report`, parent `system.admin_reports`). Controller
  `MismatchedEntityAndOrFieldDefinitionsReportController::report`. Permission:
  `view mismatched entity and or field definitions`. `no_cache: TRUE`, `_admin_route: TRUE`.
- `meaofd.fix` -> `/admin/reports/mismatched-entity-and-or-field-definitions/{entity_type}/fix`
  Confirm form `MismatchedEntityAndOrFieldDefinitionsReportFixForm`. Permission:
  `fix mismatched entity and or field definitions`, plus custom access
  `accessIfEntityHasMismatchedEntityAndOrFieldDefinitions` (route is only reachable when that entity
  type actually has pending changes).

## Report page behaviour

- Reads `meaofd.fixer::getChangeSummary()`. If empty, prints
  *"No mismatched entity and/or field definitions found."*
- Otherwise renders a table: **Entity ID | list of changes | Actions**. The action is a link to
  `meaofd.fix` labelled **Fix** (single change) or **Fix all** (multiple), shown as a disabled span
  if the user lacks the fix permission.

## Fix flow

`meaofd.fix` is a `ConfirmFormBase`. Confirming runs a Batch (`BatchBuilder`) whose operation calls
`\Drupal::service('meaofd.fixer')->fix($entity_type)`; on finish it shows a success/warning/error
message and redirects back to `meaofd.report`.

## Scriptable equivalent

There is no config to set. To fix without the UI use Drush (`drush meaofd:fix <entity_type_id>`) or the
service directly (`\Drupal::service('meaofd.fixer')->fix('<entity_type_id>')`).
