<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# USAJobs (usajobs) — agent index
**Block that lists a federal/state agency's current openings by querying the USAJOBS.gov Search API.**

- **Version:** 3.0.x (release 3.0.4)
- **Core:** ^10 || ^11
- **Dependencies:** block. Submodule: `usajobs_paragraphs` (adds a USAJobs paragraph type; requires paragraphs).
- **Permission:** `administer usajobs` (`restrict access: true`).
- **Routes:** `usajobs.usajobs_config_form` → `admin/config/services/usajobs`; `usajobs.organization_autocomplete` → `.../organization-autocomplete`. Both gated by `administer usajobs`, both `_admin_route`.
- **Services:** `usajobs.api_client` (`UsaJobsApiClient`), `usajobs.listing_builder`. Block plugin `UsaJobsBlock`.
- **Security:** all routes admin-gated by `administer usajobs`; endpoint hosts are hardcoded constants (no user-supplied URL, no SSRF, no anonymous proxy). Calls use Guzzle over HTTPS with default TLS verification (not disabled). The API `authorization_key` is saved in `usajobs.settings`.

See [api/client.md](api/client.md)
