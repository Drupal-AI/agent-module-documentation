<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Publications Importer turns uploaded PDF files into LocalGov Drupal HTML "publication" node trees through a configurable, plugin-driven pipeline.
---
An editor uploads a PDF at `/admin/content/imports/create` (managed_file, `private://`, extension restricted to `pdf`), which creates a `localgov_import` content entity referencing the file and a chosen "import pipeline". Processing is deferred: on cron (when `cron_processing_mode` is on) or via the Drush command `lpii`, each pending import is run through its pipeline. A pipeline is a config entity (`localgov_import_pipeline`) naming one Extract plugin, an ordered list of Transform plugins, and one Save plugin. The default pipeline uses `smalot_pdfparser` to extract text/images/links, `transform_images` + `transform_linebreaks` + `page_limit` to shape them, and the `publication` Save plugin to build the publication node and its child pages.

The design is deliberately extensible: Extract/Transform/Save are attribute-defined plugin types (`#[Extract]`, `#[Transform]`, `#[Save]`) discovered by three plugin managers, operating on an `ImportInterface` object carrying `Page` and `Image` value objects. Pages are stored on the entity as a PHP-serialized blob; `getPages()` calls `unserialize()` with `allowed_classes` restricted to `Page` and `Image` (safe). Extracted PDF hyperlinks are scheme-filtered (`isAllowedUri` permits only http/https/mailto, blocking `javascript:`/`data:`) and HTML-escaped before being woven into content. The importer only ever reads the operator-uploaded local PDF — it does **not** fetch any request- or config-supplied remote URL — so it is not an SSRF surface, and it makes no outbound HTTP calls of its own. The optional `localgov_publications_importer_ai` submodule sends extracted text to whatever AI chat provider the site's AI module has configured; that is the only external egress and it is opt-in.

Access is permission-gated throughout: creating imports needs `create imports` (checked by `ImportAccessControlHandler`/`_entity_create_access`), the settings form needs `administer imports`, and pipeline CRUD has its own `*_import_pipeline` permissions. Typical setup: enable the module, create at least one import pipeline, then upload a PDF and either run cron or `drush lpii`.
---
- Import a PDF as a LocalGov HTML publication.
- Upload a PDF at Content → Imports → Import Publication.
- Create multiple import pipelines for different processing recipes.
- Choose a pipeline per import at upload time.
- Extract text from PDFs with the Smalot PDF parser plugin.
- Pull images out of a PDF and save them as media entities.
- Preserve hyperlinks found in the PDF (scheme-filtered, escaped).
- Limit how many PDF pages are imported with the page_limit transform.
- Normalise line breaks with the linebreaks transform.
- Process pending imports automatically on cron.
- Cap items processed per cron run via cron_items_limit.
- Process the queue manually with `drush localgov_publications_importer:import` (`lpii`).
- Turn off cron processing to run imports only on demand.
- Track import status (pending/processing/completed/failed) in the Imports view.
- Follow the link to the resulting publication when an import completes.
- Enable the AI submodule to clean up extracted text with an LLM.
- Configure an OpenAI (or other) AI provider + key for AI transforms.
- Write a custom Extract plugin for a non-PDF source format.
- Write a custom Transform plugin to reshape imported content.
- Write a custom Save plugin to target a different destination entity.
- Delete your own imports with the `delete own imports` permission.
- Grant `view imports` so a team can see the import queue.
- Restrict pipeline management with the import-pipeline permissions.
- Re-run/adjust a pipeline to compare AI vs non-AI output.
