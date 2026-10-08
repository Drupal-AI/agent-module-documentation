<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Remote Fields provides custom webform elements whose options and values are populated from an endpoint through REST services.

---

Webform Remote Fields provides custom webform elements whose options/values are fetched from a remote
REST endpoint — so a select/autocomplete's choices come from an external API (e.g. a live list of products,
locations or reference data) rather than a static list. It ships example and API-test-helper submodules,
provides its own permissions, in the Webform package.

Use it for webform fields backed by live remote data. Security/operational notes: the endpoint URL is
**admin-configured** (in the field/module settings), and the module fetches it **server-side** with
configurable timeouts, response caching and an optional "follow HTTP redirects" setting. Because an admin
sets the endpoint, this is not anonymous SSRF — but keep the endpoint pointed at **trusted** hosts (a
malicious/compromised endpoint, or the follow-redirects option, could reach unexpected/internal hosts), and
treat the fetched option values as untrusted data (escape on display). It has no access-control role.
Configure the endpoint and elements.

---

- Populate webform options from a REST endpoint.
- Fetch field choices from an external API.
- Back selects/autocompletes with live data.
- Ship example/api-test submodules.
- Provide its own permissions.
- Fetch the endpoint server-side.
- Configure timeouts and response caching.
- Keep the endpoint pointed at trusted hosts.
- Be cautious with the follow-redirects option (SSRF).
- Treat fetched values as untrusted (escape).
- Have no access-control role.
- Configure the endpoint and elements.
- Use live remote options.
- Handle remote fields.
- Configure remote data.
- Fetch option data.
- Populate from REST.
- Handle external options.
- Configure the fields.
- Fetch remote options.
