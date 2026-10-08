<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backstop Generator (backstop_generator) — agent index

Admin UI that generates BackstopJS visual-regression config files (`backstop.json` / `bsg_<id>.json`) from
your site's URLs, menus, content types, and theme breakpoints. It does NOT run BackstopJS itself — it writes
the JSON and prints the terminal commands you run. Version 2.0.2, core `^10 || ^11`, package Development.

**Dependencies:** core `breakpoint`, `node`, `path_alias`. No Composer libraries. `drupal/key`? no.

**Config entity types (3):**
- `backstop_profile` — a test run: viewports + scenarios + engine/parallelism. Class `Entity\BackstopProfile`;
  `generateBackstopFile()` writes the JSON file. `admin_permission: administer backstop_generator`.
- `backstop_scenario` — one page/URL state to screenshot (delay, selectors, ready events, cookiePath, …).
  Class `Entity\BackstopScenario`. Add form is disabled (route subscriber) — scenarios are bulk-generated.
- `backstop_viewport` — a screen size (width/height). Class `Entity\BackstopViewport`.

**Services:** `scenario_generator` (bulk-create scenarios), `viewport_generator` (viewports from theme
breakpoints), `profile_regenerator` (rewrite JSON of affected profiles), `form_builder` (shared form
sections), `menu_node_data`, `random_node_list`, `logger.channel.backstop_generator`, and the
`scenario_list_route_subscriber` event subscriber.

**Simple config:** `backstop_generator.settings` (+ `.settings.defaults`) — directory, test/reference
domains, `profile_parameters`, `scenarioDefaults`. Schema in `config/schema/*`.

**Routes (all `_permission: administer site configuration`):** settings form
`backstop_generator.settings_form` (`/admin/config/development/backstop-generator`); entity collections/
add/edit/delete for profile, scenario, viewport under the same base path; a JSON autocomplete
(`backstop_generator.autocomplete`); a Commands page (`backstop_generator.commands`). No permissions.yml
route uses anything weaker than site-config admin.

**Permission:** `administer backstop_generator` (restrict access: true) — the entity admin permission.

**Provides:** permissions=yes, config schema=yes, drush=no, plugin types=no, submodules=none shipped (an
"express" form handler is referenced but its submodule is not present in this release).

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config objects, schema, domains, directory.
- [entities/config-entities.md](entities/config-entities.md) — the 3 config entities + JSON generation.
- [services/generation.md](services/generation.md) — scenario/viewport/profile generation services + hook.
