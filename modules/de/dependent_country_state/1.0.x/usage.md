<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dependent Country, State and City

Provides a managed dataset of countries, states, cities and pincodes (in custom DB tables) with admin CRUD, bulk import, and JSON API endpoints for building dependent (cascading) location selects.

- Add/edit/delete countries, states, cities, and pincodes via admin forms.
- Bulk-import states, cities, and pincodes.
- Query the data through permission-gated JSON endpoints for dependent dropdowns.

---

## Installation & configuration

- Enable; the `.install` creates `dependent_country`, `dependent_state`, `dependent_city`, `dependent_pincode` tables and seeds defaults.
- Admin CRUD/list/import routes require `dependent country state administrator` (restricted).
- API endpoints require dedicated restricted permissions: `country api access`, `state api access`, `city api access`, `areapincode api access`.
- Grant API permissions only to the roles/services that need them.
- Manage data under the module's admin routes (country/state/city/pincode lists and add/delete forms).
- Config object: `dependent_country_state.settings`.

---

## Usage & behaviour / security

- API endpoints (e.g. `/admin/city-state-city/api/get-country`, `.../get-state/{id}`, `.../get-city/{id}`, `.../get-areapincode/{id}`) return JSON.
- Endpoints accept optional filters via query args (`id`, `country_name`, `state_name`, `city_name`, `pincode_area`).
- User-supplied filter values are applied through the Drupal DB API `->condition(...)` with placeholders (including LIKE patterns) — **no SQL injection**.
- All API routes are gated by their own restricted `* api access` permissions, so they are **not** anonymous by default.
- Results are filtered to `status = 1` rows.
- There is a cosmetic bug: table names in the API queries contain a stray double-quote (e.g. `dependent_country"`), a typo that is not user-controllable/injectable.
- Bulk import forms let admins load state/city/pincode data.
- No external HTTP calls, no SSRF.
- Use the JSON endpoints from JS to populate dependent selects on your own forms.
- The dependent-select behaviour is driven by these endpoints returning filtered child records.
- Controllers live under `src/Controller/` (APIController, CountryController, StateController, CityController, PincodeController).
- Forms for add/delete/bulk-import live under `src/Form/`.
- Data is stored outside the entity system in custom tables.
- Uninstall drops the four custom tables (see `.install`).
- Read: `src/Controller/APIController.php`, `dependent_country_state.routing.yml`, `dependent_country_state.permissions.yml`.
