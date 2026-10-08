<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring livesearch_person

1. **Service credentials** — `/admin/config/services/livesearch-person` (`administer livesearch`): set `livesearch_url` (e.g. `https://search.datafactory.online/person/`) and `livesearch_apikey`. Optional "Debug javascript" flag. A "Test Connection" tab lives at `/admin/config/services/livesearch-person/test`.
2. **Per-webform mapping** — `/admin/structure/webform/manage/{webform}/settings/livesearch` (requires `webform.update` on that webform): pick the search field and map result properties (`fullname`, `firstname`, `lastname`, `final_address`, `date_birth`, `zipcode`, `city`) onto webform elements. Mappings are passed to `drupalSettings` and consumed by `js/livesearch_person.webapijs.js`.

## Runtime flow
The front-end JS POSTs `string` to `/livesearch-person/search-directory`. `LiveSearchPersonController::searchDirectory()` calls `LiveSearchPersonService::getDirectory($string)`, which does `GET {livesearch_url}{string}` with header `X-API-Key: {apikey}`, decodes the JSON, and normalises each record before returning it as JSON to the browser.

## Access note
The search route requires only `access content`. On a default site that includes anonymous users, so the lookup (and the PII it returns) is reachable by anyone who can load the form. Restrict `access content`, or front the search with an authenticated route, when the directory data is sensitive.
