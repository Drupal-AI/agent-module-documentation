<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# USAJobs — API client & configuration

## Config: `usajobs.settings`
| Key | Meaning |
|---|---|
| `user_agent` | Sent as `User-Agent` header (USAJOBS requires a registered email) |
| `authorization_key` | Sent as `Authorization-Key` header |
| `organization_id` | Agency code filter for the search query |
| `results_per_page` | Page size (default 10) |
| `sort_field` | e.g. `closedate` |
| `no_results_message` | Shown when the API returns nothing |
| `sub_agency_name` | Optional sub-agency label |
| `field.field_data_source.*` | Which USAJOBS fields to surface |

## Service `usajobs.api_client` (`UsaJobsApiClient`)
- `getJobs()` → `requestJobs()` → `GET {HOST}{SEARCH_ENDPOINT}` with query `{Organization, ResultsPerPage, SortField}` and headers `User-Agent` + `Authorization-Key`.
- `getAgencyList()` → `requestAgencyList()` → `GET {HOST}{AGENCY_SUBELEMENTS}` (no auth headers).
- Host and endpoint paths are class constants — not request-controlled.
- Non-2xx / RequestException (401, 404, other) are logged to the `usajobs` channel; returns FALSE.

## Autocomplete
`UsaJobsAutocompleteController::handleOrganizationAutocomplete` (route `usajobs.organization_autocomplete`, permission `administer usajobs`) filters the agency list by `?q=` and returns up to 10 `{value,label}` suggestions of enabled agencies.

## Rendering
`UsaJobsListingBuilder` maps API results into the `UsaJobsBlock` render array using the `field_data_source` selection. The `usajobs_paragraphs` submodule exposes the listing as a paragraph type.

## Setup
Register at the USAJOBS Developer site for an API key, enter `user_agent` (your registered email) and `authorization_key`, pick an organization via autocomplete, then place the **USAJobs** block.
