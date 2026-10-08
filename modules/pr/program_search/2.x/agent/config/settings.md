<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin settings — `openy_programs_search.settings`

Form `src/Form/SettingsForm.php` (`ConfigFormBase`, form id `openy_programs_search_admin_settings`).
Route `openy_programs_search.settings` → `/admin/openy/integrations/daxko/programs-search`,
permission **`administer programs search`** (`openy_programs_search.permissions.yml`). Menu link
`openy_programs_search.admin` sits under `openy_system.openy_integrations_daxko` (weight 120).
Editable config object: **`openy_programs_search.settings`** (install defaults in
`config/install/openy_programs_search.settings.yml`; no config schema file ships).

## Config keys

| Key | Type | Install default | Used by |
|-----|------|-----------------|---------|
| `client_id` | string | `''` | token `{{ client_id }}` in every path template |
| `domain` | string | `daxko.com` | cookie domain in `getDaxkoPageSource()` |
| `base_url` | url | `https://operations.daxko.com` | prefix for all built URLs |
| `registration_path` | string | `/Online/{{ client_id }}/Programs/Search.mvc/details` | `getRegistrationLink()` (adult) |
| `get_schools_by_program_path` | string | `/Online/{{ client_id }}/Programs/ChildCareSearch.mvc/locations_by_program?program_id={{ program_id }}` | `scrapeDaxkoSchoolsByProgram()` |
| `get_categories_path` | string | `/Online/{{ client_id }}/Programs/search.mvc/categories` | `getCategories()` |
| `get_map_categories_by_branch_path` | string | `/Online/{{ client_id }}/Programs/search.mvc/categories?branch_id={{ branch_id }}` | `getMapCategoriesByBranch()` |
| `default_locations` | array | `[]` | block default `enabled_locations` |
| `exclude_location_map` | array of node IDs | (unset) | `getExcludeLocationMapIds()` — branches to skip in the childcare location map |
| `name_string_replace_location_map` | array of `{find, replace}` | (unset) | `getDaxkoLocationMap()` — branch-name cleanup |
| `pinned_programs` | array of program-name strings | (unset) | `getLocationsByChildCareProgramId()` — ranking boost, order = weight |

Note: `pinned_programs` is read by `DataStorage` but has **no `default_locations`-style default** in
the install file (only the seven connection keys + `default_locations: []` ship).

## Form behavior

- Plain textfields for `client_id`, `domain`, `registration_path`,
  `get_schools_by_program_path`, `get_categories_path`, `get_map_categories_by_branch_path`; a
  `#type=url` field for `base_url`. Note the childcare registration link is **not** admin-editable
  here — `getChildCareRegistrationLink()` uses the scraped `registration_url` from rate options.
- Three AJAX "add one more / remove one" fieldsets manage the multi-value arrays:
  `exclude_location_map` (numeric node IDs, `#min 1`), `name_string_replace_location_map`
  (find/replace pairs), and `pinned_programs` (names). Each has its own
  `addOne…` / `remove…Callback` / `addmore…Callback` handlers and a `num_*` counter in form state.
- `submitForm()` saves each key; for `base_url` it prepends `https://` when the value has no
  `https?://` scheme (`preg_match("#https?://#", …)`). The array fieldsets are `array_filter`ed
  (drop empties), re-keyed with `array_values`, and — for `exclude_location_map` — `asort()`ed;
  `name_string_replace_location_map` and `pinned_programs` keep submitted order (order is
  meaningful for replacement sequence / ranking weight).
- `$form_state->setCached(FALSE)` and `#tree = TRUE` are set in `buildForm()`.

## Operating notes

- After changing connection settings, clear/warm caches so the block picks up new Daxko data:
  `\Drupal::service("openy_programs_search.data_storage")->resetCache();` then `->warmCache();`
  (or wait for the 12-hour `openy_cron_service` run, which resets then warms).
- All outbound requests target the admin-configured `base_url`; there is no visitor-supplied URL.
