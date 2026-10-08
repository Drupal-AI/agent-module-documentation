<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - PubMed (bibcite_pubmed) — agent index

PubMed/NCBI import and lookup for the Bibliography & Citation (bibcite) suite. Registers two
serializer formats and an admin lookup form that turns a PubMed ID into a `bibcite_entity`
Reference. Version dir **2.x** (installed 2.0.0-beta1). No own settings page; no permissions of
its own; not covered by a security advisory policy.

## Dependencies
- `bibcite:bibcite`, `bibcite:bibcite_entity` (Drupal modules).
- PHP `ext-simplexml`; composer `drupal/bibcite ^1|^2|^3`.
- Optional: `bibcite_import` (used only to read contributor/keyword deduplication settings).
- Core `^10 || ^11`.

## What it provides
- **Service** `bibcite_pubmed.client` (`PubmedClient`, iface `PubmedClientInterface`) — `fetch($pmid)`
  GETs NCBI efetch XML over HTTPS. Constructor arg `@http_client` (Guzzle).
- **Encoders** (serializer `encoder` tags): `PubmedEncoder` (format `pubmed`, parses efetch XML to
  article-value arrays) and `PubmedIdEncoder` (format `pubmed_id`, decodes newline-separated PMIDs by
  calling the client in chunks of 50; also encodes value arrays back to a PMID list).
- **Normalizer** `PubmedReferenceNormalizer` (priority 5, formats `pubmed`/`pubmed_id`) — extends
  `ReferenceNormalizerBase`; denormalizes into a Reference entity, mapping author categories.
- **Event subscriber** `PubmedSubscriber` — registers the `application/x-pubmed-refer` request format.
- **Route** `bibcite_pubmed.lookup` → `/admin/content/bibcite/reference/pmlookup`, form
  `PubmedLookupForm`, permission `administer bibcite`. Exposed as an action link + menu link on the
  reference collection.
- **Hook** `hook_bibcite_reference_prepare_form` in `.module` — copies the tempstore-staged entity
  onto the reference add form, then clears the tempstore.
- **Config** `bibcite_entity.mapping.pubmed` (+ `.pubmed_id`) — type and field mapping, installed via
  `config/install/`; `bibcite_pubmed.bibcite_format.yml` declares the `pubmed`/`pubmed_id` formats.
  `hook_uninstall` deletes the mapping; `update_9001` added the PMCID→bibcite_pmcid field.

## Solution docs
- [agent/api/pubmed-client.md](api/pubmed-client.md) — the client service, efetch call, and formats.
- [agent/import/lookup-and-mapping.md](import/lookup-and-mapping.md) — lookup form, import flow,
  route/permission, and the field/type mapping config.
