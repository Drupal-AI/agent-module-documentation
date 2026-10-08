<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Core — admin section, route & permission

Everything Convivial Core ships lives in three small YAML files. There is no PHP, no config schema, and no
settings form of its own — the module only creates a shared admin home for the Convivial CXP stack.

## Install / enable
- Add via Composer: `drupal/convivial_core`; enable: `drush en convivial_core`.
- No dependencies beyond Drupal core (`system`). No configuration is required or stored by this module.
- Usually installed indirectly because another Convivial module (Components, Enricher, Profiler, etc.)
  depends on it.

## Route (`convivial_core.routing.yml`)
- `convivial_core.admin_convivial`
  - path: `/admin/config/convivial`
  - `_title`: "Convivial CXP"
  - `_controller`: `\Drupal\system\Controller\SystemController::systemAdminMenuBlockPage` — the standard Drupal
    core controller that renders an admin section index (the list of child admin links). Convivial Core does
    NOT define its own controller.
  - `requirements._permission`: `access convivial administration pages`

## Permission (`convivial_core.permissions.yml`)
- `access convivial administration pages` — title "Use the convivial administration pages". This is the only
  permission the module defines. It is not marked `restrict access`. Grant it to the roles that should reach
  the Convivial admin section; without it the route returns 403.

## Menu link (`convivial_core.links.menu.yml`)
- `convivial_core.admin_convivial` — title "Convivial CXP", `route_name` `convivial_core.admin_convivial`,
  `parent` `system.admin_config` (the core Configuration page), `weight` `-9`, description
  "Administer and configure your Convivial CXP." This places the section link near the top of `/admin/config`.

## How to operate / extend
- Grant `access convivial administration pages` to a Convivial administrator or site-builder role.
- Other Convivial modules attach their own config pages to this section by defining their routes/menu links
  with `parent: convivial_core.admin_convivial` (menu) so they appear on the `/admin/config/convivial` index.
- Because the page is core's `systemAdminMenuBlockPage`, it auto-lists whatever child admin links exist under
  it; Convivial Core itself renders no settings widgets.
- `data.json` `configure` is `null` — there is no settings-form route to point site UIs at.

## Not shipped
- No `*.services.yml`, `src/**`, `config/install/*`, or `config/schema/*`. `provides_config_schema` is false.
- `tests/` contains a helper submodule `convivial_core_test` (a Functional test plus a throwaway form/route);
  it is test infrastructure only and is not installed on production sites.
