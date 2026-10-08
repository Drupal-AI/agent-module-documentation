<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Requirement (requirement) — agent index

A developer API that lets any module declare **configuration requirements and suggestions as plugins**
and — the distinguishing part — attach a **form-based fix an administrator applies from the report**.
Each requirement is a `@Requirement` plugin extending `RequirementBase`; you implement `isCompleted()`
(is the requirement met?), `isApplicable()` (should it be considered at all?), and optionally
`buildConfigurationForm()`/`submitConfigurationForm()` to render the fix. The `RequirementManager`
(`plugin.manager.requirement`) discovers `Plugin/Requirement/Requirement/*`, sorts by `weight`, and
`listRequirement()` returns the applicable instances. A page controller renders them at
`/admin/reports/requirements`, and `RequirementRoutes::routes()` dynamically registers one form route
per requirement (`requirement.{id}` → `/admin/reports/requirement/{id}`) so the report's action button
opens the fix in a modal.

The module also implements `hook_requirements('runtime')` in `requirement.install`: it walks every
applicable requirement, and any that is not completed is summarized on Drupal's Status Report
(`/admin/reports/status`) with the overall severity (error > warning > info) and a link to the full
report. Requirements can be grouped via a second plugin type, `@RequirementGroup`
(`plugin.manager.requirement_group`, `Plugin/Requirement/RequirementGroup/*`), which controls the
fieldset a requirement appears under. Only requirements whose declared `dependencies` are all completed
are shown (`isResolvable()`), so you can gate one requirement behind another.

- Depends on: nothing (`composer.json` requires only `drupal/core`; no `dependencies` in info.yml).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Administration`. License: `GPL-2.0-or-later` (Google LLC).
- Report page at `requirement.report` (`/admin/reports/requirements`), gated by core permission
  `administer site configuration`. **No dedicated settings/`configure` route**, no own permissions,
  no drush, no config schema, no config/install.
- Defines **two plugin types**: `Requirement` and `RequirementGroup`.
- All integrator surface is code: plugins you write in your own module, plus two render elements and
  two theme hooks the report uses.

## What you'd do → where

- **Write a requirement plugin (annotation fields, the methods you must implement, the fix form,
  severity, weight, grouping, dependencies)** → [plugins/requirement.md](plugins/requirement.md)
- **Group your requirements under a fieldset (write a `@RequirementGroup`)** →
  [plugins/requirement.md](plugins/requirement.md)
- **Understand the managers, the report route/controller, the dynamic form routes, the base form,
  the render elements/theme hooks, and the Status Report integration** →
  [api/services.md](api/services.md)

## Key facts (real machine names)

- Plugin type 1 — **Requirement**: manager service `plugin.manager.requirement`
  (`Plugin\RequirementManager`), dir `Plugin/Requirement/Requirement`, interface
  `Plugin\RequirementInterface`, base `Plugin\RequirementBase`, annotation
  `Annotation\Requirement`, alter hook `requirement_info`.
- Plugin type 2 — **RequirementGroup**: manager service `plugin.manager.requirement_group`
  (`Plugin\RequirementGroupManager`), dir `Plugin/Requirement/RequirementGroup`, interface
  `Plugin\RequirementGroupInterface`, base `Plugin\RequirementGroupBase`, annotation
  `Annotation\RequirementGroup`, alter hook `requirement_group_info`.
- `@Requirement` fields: `id`, `group`, `label`, `description`, `form`, `action_button_label`,
  `severity`, `weight`, `dependencies`. `@RequirementGroup` fields: `id`, `label`, `description`.
- Static route: `requirement.report` (`/admin/reports/requirements`) → `RequirementReportController::status`,
  `_permission: administer site configuration`. Menu link `requirement.report` under
  `system.admin_reports`.
- Dynamic routes (via `route_callbacks` → `Routing\RequirementRoutes::routes`): `requirement.{id}`
  → `/admin/reports/requirement/{id}`, `_form` = the requirement's form class (default
  `Plugin\RequirementFormBase`), `_permission: administer site configuration`.
- Render elements: `requirement_report` (`Element\RequirementReport`), `requirements_report_page`
  (`Element\RequirementReportPage`, groups + filters via `preRenderRequirement`).
- Theme hooks: `requirement_report`, `requirements_report_page` (templates in `templates/`);
  preprocess `template_preprocess_requirement_report`.
- Library: `requirement/requirement_report` (`css/requirement_report.css`).
- Severity values: `error`, `warning`, `recommendation` (default `warning`); `getSeverity()` returns
  `completed` once `isCompleted()` is TRUE.
- Module hooks implemented: `hook_help`, `hook_theme`, `hook_requirements` (runtime, in `.install`).
