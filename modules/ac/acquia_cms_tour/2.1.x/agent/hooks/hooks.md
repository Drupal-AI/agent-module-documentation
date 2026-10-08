<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## Hook this module invokes (for integrators)

- **`hook_acquia_cms_tour_info_alter(array &$definitions)`** — alter `@AcquiaCmsTour` card
  definitions (reweight, swap `class`, unset). Documented in `acquia_cms_tour.api.php`. See
  [plugins/tour-cards.md](../plugins/tour-cards.md).
- **`hook_acquia_cms_starter_kit_info_alter(array &$definitions)`** — the equivalent alter for
  `@AcquiaCmsStarterKit` steps (fired by `AcquiaCmsStarterKitManager`).

## Hooks this module implements (in `acquia_cms_tour.module`)

| Hook | Effect |
|---|---|
| `hook_menu_links_discovered_alter` | Repoints core's `help.main` toolbar link to the tour dashboard (`acquia_cms_tour.enabled_modules`) and removes the duplicate `acquia_cms_tour.tour` link. |
| `hook_theme` | Registers `acquia_cms_tour_checklist_form`, `acquia_cms_tour_title_markup`, `acquia_cms_starter_kit_title_markup`. |
| `hook_modules_uninstalled` | Deletes state `acms_<module>_configured` for each uninstalled module (clears a card's "done" flag). |
| `hook_content_model_role_presave_alter` | Grants `access acquia cms tour dashboard` to the `content_administrator` role (this alter hook is provided by `acquia_cms_common`). |

## Install / update hooks (`acquia_cms_tour.install`)

- `acquia_cms_tour_update_8001` / `_8003` — set state `acquia_cms_existing_site = TRUE` (and drop the
  old `existing_site_acquia_cms` key). This flag makes the dashboard skip the first-run
  starter-kit prompt.
- `acquia_cms_tour_update_8002` — revoke the obsolete `access acquia cms tour` permission from all roles.
