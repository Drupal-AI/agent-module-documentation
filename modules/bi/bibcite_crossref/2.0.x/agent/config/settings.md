<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, routes, DOI lookup & import, HTTP client

## Install & enable

```bash
composer require drupal/bibcite_crossref
drush en bibcite_crossref -y
```

Requires **`bibcite`** and **`bibcite_entity`** (info.yml `dependencies`); composer pulls
`drupal/bibcite:^2.0|^3.0`. On install it ships two Bibcite mappings
(`bibcite_entity.mapping.crossref`, `.crossref_doi`); `hook_uninstall` deletes both.

## Configuration

- Config object **`bibcite_crossref.settings`**, one key **`bibcite_crossref_mailto`** (type
  `email`; schema `config/schema/bibcite_crossref.settings.schema.yml`).
- Edited at **`/admin/config/bibcite/crossref`** (`SettingsForm`, form id
  `bibcite_crossref_settings`). The email is passed to Crossref as `mailto` on every request,
  which places calls in Crossref's *polite pool* (higher rate limit) and lets Crossref contact you.
- `bibcite_crossref_requirements()` (runtime) raises a `REQUIREMENT_WARNING` on the status report
  when no mailto is set — recommendation only, the module still works without it.

```bash
drush cset bibcite_crossref.settings bibcite_crossref_mailto you@example.com -y
```

## Routes & permissions

Both routes in `bibcite_crossref.routing.yml` require **`_permission: administer bibcite`** (no
custom permission is defined by this module):

| Route | Path | Form |
|---|---|---|
| `bibcite_crossref.settings` | `/admin/config/bibcite/crossref` | `SettingsForm` |
| `bibcite_crossref.lookup` | `/admin/content/bibcite/reference/lookup` | `DoiLookupForm` |

`bibcite_crossref.lookup` appears as a **"DOI lookup"** action link on the reference collection
(`links.action.yml`); the settings page appears as a task/menu link under Bibcite settings.

## Single-DOI lookup (`DoiLookupForm`)

`src/Form/DoiLookupForm.php` (form id `bibcite_crossref_doi_lookup`):

1. One required `doi` textfield (maxlength 255).
2. `validateForm()` calls `crossrefClient->lookupDoiRaw($doi)`, then
   `serializer->decode($raw, 'crossref')` and `denormalize(..., Reference::class, 'crossref')`.
   If `bibcite_import` is enabled, the denormalize context carries that module's
   `contributor_deduplication` / `keyword_deduplication` settings. Any exception is caught and
   surfaced as a form error on the `doi` field.
3. `submitForm()` stores the built `Reference` entity in **private tempstore**
   (`bibcite_entity_doi_lookup`, keyed by current user id) and redirects to
   `entity.bibcite_reference.add_form` for that bundle.
4. `hook_bibcite_reference_prepare_form()` (in `bibcite_crossref.module`) then copies each field
   value from the tempstore entity onto the add form and **deletes** the tempstore entry.

## Batch import (format `crossref_doi`)

The `crossref_doi` format (see [../api/serialization.md](../api/serialization.md)) is a Bibcite
import format: paste a newline-separated list of DOIs into Bibcite's import UI and each is fetched
from Crossref and mapped to a reference. Per-DOI failures are carried through the batch and
reported, not silently dropped.

## HTTP client (`CrossrefClient`)

`src/CrossrefClient.php`, service **`bibcite_crossref.client`** (args `@http_client`,
`@config.factory`), implements `CrossrefClientInterface`:

- `const BASE_URL = 'https://api.crossref.org/';` — fixed HTTPS base. `lookupDoi($doi)` /
  `lookupDoiRaw($doi)` call `request("works/{$doi}")`; `lookupDoi` json-decodes, `lookupDoiRaw`
  returns the raw body.
- `request()` reads `bibcite_crossref_mailto`, adds it as a `mailto` query param when set, then
  `$this->httpClient->request('GET', BASE_URL . $path, ['query' => $parameters])` over Drupal's
  standard Guzzle client (normal TLS certificate verification).
- **Throttling**: `throttle()` spaces consecutive requests with `usleep()` to stay under the
  ceiling — `RATE_LIMIT_ANONYMOUS = 5` req/s, or `RATE_LIMIT_POLITE = 10` req/s when a mailto is
  configured. State is the in-memory `$lastRequestTime` (per request lifecycle).
