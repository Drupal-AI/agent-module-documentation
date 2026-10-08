<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Coveo Search API adds a Search API backend and processors that push Drupal-indexed content and file attachments into a Coveo Push source.

---

`coveo_search_api` is a submodule of Coveo that wires Drupal's Search API to Coveo. It provides the `coveo` Search API backend (`SearchApiCoveoBackend`), which serializes indexed items into Coveo `DocumentBody` batches and pushes them to the organization's Push source (using the base module's push key and `Coveo\Index` file-container upload flow), and can run queries via Coveo's SearchV2 API. It adds a `coveo_file` Search API data type and a `coveo_file_attachments` processor for indexing file/attachment content, a `coveo_hierarchy` processor that converts taxonomy depth into Coveo's DynamicHierarchicalFacet format, and a `FileUriItemAbsolute` computed field type/property for absolute file URIs. Field definitions are kept in sync with Coveo through `SyncFields` and event subscribers, and several alter events (`CoveoDocumentAlter`, `CoveoDocumentsAlter`, `CoveoFieldDataAlter`, `CoveoFieldOperationsAlter`, plus legacy `hook_coveo_objects_alter`) let you modify documents/fields before they reach Coveo. Requires the `search_api` module and the base `coveo` module.

---

- Push Search API index items to a Coveo Push source.
- Use Coveo as a Search API backend (server plugin `coveo`).
- Serialize entities into Coveo documents and batch them for indexing.
- Upload file attachments to Coveo file containers during indexing.
- Index file field content with the `coveo_file_attachments` processor.
- Add a `coveo_file` data type for file-oriented fields.
- Map a taxonomy hierarchy to Coveo's DynamicHierarchicalFacet format with `coveo_hierarchy`.
- Provide absolute file URIs to Coveo via the `FileUriItemAbsolute` computed field.
- Keep Coveo field definitions in sync with Search API fields automatically.
- Run Views/admin queries against a Coveo organization through the backend.
- Delete items from the Coveo index when Drupal content is removed.
- Alter Coveo documents before indexing via `CoveoDocumentAlter` / `CoveoDocumentsAlter` events.
- Alter Coveo field data and field operations via dedicated events.
- Use the legacy `hook_coveo_objects_alter` to add custom document properties.
- Register Coveo servers/indexes and react to Search API index changes via subscribers.
- Build the content-indexing half of a Coveo secured-search setup.
