<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & operate the A11Y Project checklist

## Install / enable
Requires the contrib **Checklist API** module (`drupal/checklistapi`, `require: "*"`).

```
composer require drupal/a11yproject_checklist
drush en a11yproject_checklist -y   # pulls in checklistapi
```

No settings form of its own — `configure` in the `.info.yml` points at the checklist page itself: route `checklistapi.checklists.a11yproject_checklist`, path `/admin/config/development/a11y-project-checklist`. Both the route and the permission that guards it are created by Checklist API from the checklist definition; this module contributes no `*.routing.yml` or `*.permissions.yml`.

## How the checklist is built
Defined entirely in `a11yproject_checklist.module`:

1. `a11yproject_checklist_checklistapi_checklist_info()` (`hook_checklistapi_checklist_info()`) registers one checklist keyed `a11yproject_checklist` with `#title`, `#path` (`/admin/config/development/a11y-project-checklist`), `#help`, and `#callback = 'a11yproject_checklist_checklistapi_checklist_items'`.
2. Checklist API invokes that callback, which calls the service and reshapes the result:
   - each remote group `$key` → a Checklist API group with `#title = $key` and optional `#description = $item['preface']`;
   - each `$task` in `$item['tasks']` → item keyed by `$task['checkboxId']` with `#title = $task['title']`, `#description = $task['description']`, `handbook_page['#text'] = $task['wcag']`, `handbook_page['#url'] = Url::fromUri($task['url'])`.

### Remote data source (`src/Service/A11yProjectChecklist.php`)
Service id `a11yproject_checklist_service`. `getA11yProjectChecklist()`:
- GETs the hard-coded endpoint `https://raw.githubusercontent.com/a11yproject/a11yproject.com/main/src/_data/checklists.json` via the core `http_client` (Guzzle) with `connect_timeout => 30`;
- on HTTP 200, `Json::decode()`s the body and returns the array (returns `[]` if the decoded value is not an array);
- catches `ConnectException` / `RequestException`, logging to the `a11yproject_checklist` channel and adding a messenger error, then returns `[]`.

Consequence: the checklist needs outbound HTTPS to populate. If the fetch fails the callback receives `[]` and the checklist renders empty. The result is not cached by this module — Checklist API's own definition caching applies; rebuild caches (`drush cr`) to re-pull the latest upstream tasks.

## Theming
`hook_theme()` registers `form__checklistapi_checklist_form` → `templates/form--checklistapi-checklist-form.html.twig` (base hook `form`). `hook_theme_suggestions_alter()` appends a suggestion `<hook>__<form-id>` only when the resolved page title equals "A11Y Project checklist", so the override applies just to this checklist form. The template renders the form then appends static "About / Success criteria / Drupal workflow" explanatory markup and capitalizes the vertical-tab labels.

## Tour
`config/optional/tour.tour.a11yproject-checklist.yml` defines a step-by-step Tour (`id: a11yproject-checklist`) bound to the checklist route. It activates only when the core **Tour** module is enabled (optional config, so it is imported if Tour is present at install time).

## Operating / progress
Completion state is owned by Checklist API, not this module:
- checking items and clicking **Save** records the date, time and user per item into config `checklistapi.progress.a11yproject_checklist`;
- that config can be exported to code like any other configuration for repeatable, auditable reviews;
- Checklist API shows a percent-complete progress bar (see the Tour's `progress` step).

`hook_uninstall()` (`a11yproject_checklist.install`) deletes `checklistapi.progress.a11yproject_checklist` when the module is uninstalled.

## Access
There are no module-specific permissions. Visibility of the checklist page is governed by Checklist API's permission for this checklist (e.g. "Edit … checklist"); grant it to the roles that should record accessibility progress. It is a standard admin config path — no anonymous or mutating endpoints are added by this module.
