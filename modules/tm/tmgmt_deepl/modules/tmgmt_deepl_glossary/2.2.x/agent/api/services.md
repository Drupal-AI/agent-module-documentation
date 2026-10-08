<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL glossary API services

The submodule wraps DeepL's glossary REST endpoints. These calls require the parent module's
DeepL auth key (from the `tmgmt_translator` provider).

## Services (`tmgmt_deepl_glossary.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `tmgmt_deepl_glossary.api` | `DeeplGlossaryApi` | Classic (single-pair) glossary API: create / list / show / delete glossaries and entries on DeepL. |
| `tmgmt_deepl_glossary.ml.api` | `DeeplMultilingualGlossaryApi` | Multilingual glossary API (glossaries with multiple dictionaries). |
| `tmgmt_deepl_glossary.api_batch` | `DeeplGlossaryApiBatch` | Batch helpers for bulk classic-glossary operations. |
| `tmgmt_deepl_glossary.ml.api_batch` | `DeeplMultilingualGlossaryApiBatch` | Batch helpers for multilingual glossaries. |
| `tmgmt_deepl_glossary.ml.route_subscriber` | `EventSubscriber\DeeplMultilingualGlossaryRouteSubscriber` | Adjusts multilingual-glossary routes. |

Each API service is constructed with `entity_type.manager`, `http_client`, and `messenger`
(interfaces `DeeplGlossaryApiInterface` / `DeeplMultilingualGlossaryApiInterface`).

```php
$api = \Drupal::service('tmgmt_deepl_glossary.api');
// e.g. list glossaries on DeepL, create one from a deepl_glossary entity, delete by remote id.
```

## Typical flow

1. Create a `deepl_glossary` entity locally with `source_lang`, `target_lang`, and `entries`
   (see [../configure/glossaries.md](../configure/glossaries.md)) — no API call yet.
2. Sync it: the API service creates the glossary on DeepL, DeepL returns a remote id, which is
   stored on the entity's `glossary_id` and `ready` is set TRUE.
3. The parent `tmgmt_deepl` translator then references that glossary id when translating jobs.

Deleting the entity (via the delete form) also removes the remote DeepL glossary through the API.
Because all of these steps hit the DeepL HTTP API, they need a valid auth key; local entity CRUD
(create/read the Drupal entity) does not.
