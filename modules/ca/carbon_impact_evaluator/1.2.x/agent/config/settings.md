<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install / enable
`drush en carbon_impact_evaluator`. Installing runs `hook_schema` (`carbon_impact_evaluator.install`) which creates the `co2_info` table. No module dependencies to satisfy. Uninstall drops `co2_info`.

## Settings form
Class `SettingsForm` (`src/Form/SettingsForm.php`), a `ConfigFormBase`; form id `carbon_impact_evaluator_settings`. Route `carbon_impact_evaluator.settings` at `/admin/config/system/carbon-impact-evaluator/settings`, permission `administer site configuration`. Also linked from the config Web-services group (`carbon_impact_evaluator.links.menu.yml`).

Editable config object: **`carbon_impact_evaluator.settings`**. Keys:

| Key | Type | Meaning |
|-----|------|---------|
| `per_byte` | checkbox (0/1) | Enable the OneByte model ("Per Byte"). |
| `per_visit` | checkbox (0/1) | Enable the Sustainable Web Design model ("Per Visit"). |
| `greenhost` | checkbox (0/1) | Whether the site is on a green host (passed to CO2.js). |
| `dataCenter` | textfield | ISO alpha-3 country code of the datacenter; used only when `per_visit` is on. |

`submitForm()` saves exactly these four keys (from `$form_state->get('array_fields')`).

### Validation
`validateForm()` runs only when `per_visit == 1`: it requires `dataCenter` to match `/^[A-Z]{3}$/` and to be present in the bundled list. `getCountriesCodes()` reads `data/countries-codes.json` via `file_get_contents($module_path . '/data/countries-codes.json')` (a **local** file — not a remote URL) and checks the code against each entry's `Alpha-3 code`. The `dataCenter` field is shown/required in the UI (via `#states`) only while Per Visit is checked.

### Config schema caveat
`config/schema/carbon_impact_evaluator.schema.yml` is a leftover stub — it declares a single `example` string and does NOT describe the real keys (`per_byte`, `per_visit`, `greenhost`, `dataCenter`). Config export/validation of these keys is effectively unschema'd. There is no `config/install/` default, so the object starts empty until the form is saved.

## Block placement (required for anything to render)
The calculation UI appears only where the **Carbon impact evaluation block** is placed. Add it via Structure > Block layout (region of choice). Per the project README, restrict it so it is hidden on `/carbon-impact-evaluator/table` (the admin summary page) to avoid computing on the report itself. The badge only ever computes on node pages (see `hook_preprocess_page`, which skips paths containing `admin` or `carbon-impact-evaluator`).

## Runtime settings exposed to the front end
`carbon_impact_evaluator_preprocess_page()` (`.module`) runs on pages with a `node` attribute and, for non-admin/non-module paths, attaches to `drupalSettings`: `nid`, `per_visit`, `per_byte`, `Greenhost` (from `getGreenHost()`, mapping config `greenhost` 0/1 to FALSE/TRUE), and — when Per Visit is on — `Datacenter_country`. It also calls `saveInDatabase()` to upsert the node's visit row.
