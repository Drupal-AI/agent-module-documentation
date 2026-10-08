<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets a Webform look up people in an external Live Search directory service and autofill name, address, city, zip code and date-of-birth fields from a typed search string.

---

An admin configures the service endpoint URL and API key at `/admin/config/services/livesearch-person` (`administer livesearch`), and per-webform mappings at `/admin/structure/webform/manage/{webform}/settings/livesearch` (gated by `webform.update` entity access). JavaScript on the front end watches the configured search field and POSTs the query to the internal route `/livesearch-person/search-directory`, which calls `LiveSearchPersonService::getDirectory()`. That service sends a GET to `{livesearch_url}{search}` with the API key in an `X-API-Key` header, then flattens the returned person records (full name, first/middle/last name, address, city, postal code, birth date) into fields the JS maps onto the webform inputs.

Operationally the API key lives server-side in `livesearch_person.livesearchconfig` config and the external call runs over the configured HTTPS URL with Guzzle's default TLS verification. Note that the internal search route is gated only by the `access content` permission, which is granted to anonymous users on a default site: anyone able to reach the page can drive person lookups (returning names, addresses and dates of birth) through the site's stored API key, so restrict `access content` or place the feature behind an authenticated form if the directory data is sensitive.

---
- Configure the Live Search directory endpoint URL
- Store the directory API key server-side
- Toggle JavaScript debug output
- Test the API connection from the admin form
- Map webform fields to Live Search result properties per webform
- Autofill a full name field from a search
- Autofill first/middle/last name fields
- Autofill a street address field
- Autofill city and postal code fields
- Autofill a date-of-birth field
- Trigger lookups as the user types in the search field
- Build a person-directory-backed contact form
- Reduce manual data entry on intake forms
- Keep the directory API key out of client-side code
- Restrict lookups by tightening the access-content permission
- Show a loading indicator while the lookup runs
