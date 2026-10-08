<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete endpoint

`GET /autocomplete/organization_field?q=<text>` → JSON `[ {value,label}, ... ]`.

- Route requirement is **`_access: 'TRUE'`** — reachable anonymously (`organization_field.routing.yml`).
- Controller: `JsonApiController::handleAutocomplete` (`src/Controller/JsonApiController.php`). It `Xss::filter()`s `q`, then GETs the ROR API URL from config key `ror_api` with `query[query]=q`, and maps items whose name type is `ror_display` to results, capped by `ror_items_depth`.
- The outbound URL comes from admin config, not from the request.
