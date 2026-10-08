<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - Crossref (bibcite_crossref) — agent index

Adds **DOI lookup and bulk DOI import** to Bibcite, fetching reference metadata from the
**Crossref REST API** (`https://api.crossref.org/`) and mapping it onto `bibcite_reference` entities.
Package *Bibliography & Citation - Formats*. Depends on **`bibcite`** and **`bibcite_entity`**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0-beta1. Everything is gated behind
the **`administer bibcite`** permission (no permissions of its own).

- **Config, routes, the lookup form and batch import, HTTP client** →
  [config/settings.md](config/settings.md)
- **Serialization pipeline: encoders + normalizers + field/type mappings** →
  [api/serialization.md](api/serialization.md)

## What it provides (from source)

- **Two routes** (`bibcite_crossref.routing.yml`, both `_permission: administer bibcite`):
  - `bibcite_crossref.settings` — `/admin/config/bibcite/crossref`, `SettingsForm` (the module's
    `configure` link).
  - `bibcite_crossref.lookup` — `/admin/content/bibcite/reference/lookup`, `DoiLookupForm`
    (single-DOI populate; an action link on the reference collection).
- **HTTP client** service `bibcite_crossref.client` → `CrossrefClient` (`@http_client`,
  `@config.factory`). `lookupDoi()` / `lookupDoiRaw()` GET `works/{doi}` off a fixed
  `https://api.crossref.org/` base, append `mailto` when configured, and self-throttle.
- **Two serialization formats** (declared in `bibcite_crossref.bibcite_format.yml`):
  `crossref` (JSON, single record) and `crossref_doi` (a newline-separated DOI list for import).
- **Encoders**: `CrossrefEncoder` (decodes one Crossref JSON `message` into a flat mapped array;
  strips JATS from abstracts) and `CrossrefDoiEncoder` (fetches each DOI in a list via the client).
- **Normalizers** (priority 5): `CrossrefReferenceNormalizer`, `CrossrefContributorNormalizer`.
- **Event subscriber** `CrossrefSubscriber` — registers the `crossref` request content type
  (`application/x-crossref-refer`).
- **Config**: object `bibcite_crossref.settings` (`bibcite_crossref_mailto`, schema
  `config/schema/bibcite_crossref.settings.schema.yml`) plus two install mappings
  `bibcite_entity.mapping.crossref` and `.crossref_doi`.
- **Hook**: `hook_bibcite_reference_prepare_form` in `.module` copies the DOI-populated entity out
  of private tempstore (`bibcite_entity_doi_lookup`) onto the reference add form, then deletes it.
- `hook_requirements` warns when no contact email is set; `hook_uninstall` deletes the two
  mappings; `update_10001` installs the `crossref_doi` mapping if missing.

## Notes

- No permissions, no Drush, no plugin types of its own. Outbound HTTPS calls to Crossref go over
  Drupal's `http_client` (standard TLS verification). The fetched URL host is the fixed Crossref
  base; the DOI is only appended to the path.
