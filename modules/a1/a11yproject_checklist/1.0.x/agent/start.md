<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A11Y Project Checklist (a11yproject_checklist) — agent index

Ports the A11Y Project accessibility checklist into Drupal as a **Checklist API** checklist. It supplies only checklist item definitions (fetched from the A11Y Project's public data file), a form template override, and a Tour; Checklist API stores and renders completion state.

- **Version:** 1.0.x · **Core:** `^9 || ^10 || ^11` · **Package:** Accessibility
- **Depends on:** `checklistapi` (contrib; provides the checklist entity, storage, permission and save form)
- **Configure / checklist page:** `/admin/config/development/a11y-project-checklist` → route `checklistapi.checklists.a11yproject_checklist` (route + permission are defined by Checklist API, not this module)
- **No custom routes, permissions, config objects, or config schema of its own.**

## What it provides
- **Service** `a11yproject_checklist_service` = `Drupal\a11yproject_checklist\Service\A11yProjectChecklist` (`src/Service/A11yProjectChecklist.php`). `getA11yProjectChecklist(): array` GETs `checklists.json` from the A11Y Project GitHub repo over the core `http_client` and JSON-decodes it; on connect/request failure it logs + messenger-errors and returns `[]`.
- **Hooks** (`a11yproject_checklist.module`):
  - `hook_checklistapi_checklist_info()` — registers the `a11yproject_checklist` checklist (title, path, help, `#callback`).
  - `callback_checklistapi_checklist_items()` (`a11yproject_checklist_checklistapi_checklist_items()`) — calls the service and maps each remote task into a Checklist API item (`#title`, `#description`, `handbook_page` `#text` = WCAG ref, `#url` = `Url::fromUri($task['url'])`).
  - `hook_theme()` — registers `form__checklistapi_checklist_form` (template `templates/form--checklistapi-checklist-form.html.twig`).
  - `hook_theme_suggestions_alter()` — adds a per-form-id suggestion when the page title is "A11Y Project checklist".
- **Install** (`a11yproject_checklist.install`): `hook_uninstall()` deletes `checklistapi.progress.a11yproject_checklist` config.
- **Config (optional):** `config/optional/tour.tour.a11yproject-checklist.yml` — a Tour for the checklist page (requires the core Tour module to activate).

## Solution docs
- [Configure & operate the checklist](config/checklist.md) — enable, the remote data source, item mapping, theming, tour, and progress export.
