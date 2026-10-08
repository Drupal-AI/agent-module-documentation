<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backstop Generator — generation services

Services declared in `backstop_generator.services.yml`. None of these shell out or fetch remote URLs; they
create Drupal config entities and, via the profile entity, write a local JSON file.

## scenario_generator — `Services\ScenarioGenerator`
Bulk-creates `backstop_scenario` config entities. Domains come from `backstop_generator.settings`
(`test_domain` / `reference_domain`). Public methods, each iterating enabled languages
(`language_list` + `default_language`):
- `scenariosFromHomepage($properties, $language_data)` — one homepage scenario per language.
- `scenariosFromMenus($properties, $language_data, $menu_data)` — walks each menu via
  `menu_node_data::getMenuLinkPaths($menu_id, $depth)`; ids cleaned by `cleanPath()`
  (`preg_replace('/[:?*<>"\'\/\\\\]/', '', basename($path))`).
- `scenariosFromContentTypes($properties, $language_data, $content_types_data)` — N random nodes per
  content type via `random_node_list::getRandomNodes($type, $quantity)`.
- `scenariosFromPaths($properties, $language_data, $paths)` — explicit paths; resolves aliases via
  `path_alias.manager`, extracts `node/(\d+)` for bundle, parses `Label | node/1` lines.
- `removeScenarios($profile_id)` — deletes all `backstop_generator.scenario.<profile_id>_*` config.

Private `createScenario($id, $label, $properties)` validates required keys, skips duplicates
(`scenarioExists()` = loadByProperties on profile_id+url), and saves the entity; failures are logged.

## viewport_generator — `Services\ViewportGenerator`
`createViewportsForTheme(string $theme_id): string|array` — reads the theme's breakpoint definitions
(`breakpoint.manager`) and creates `backstop_viewport` entities for them. Called from `hook_install()` for
the default theme and from `BackstopViewportThemeSelectorForm`.

## profile_regenerator — `Services\ProfileRegenerator`
`regenerateAffectedProfiles($entity_id, $config_key, $remove_reference = FALSE)` — finds every
`backstop_profile` whose `viewports` or `scenarios` list references `$entity_id`, optionally removes the
reference, then calls `BackstopProfile::generateBackstopFile()` to rewrite that profile's JSON. Used when a
viewport/scenario is edited or deleted so the on-disk `backstop.json` stays in sync.

## form_builder — `Services\BackstopFormBuilder`
Shared form-section builder used by `SettingsForm` and the profile forms: `buildUrlSection()`,
`buildProfileParametersSection()`, `buildScenarioDefaultsSection()`, plus `getFieldDescription()` /
`getFieldPlaceholder()` sourcing inline help (each field links to `/admin/help/backstop_generator#glossary-*`).

## Supporting services
- `menu_node_data` (`Services\MenuNodeData`) — `getMenuLinkPaths($menu_id, $level)` recurses the menu tree
  (`collectMenuPathsFromTree()`) returning path/title/bundle rows.
- `random_node_list` (`Services\RandomNodeList`) — `getRandomNodes($content_type_id, $quantity)`.
- `logger.channel.backstop_generator` — dedicated logger channel.
- `scenario_list_route_subscriber` (`ScenarioListRouteSubscriber`, `event_subscriber`) — sets
  `_access = FALSE` on `entity.backstop_scenario.add_form` so scenarios cannot be hand-created.

## Controller & hooks
`Controller\BackstopGeneratorController` (route `backstop_generator.commands`) lists profile JSON files in
the backstop directory (`getBackstopProfiles()` / `excludeFile()`) and prints escaped `cd` + `backstop
reference` / `backstop test` commands per profile (`Html::escape`). `scenarioAutocomplete()`
(route `backstop_generator.autocomplete`, JSON) searches node titles (`Xss::filter` on `q`, access-checked
entity query). `.module` implements `hook_help`, `hook_form_alter` (attaches the `backstop_forms` library),
and the `backstop_generator_process_scenario_values()` normaliser.
