AT-LS connects Drupal's content translation to the AT-LS (www.at-ls.com) translation service, sending mapped entity fields for automatic or professional translation and writing the results back as entity translations.

---

AT-LS is an integration module for the AT-LS / ATLS-Global translation service. After you map Drupal langcodes to AT-LS ISO 639-2 codes, store one or more AT-LS API keys per source language via the Key module, and declare which translatable entity types/bundles and which of their fields should be translated, the module can send that content to AT-LS. It supports two translation types: synchronous ("Automatic") translations that come back inline, and asynchronous ("Professional") translations that are dispatched and later delivered through an AT-LS callback. Work is modelled with two content entities — `at_ls_translation_request` (a request to translate one entity into one target language) and `at_ls_string` (a single source string, deduplicated by hash) — and is driven through an Advanced Queue job plus a `state_machine` workflow. Translation requests can be triggered manually from an entity operation/local task, or created automatically whenever configured entities are inserted or updated. When a request's strings are all delivered, the translated values are written back onto the Drupal entity as a new (revisioned) translation, recursing into mapped entity-reference fields.

---

- Integrate a Drupal site with the commercial AT-LS translation service without writing custom API glue.
- Offer both machine ("Automatic"/synchronous) and human ("Professional"/asynchronous) translation of content from one workflow.
- Map Drupal language codes to AT-LS ISO 639-2 language codes at `/admin/config/services/at-ls/languages`.
- Store AT-LS API credentials securely as `key` entities (one key per source language), configured at `/admin/config/services/at-ls/settings`.
- Declare, per entity type and bundle, exactly which fields (and field properties) get sent for translation at `/admin/config/services/at-ls/mappings`.
- Send a node, menu link, commerce product, or any translatable content entity to AT-LS with a confirm form ("AT-LS Translate" operation / local task).
- Translate several target languages at once by selecting multiple targets in the create-request confirm form.
- Automatically create translation requests when a configured entity is created (insert operation).
- Automatically create translation requests when a configured entity's translatable fields change (update operation).
- Queue and retry professional (asynchronous) translation requests using Advanced Queue (async failures retry up to 42 times every 4 hours ≈ one week).
- Deduplicate repeated source strings across requests via a SHA-256 hash of source language + target language + source text, avoiding re-translating identical text.
- Reuse an already-delivered automatic translation, and upgrade a string from automatic to professional when a later request needs it.
- Track each translation request through a `pending → processed / refused` workflow and each string through `review → pending → delivered → removed / error`.
- Receive asynchronous results from AT-LS at the callback endpoint `/atls/asynchronous`, which updates the matching string's status and translated text.
- Recurse into mapped entity-reference / entity-reference-revisions fields so referenced entities (e.g. paragraphs) are translated too.
- Write translations back as new entity revisions, creating the target-language translation if it does not yet exist.
- Send an administrator a notification email when an asynchronous callback fails (configurable notification address).
- Review and administer requests and strings through the "AT-LS Translation Requests" (`/admin/content/translation-request`) and "AT-LS Strings" (`/admin/content/string`) collections and Views.
- Manually re-process a translation request from its "process" form when automatic processing has not completed.
- Use the module's provided permissions to separate who may open the create-request form from who may administer configuration, requests, and strings.
- Support Drupal 9, 10, and 11 sites (core `^9 || ^10 || ^11`).
