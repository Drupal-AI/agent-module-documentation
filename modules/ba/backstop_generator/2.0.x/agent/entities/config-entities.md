<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backstop Generator — config entities & JSON generation

Three `ConfigEntityType`s, all with `admin_permission = administer backstop_generator`, config prefixes
`backstop_generator.profile.*` / `.scenario.*` / `.viewport.*`. Routes for their
collection/add/edit/delete forms live in `backstop_generator.routing.yml` and require
`_permission: administer site configuration`.

## backstop_profile — `Entity\BackstopProfile`
A test run. `config_export` includes label, description, `test_domain`, `reference_domain`, `viewports`
(viewport ids), `scenario_list` (scenario ids), `scenarioDefaults`, `engine`, `engineOptions`,
`asyncCaptureLimit`, `asyncCompareLimit`, `debug`, `debugWindow`, `report`, `paths`, scripts flags.
Form handler `Form\BackstopProfileForm` (add/edit), `BackstopProfileDeleteForm`. Storage
`Entity\BackstopProfileStorage`. An `express` form handler is declared but its submodule
(`backstop_generator_express`) is not shipped in this release.

Key method `generateBackstopFile()`:
1. Builds a `BackstopJsonTemplate` and `set()`s viewports, scenarioDefaults, scenarios, engine,
   engineOptions, async limits, debug flags, and optional on*Script filenames.
2. `getViewports()` / `getScenarios()` load referenced viewport/scenario entities and call each entity's
   `getJsonKeyValues()`; missing refs are logged and skipped.
3. `prepareBackstopDirectory()` resolves `dirname(DRUPAL_ROOT) . backstop_directory` and
   `FileSystemInterface::prepareDirectory(... CREATE_DIRECTORY | MODIFY_PERMISSIONS)`.
4. Writes `backstop.json` (if id is literally `backstop`) else `bsg_<id>.json` via `fopen/fwrite/fclose`;
   `getJson()` = `json_encode(..., JSON_PRETTY_PRINT|UNESCAPED_SLASHES|UNESCAPED_UNICODE|NUMERIC_CHECK)`.

`getScenarioDefaults()` runs the values through `backstop_generator_process_scenario_values()`.
`getEngineOptions()` splits the comma string into `{"args":[...]}`.

## backstop_scenario — `Entity\BackstopScenario` (implements `BackstopScenarioInterface`)
One page/URL state. Long `config_export`: `profile_id`, `useScenarioDefaults` (default TRUE), `url`,
`referenceUrl`, `bundle`, plus BackstopJS knobs (`delay`, `hideSelectors`, `removeSelectors`,
`keyPressSelectors`, `hoverSelector(s)`, `clickSelector(s)`, `postInteractionWait`, `scrollToSelector`,
`selectors`, `selectorExpansion`, `expect`, `misMatchThreshold`, `requireSameDimensions`, `readyEvent`,
`readySelector`, `readyTimeout`, `cookiePath`, `onBeforeScript`, `onReadyScript`, `viewports`,
`gotoParameters`).

`getJsonKeyValues()`: if `useScenarioDefaults` is TRUE it emits only `label`, `url`, `referenceUrl`
(inherits everything else from the profile); if FALSE it emits all non-meta keys through
`processScenarioValues()`. The scenario **add form route is disabled** by
`ScenarioListRouteSubscriber` (sets `_access = FALSE`) — scenarios are created only via the generator.

## backstop_viewport — `Entity\BackstopViewport` (implements `BackstopViewportInterface`)
A screen size. `config_export`: id, label, description, `height`, `width`. `getJsonKeyValues()` returns the
non-meta keys (i.e. `height`/`width`) filtered of empties. Forms: `BackstopViewportForm`,
`BackstopViewportDeleteForm`, plus `BackstopViewportThemeSelectorForm` for importing a theme's breakpoints.

## BackstopJsonTemplate (`src/BackstopJsonTemplate.php`)
A plain value object (public typed props) matching BackstopJS's schema; its constructor seeds default
`paths` (per-profile `html_report_<id>` / `ci_report_<id>`), `report=['browser']`,
`engineOptions.args=['--no-sandbox']`, async limits, debug flags. `set()/get()/json()` accessors.

## Value normalisation — `backstop_generator_process_scenario_values()` (`.module`)
Converts comma strings to arrays (selectors), integer flags to booleans
(`requireSameDimensions`, `selectorExpansion`), `keyPressSelectors`/`gotoParameters` `a|b` lines to
structured arrays (regex `^([A-Za-z0-9.#@\s-]+)\|([A-Za-z0-9.#@\s-]+)$`), and script flags to
`<engine>/<field>.js` filenames; empties are stripped with `array_filter`.
