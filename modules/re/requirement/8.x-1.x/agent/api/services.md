# Managers, routes, forms, render elements and Status Report integration (API)

## Plugin managers

Both are declared in `requirement.services.yml` with `parent: default_plugin_manager`.

- `plugin.manager.requirement` — `Plugin\RequirementManager` implements
  `RequirementManagerInterface`. Adds `listRequirement(): array` — instantiates every discovered
  requirement, keeps only those whose `isApplicable()` is TRUE, keyed by plugin id, ordered by
  `weight` (ascending; set in `findDefinitions()`).
- `plugin.manager.requirement_group` — `Plugin\RequirementGroupManager` implements
  `RequirementGroupManagerInterface`. Adds `listRequirementGroups(): array` — all group instances keyed
  by id.

```php
$manager = \Drupal::service('plugin.manager.requirement');
foreach ($manager->listRequirement() as $id => $requirement) {
  // $requirement is a RequirementInterface instance (applicable only).
  $met = $requirement->isCompleted();
}
```

## Report route and controller

`requirement.routing.yml` declares one static route plus a `route_callbacks` entry.

| Route | Path | Handler | Access |
|---|---|---|---|
| `requirement.report` | `/admin/reports/requirements` | `Controller\RequirementReportController::status` | `_permission: administer site configuration` |

`RequirementReportController::status()` returns a render array
`['#type' => 'requirements_report_page', '#requirement' => $this->requirementManager->listRequirement()]`.
The controller injects `plugin.manager.requirement`. Menu link `requirement.report` places the page
under **Reports** (`system.admin_reports`). `hook_help` adds an intro paragraph on this route.

## Dynamic fix routes

`route_callbacks: ['\Drupal\requirement\Routing\RequirementRoutes::routes']` builds one route per
requirement that returns a form (default: every applicable requirement, because `getForm()` defaults to
`RequirementFormBase::class`).

| Route | Path | Defaults | Access |
|---|---|---|---|
| `requirement.{id}` | `/admin/reports/requirement/{id}` | `_form` = requirement's form class, `_title` = label, `requirement_id` = id | `_permission: administer site configuration` |

Both the report and every fix route require the core `administer site configuration` permission — the
same authority needed to change the configuration a fix would change. There are no anonymous or
`_access: TRUE` routes.

## Base fix form — `RequirementFormBase`

`Plugin\RequirementFormBase extends FormBase`, `getFormId()` = `requirement_base_form`, injects
`plugin.manager.requirement`.

- `buildForm(array $form, FormStateInterface $form_state, $requirement_id = NULL)` — adds an `actions`
  container (primary **Submit** + **Cancel** link back to `requirement.report`), then
  `createInstance($requirement_id)` and calls `$requirement->buildConfigurationForm($form, $form_state)`,
  setting `$form['#title']` to the requirement label.
- `submitForm()` — delegates to `$this->requirement->submitConfigurationForm($form, $form_state)`.

To use a **custom** form instead, set the `form` field in the `@Requirement` annotation to your own
form-class FQCN; `RequirementRoutes` will wire it as the route's `_form`.

## Action button

`RequirementBase::getActionButton()` builds a modal AJAX link (`Link::createFromRoute("requirement.{id}",
…)`) carrying the current `destination`, classes `use-ajax button`, and `data-dialog-type: modal`
(600×450). Returns `[]` when `action_button_label` is empty. `requirement-report.html.twig` renders the
button only when the requirement is **not** completed.

## Render elements and theme

- `#type => 'requirements_report_page'` (`Element\RequirementReportPage`, `@RenderElement`). Its
  `preRenderRequirement()`: filters `#requirement` to `isResolvable()` items, groups them by
  `getGroup()` (or the `_` "Other" group), then buckets each into `error` / `warning` /
  `recommendation` / `completed` severity sections. Theme hook `requirements_report_page`
  (`templates/requirements-report-page.html.twig`) iterates groups → severities → items.
- `#type => 'requirement_report'` (`Element\RequirementReport`, `@RenderElement`) — a single row.
  Theme hook `requirement_report` (`templates/requirement-report.html.twig`), preprocess
  `template_preprocess_requirement_report` which sets `label`, `description`, `is_completed`,
  `severity`, `button` from the requirement and attaches library `requirement/requirement_report`.

## Status Report integration (`hook_requirements`)

`requirement.install` implements `hook_requirements($phase)`. On `phase === 'runtime'` it walks
`plugin.manager.requirement`→`listRequirement()`; for each not-completed requirement it adds the label
to an "unmet" list and raises the overall severity: any `error` ⇒ `REQUIREMENT_ERROR`, else any
`warning` ⇒ `REQUIREMENT_WARNING`, else `REQUIREMENT_INFO`. If anything is unmet it emits a single
`requirement` entry on `/admin/reports/status` linking to `requirement.report`. Nothing is written on
install/update phases.
