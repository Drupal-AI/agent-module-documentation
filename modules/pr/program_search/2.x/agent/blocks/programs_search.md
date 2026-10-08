<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programs Search block, form & DataStorage service

Files: `src/Plugin/Block/ProgramsSearchBlock.php`, `src/Form/ProgramsSearchBlockForm.php`,
`src/DataStorage.php`, `openy_programs_search.services.yml`.

## Enable / place

1. `drush en openy_programs_search` (pulls in `daxko` + `openy_socrates`).
2. Configure Daxko connection at `/admin/openy/integrations/daxko/programs-search` (see
   [../config/settings.md](../config/settings.md)) — nothing works until `client_id` / `base_url`
   are set.
3. Place the **Programs Search Block** (`programs_search_block`, category *Forms*) in a region /
   Layout Builder. In the block config choose **Enabled locations** and **Enabled categories**
   (checkboxes populated live from Daxko); leaving them empty means "all".

## Block: `ProgramsSearchBlock`

- `@Block(id="programs_search_block", admin_label="Programs Search Block", category="Forms")`.
- DI (`create()`): `openy_programs_search.data_storage`, `config.factory`,
  `logger.factory→openy_programs_search`, `messenger`.
- `build()` renders the form via `\Drupal::formBuilder()->getForm(ProgramsSearchBlockForm::class, $conf)`
  passing the block config (an `@todo` notes it should use the injected builder).
- `blockForm()` builds two `details` groups — `locations_config[enabled_locations]` and
  `categories_config[enabled_categories]` — options from `storage->getLocations()` /
  `storage->getCategories()`. Each call is wrapped in try/catch: on failure it logs and shows
  "Сan't fetch Daxco data, please re-check your settings" with a link to the settings route.
  Location default falls back to config `default_locations`.
- `blockSubmit()` bails unless `$form['provider']['#value'] === 'openy_programs_search'`, then
  `array_flip()`s the checked ids into `configuration['enabled_locations']` /
  `['enabled_categories']` (dropping key `0`).

## Form: `ProgramsSearchBlockForm` (`programs_search_block_form`)

- DI: `renderer`, `openy_programs_search.data_storage`. `submitForm()` is empty (`@todo`) — the
  "result" is a link render element, not a POST submit.
- `buildForm($form, $form_state, $configuration=[])` reads `enabled_locations` /
  `enabled_categories` from the block config into `$this->locations` / `$this->categories`, then a
  `type` radios (`child` = Child Care, `adult` = Programs). Whole form is wrapped in
  `#programs-search-form-wrapper`; every select uses `getAjaxDefaults()` (event `change`, replace
  the wrapper, throbber) so each choice rebuilds the next step.
- **Step engine**: a `step` form value (1..6) advanced by inspecting
  `getTriggeringElement()['#name']`; `clearForm()` unsets downstream values/user-input when an
  upstream choice changes.
- **Child flow** (`getChildForm`): step2 `location` (from `getLocations()`, filtered by
  `filterLocations()` against enabled ids) → step3 `school` (`getSchoolsByLocation`) → step4
  `program` (`getChildCareProgramsBySchool`) → step5 `rate` (`getChildCareProgramRateOptions`,
  labelled `"name (context_id)"`) → step6 registration link via
  `getChildCareRegistrationLink(school, program, rate)`.
- **Adult flow** (`getAdultForm`): step2 `location` → step3 `category`
  (`getCategoriesByBranch`, filtered by `filterCategories()`) → step4 `program`
  (`getProgramsByBranchAndCategory`) → step5 `session` (`getSessionsByProgramAndLocation`) →
  step6 registration link via `getRegistrationLink(program, session)`.
- Empty steps render `noResults()` ("Sorry, nothing has been found."). Final link:
  `Url::fromUri($uri)` + `Link::fromTextAndUrl()` placed in a `%link` placeholder inside a
  `result`-classed `div`.

## Service: `DataStorage` (`openy_programs_search.data_storage`)

Constructor args (services.yml): `@daxko.client`, `@openy_programs_search.cache`, `@http_client`,
`@openy_programs_search.crawler` (a `Symfony\Component\DomCrawler\Crawler`), `@config.factory`.
Tagged `openy_cron_service` periodicity `43200`.

Cache: dedicated `openy_programs_search` bin (`cache_factory:get`). Nearly every public getter is
memoized under `cid = __METHOD__ [. args]`; `getProgramsByBranchAndCategory` also `md5()`s the
category. `resetCache()` = `cache->deleteAll()`; `warmCache()` primes childcare programs, rate
options, school→program ids and location→program maps. `runCronServices()` = reset + warm.

Daxko access, two mechanisms:
- **API client** (`daxko.client`): `getBranches(['limit'=>100])`, `getPrograms(['branch'=>id])`,
  `getSessions([...])`, `getChildCarePrograms()`.
- **HTML scraping** (`getDaxkoPageSource($url)`): Guzzle `GET` with `allow_redirects=false`; parses
  the first response's `Set-Cookie` headers into a `GuzzleHttp\Cookie\CookieJar` (domain from the
  `domain` config, default `.daxko.com`), re-requests with those cookies, returns the body. The
  `Crawler` then `filter()`s: schools = `div.two-column-container ul li a`
  (`scrapeDaxkoSchoolsByProgram`), rate rows = `#session-list-table tr.childcare-rate`
  (`getMapRateOptions`), categories = same two-column list (`scrapeCategoryList`). Query params
  (`location_id`, `context_id`, `category_ids`) are pulled with `getQueryParam()` (`parse_url` +
  `parse_str`).
- **URL building** (`getUrlFromOpenyProgramsSearchSettings`): `base_url` + `strtr()` of the path
  template, replacing `{{ client_id }}` / `{{ program_id }}` / `{{ branch_id }}`. Registration
  links use `Url::fromUri(..., ['query'=>..., 'absolute'=>TRUE, 'https'=>TRUE])`.

Childcare branch mapping (`getLocationsByChildCareProgramId`) is heuristic: it strips branch names
(`getDaxkoLocationMap`, honoring `exclude_location_map` and `name_string_replace_location_map`),
stems them (`customLocationStem`), then ranks each program name against branch tokens, boosting
matches whose name contains a configured `pinned_programs` entry (earlier = heavier).
