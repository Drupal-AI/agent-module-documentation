<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ES Attachment makes the text inside uploaded documents (PDF and similar files) full-text searchable by driving the Elasticsearch ingest "attachment" pipeline.

---

ES Attachment plugs into the Search API + Elasticsearch Connector + Search API Attachments stack. It registers a Search API Attachments text-extractor plugin (`es_pipeline_extractor`) that hands each attached file's raw bytes to Elasticsearch as base64, and three Elasticsearch Connector event subscribers that (1) create/delete an ingest pipeline named `es_attachment` that runs Elasticsearch's `attachment` processor over the file fields, (2) wrap the file content and attach the pipeline when items are indexed, and (3) rewrite search queries into nested queries against the extracted `<field>.attachment.content`. Text extraction therefore happens inside Elasticsearch rather than in PHP, so PDFs, Office documents and other formats supported by the Elasticsearch attachment processor become searchable. It is a modern fork/rewrite of `search_api_elasticsearch_attachments`, updated for Elasticsearch Connector 8.x/9.x and Search API Attachments 10.x. The module has no settings form of its own and no permissions; it is configured entirely through your existing Search API index, server and Search API Attachments field setup (choose the `es_pipeline_extractor` extraction method in `search_api_attachments.admin_config`).

---

- Make the text inside attached PDFs searchable, not just the filename.
- Index the content of Office documents (Word, Excel, PowerPoint) via Elasticsearch.
- Add full-text document search to a Search API + Elasticsearch site.
- Extract document text server-side in Elasticsearch instead of in PHP.
- Use Elasticsearch's built-in `attachment` ingest processor from Drupal.
- Auto-create the `es_attachment` ingest pipeline when the index settings are saved.
- Auto-remove the pipeline when the attachment processor is turned off.
- Wire Search API Attachments file fields into an Elasticsearch nested attachment mapping.
- Search across multiple attachment fields on one index at once.
- Return the parent content (node/media) that has a matching document attached.
- Combine document-content matches with normal field matches in one query (bool `should`).
- Support `direct`, `terms` and `phrase` Search API parse modes against document content.
- Migrate a site off the older `search_api_elasticsearch_attachments` module.
- Keep large extracted file blobs out of query responses by excluding attachment fields from `_source`.
- Index documents attached directly to an entity via a file field.
- Index documents referenced as media entities (with the required Search API Attachments patch).
- Programmatically skip attachment matching for a given query via the `no_attachments` query option.
- Boost or tune how attachment content participates in the combined query.
- Provide document-content search for a knowledge base, document library or intranet.
- Let editors find a contract, report or spec by a phrase that only appears inside the file.
- Run document extraction on Elasticsearch 8.x/9.x clusters connected through Elasticsearch Connector.
- Reindex existing content so previously uploaded documents become searchable.
- Serve full-text results that respect the Search API index's configured fields and processors.
