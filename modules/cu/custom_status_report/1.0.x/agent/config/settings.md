<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Status Report — settings, config, and the card pipeline

## Install / enable

`drush en custom_status_report` (or `ddev drush en custom_status_report`). No dependencies beyond
Drupal core (`^9 || ^10 || ^11`). Install writes `config/install/custom_status_report.settings.yml`.
No update hooks, no `.install` file.

## Config object: `custom_status_report.settings`

Two nested maps, both keyed by **card id**:

```yaml
card_visibility:      # 1 = show, 0 = hide
  drupal: 1
  webserver: 1
  cron: 1
  php: 1
  database_system: 1
  custom_status_report: 1
card_weight:          # lower sorts first
  drupal: 0
  webserver: 1
  cron: 2
  php: 3
  database_system: 4
  custom_status_report: 5
```

There is **no `config/schema/`** in the module, so these keys are untyped for config
inspection/translation. Editable via the form below or `drush config:set`.

## Route, menu, permission

- Route `custom_status_report.settings` (`custom_status_report.routing.yml`) →
  `/admin/config/system/custom-status-report`, `_form`
  `\Drupal\custom_status_report\Form\CustomStatusReportSettingsForm`, requirement
  `_permission: 'administer site configuration'`.
- Menu link (`custom_status_report.links.menu.yml`) under `system.admin_config_system`, weight 100.
- The Status Report page itself (`/admin/reports/status`) stays a core route; core gates it with
  `administer site configuration`. This module defines **no permissions of its own**.

## Form: `CustomStatusReportSettingsForm`

`src/Form/CustomStatusReportSettingsForm.php`, extends `ConfigFormBase`, `getFormId()` =
`custom_status_report_settings`, edits `custom_status_report.settings`. Constructor injects
`module_handler` (`ModuleHandlerInterface`) and `extension.list.module` (`ModuleExtensionList`).

`buildForm()`:
- Renders a link button to `/admin/reports/status`.
- Builds a draggable `#type => table` (tabledrag group `table-sort-weight`) inside a `details`
  element. Rows = the five core sections (`drupal`, `webserver`, `cron`, `php`, `database_system`)
  plus every "custom" card discovered by `getOtherModules()`.
- `getOtherModules()` iterates `moduleHandler->getModuleList()` and includes any module for which
  `moduleHandler->hasImplementations('requirements_alter', $module)` is true, labelling it
  `<name> (custom)`. (Note: this is a heuristic — it lists modules that implement the alter hook,
  regardless of whether they set `add_to_general_info`.)
- Each row: a `checkbox` (`visibility`, default from `card_visibility.<key>` ?? TRUE) and a
  `weight` element (default from `card_weight.<key>` ?? 0). Rows are pre-sorted by weight.
- Actions: **Save All Changes** (default submit) and **Cancel** (`::cancel`, redirects back to the
  settings route with `#limit_validation_errors => []`).

`submitForm()`: loops `$form_state->getValues()['table-row']`, skipping the meta keys
`form_build_id`, `form_token`, `form_id`, `op`, `submit`, and writes each row's `visibility` →
`card_visibility.<section>` and `weight` → `card_weight.<section>`, then `$config->save()`.

`hook_form_alter()` attaches the `custom_status_report/status_overrides` library to this form
(form id `custom_status_report_settings`).

## Render pipeline: how cards are filtered and ordered

`hook_element_info_alter()` finds the `status_report_page` element's `#pre_render`
`preRenderGeneralInfo` entry and rebinds it to
`Drupal\custom_status_report\Element\CustomStatusReportPage` (a subclass of core
`\Drupal\system\Element\StatusReportPage`).

`CustomStatusReportPage::preRenderGeneralInfo()`:
1. Calls `parent::preRenderGeneralInfo()` to get core's `#general_info` structure.
2. Reads `card_visibility` from config; for each card with value falsy it `unset()`s the matching
   `#general_info` key(s) — `php` also drops `#php_memory_limit`; the `database` case drops
   `#database_system` and `#database_system_version`. (Note the config uses key `database_system`
   while this filter's `switch` case is `database`, so hiding the database card via config's
   `database_system` key is not matched by this branch.)
3. Appends any `#requirements[$key]` that has `add_to_general_info === TRUE`, exists in
   `card_visibility`, and is set to `1`, as `#general_info['#' . $key]`.
4. Reads `card_weight`, buckets each `#general_info` array card by its weight into `$ordered_cards`,
   attaches core title/icon for the five default cards via `getCoreCardInfo()`, carries
   `php_memory_limit` / `database_system_version` sub-info, `ksort()`s, and sets
   `#general_info['#cards']`.

`hook_theme_registry_alter()` repoints the `status_report_general_info` theme hook to the module's
`templates/status-report-general-info.html.twig` and adds a `cards` variable. The template loops
`cards` (weight → card → data), rendering each as a `.card` with `data.module_icon` (an `<img>`),
else `data.icon` (a CSS icon span), else the drupal icon, plus `title`, `value`, `description`, and
special sub-layouts for `php` (Version + Memory limit) and `database_system` (Version + System).

## Extension: add your own card (for other modules)

In your own module implement `hook_requirements_alter()` and add a requirement with
`add_to_general_info => TRUE`:

```php
function mymodule_requirements_alter(array &$requirements) {
  $requirements['mymodule_status'] = [
    'title' => 'My Status',
    'value' => t('Everything is fine.'),
    'severity' => REQUIREMENT_OK,
    'add_to_general_info' => TRUE,
    // Optional; falls back to the Drupal logo if omitted.
    'module_icon' => '/' . \Drupal::service('extension.list.module')
      ->getPath('mymodule') . '/icons/my.png',
  ];
}
```

The card then appears as a toggleable, weightable row on the settings form and, when enabled,
renders in the General System Information grid. The module's own
`custom_status_report_requirements_alter()` registers its "installed" OK card the same way, using
`icons/task-list.png`.

## Operate

1. Go to **Configuration » System » Custom Status Report Settings**
   (`/admin/config/system/custom-status-report`).
2. Check/uncheck cards and drag to reorder.
3. **Save All Changes**, then view `/admin/reports/status` to see the customized General System
   Information section. Config can also be managed with `drush config:set custom_status_report.settings …`
   and exported/imported like any config.
