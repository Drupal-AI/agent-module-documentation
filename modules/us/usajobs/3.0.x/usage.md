<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
USAJobs pulls current job opportunities for a chosen federal/state agency from the USAJOBS.gov Search API and renders them in a configurable Drupal block.
---
An administrator enters the USAJOBS API credentials (User-Agent and Authorization-Key), the target organization and result options on the settings form; an organization autocomplete helps pick the agency by name/code from the API's agency sub-element list. The `UsaJobsApiClient` service then queries the USAJOBS host over HTTPS (`GET` search and agency-list endpoints, endpoint URLs are fixed constants), and `UsaJobsListingBuilder` maps the selected data-source fields (position title, URI, dates, location, salary range) into the block's render array. The optional `usajobs_paragraphs` submodule adds a "USAJobs" paragraph type so the listing can be embedded in paragraph-based layouts.

Security-wise the module is admin-scoped. Both routes — the config form and the organization autocomplete — require the `administer usajobs` permission (declared with `restrict access: true`), and the endpoint hosts are hardcoded constants, so there is no user-supplied URL / SSRF surface and no anonymous proxy. The API `authorization_key` is saved in `usajobs.settings`; requests are made over HTTPS via Guzzle with default certificate verification (TLS is not disabled). Typical setup: obtain a USAJOBS API key, fill in the settings form, select an organization, then place the USAJobs block.
---
- Enter USAJOBS API User-Agent and Authorization-Key on the settings form.
- Select the target agency via organization autocomplete.
- Configure how many results per page the block shows.
- Choose the sort field (e.g. close date) for listings.
- Set a custom "no results" message.
- Restrict listing to a sub-agency by name.
- Place the USAJobs block to display openings on any page.
- Choose which USAJOBS fields (title, URI, dates, location, salary) to display.
- Show position start and end dates for each opening.
- Show salary min/max range for each opening.
- Link each listing to its USAJOBS position URI.
- Embed job listings via the `usajobs_paragraphs` paragraph type.
- Query the USAJOBS agency sub-element list for organization codes.
- Limit configuration access to users with `administer usajobs`.
- Log API connection failures (401/404/other) to the usajobs channel.
- Refresh openings automatically on each block render from the live API.