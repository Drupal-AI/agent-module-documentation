<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Service Manager — endpoints, mappings and import

## Create an endpoint — `/admin/config/services/wsm/add`
Set: **base URL**, **method** (GET/POST), **response type** (json/xml), optional **parent element** (a wrapper key to unwrap before mapping), **save into entity** and/or **save into file**, target **entity type/bundle**, **update existing** / **delete existing** / **ignore empty** flags, and multilingual options.

## Headers & params
Under an endpoint, manage **Headers** (`.../headers`) and **Params** (`.../params`) — each a label + value. Values may contain `[LANG]`, replaced with the current langcode at call time. API tokens/keys go here.

## Field mappings — `.../field_mappings`
Each mapping: **source field** (a `/`-delimited path into the decoded response; `*` iterates a list), **destination field**, and flags: **is id field** (unique match key), **is value field** (use the literal source string, not a lookup), **to-lower**, **reference by distant id** (+ original-id field, for taxonomy_term refs), **required** (empty → skip that language/item), **use on delete**. Field-type conversions are automatic: `datetime` → `Y-m-d\TH:i:s`, `image` → downloaded to `public://wsm/images/`, `entity_reference` → resolved, `created` → unix timestamp.

## Running imports
- **Cron:** `CronTasks::endpointsCall()` calls every endpoint with save-to-entity or save-to-file enabled.
- **On render:** add an entity-reference field pointing at endpoint entities and set its formatter to **WebService Endpoint** (`wsm_endpoint`); viewing the host node calls the API live and themes the result via `endpoint_reference_formatter`.
- **Delete sync:** with *delete existing* on, entities whose id is not in the latest result set are removed (query uses `accessCheck(FALSE)`).

## Multilingual
- **response_data mode:** put `[LANG]` in a source path (e.g. `name/[LANG]`); one response, resolved per active language into translations.
- **url_param mode:** put `[LANG]` in the URL; one HTTP call per language, merged by the unique id into base entity + translations.
