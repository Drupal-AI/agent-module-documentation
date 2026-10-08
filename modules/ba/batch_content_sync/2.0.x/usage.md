Batch Content Sync pushes full content entities (nodes plus their nested media, paragraphs, taxonomy terms and files) from one Drupal environment to another over custom REST endpoints, using a Batch API run and a shared access token.

---

The module gives editors a way to selectively replicate nodes across QA, Stage and Production without a full database or configuration migration. On the source site an editor selects one or more nodes on `/admin/content` and runs a "Push to QA/Stage/Prod" action; the module's `SyncService` recursively normalizes each node — inlining referenced media, image and file bytes as base64, expanding paragraphs and entity references, and capturing Layout Builder sections — into a single JSON payload and POSTs it (one node at a time, via Batch API) to the environment URL configured for that target. The receiving site runs the same module: its `ReceiverController` validates the shared access token, then re-creates the entity or overrides the existing one matched by UUID, decoding base64 assets back into managed files, resolving or creating taxonomy terms, rebuilding paragraphs and Layout Builder sections, and even auto-creating a missing language. Every push and receive is written (with base64 blobs truncated) to a `batch_content_sync_log` database table you can browse at `/admin/content/sync-log`. Target URLs, the shared token and an "override vs. clone" behavior are set on a single settings form. It is intentionally dependency-light (core `rest`, `serialization`, `node`, `file` only) and aimed at CI/CD-friendly, editor-driven content deployment.

---

- Push a newly authored or edited node from Stage to Production without a full site deployment.
- Let editorial teams stage content on a QA site and promote approved items to Prod on demand.
- Keep content parity across QA, Stage and Prod during a development cycle.
- Replicate a node together with all its referenced media images (sent as base64 and rebuilt as managed files on the target).
- Replicate a node's file-field attachments (documents, PDFs) across environments.
- Copy a node's paragraph components (entity_reference_revisions) to another environment, rebuilding each paragraph.
- Carry taxonomy term references across environments, matching by UUID/name or creating the term if missing on the target.
- Transfer a node's Layout Builder override sections to the target environment.
- Push a specific translation of a node by selecting the language before running the action.
- Auto-provision a language on the target site when the pushed content is in a language the target does not yet have.
- Choose whether an incoming entity overrides the existing one (matched by UUID) or is created as a "(Clone)".
- Drive content promotion from the content overview page using the standard action/bulk-operations dropdown.
- Run pushes as a Batch API job so large selections are processed node-by-node with progress feedback.
- Integrate content promotion into an editorial workflow without installing extra contrib modules.
- Audit what was sent and received by browsing the sync log at `/admin/content/sync-log`.
- Inspect the exact JSON payload of any individual sync from the log detail page.
- Set per-environment target endpoint URLs (QA, Stage, Prod) from one admin settings form.
- Generate a random shared access token from the settings form for authenticating cross-environment traffic.
- Preserve authorship by matching the original author's UUID on the target (falling back to user 1).
- Reduce manual copy-paste duplication and the errors it causes when moving content between sites.
- Provide receive endpoints that an external pipeline can POST normalized entity payloads to.
