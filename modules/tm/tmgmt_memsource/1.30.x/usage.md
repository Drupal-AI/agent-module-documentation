<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Phrase TMS Translator (`tmgmt_memsource`, formerly Memsource) is a TMGMT translator plugin that sends Drupal content — and optionally attached Office files — to the Phrase TMS (phrase.com) cloud for professional/machine translation and pulls the results back as XLIFF.

---

The module registers a TMGMT `TranslatorPlugin` with id `memsource` (`MemsourceTranslator`, label "phrase"), so you create a *Provider* under TMGMT (`entity.tmgmt_translator.collection`) whose settings hold the Phrase TMS Home URL, user name and password, plus options for a preview connector, file translation, and cron pulling. On submission it authenticates to the Phrase TMS REST API (`/api2/v1/auth/login`, token cached in Drupal `state`), creates a project (optionally from a project template via `applyTemplate`, optionally grouping several jobs into one project or reusing an existing project by matching batch id or content), exports each job item to XLIFF via `tmgmt_file`, uploads it as a Phrase "job part", and records a `tmgmt_remote` RemoteMapping (project uid + job part uid) per item. Completed translations return either by cron (`memsource.cron_task`, gated to an active hour window and a per-run item limit, queued through `PullTranslationsWorker`), by the manual *Pull translations* button (`fetchTranslatedFiles`), or by an inbound webhook at `/tmgmt_memsource_callback` that Phrase TMS calls on job-part status change. The password is stored on the translator config with a reversible `MEMSOURCE_V2___` hex encoding (not encryption). When *Enable translation of file attachments* is on, matching attached files (per the TMGMT allowed MIME types, defaulting to common Office formats) are uploaded alongside the XLIFF and the translated files are downloaded and saved with a language suffix (e.g. `document_de.docx`) and re-attached to the translated content. Auto-accept, due dates, and continuous TMGMT jobs are all supported.

---

- Connect a Drupal site to Phrase TMS / Memsource for content translation via the TMGMT UI.
- Send nodes, taxonomy terms, or any TMGMT-translatable entity to professional translators through Phrase.
- Machine-translate content by wiring Phrase TMS workflows (30+ MT engines) to Drupal jobs.
- Create a Phrase project automatically for each TMGMT job, named after the job.
- Apply a Phrase *project template* (with its TMs, term bases, and providers) to new projects.
- Group several TMGMT jobs into a single Phrase project instead of one project per job.
- Reuse an existing suitable Phrase project (matched by batch id or by content) rather than creating a new one.
- Force creation of a brand-new project even when a matching one exists.
- Export each job item as XLIFF and upload it as a Phrase job part.
- Translate attached Office documents (DOCX/XLSX/PPTX/DOC/XLS/PPT) along with text content.
- Download translated files back into Drupal with a language suffix and re-attach them to the translated content.
- Pull completed translations automatically on cron within a configured active-hours window.
- Limit how many job items each cron run processes.
- Pull translations on demand with the *Pull translations* button on an active job.
- Receive push notifications from Phrase TMS via the `/tmgmt_memsource_callback` webhook.
- Bulk-pull every outstanding translation across all Memsource translators via `/pull_all_remote_translations` (permission-gated).
- Set a due date on a job that is forwarded (as end-of-day UTC) to the Phrase project/job.
- Auto-accept incoming translations by enabling the translator's auto-accept option.
- Select a Phrase preview connector so translators can preview Drupal content in-context.
- Set Phrase job status to *Delivered* automatically after import into Drupal.
- Support continuous TMGMT jobs (items activated as they are sent).
- Reuse a validated connection (`whoAmI`) to confirm credentials before saving the provider.
- Automatically re-login and retry on an expired API token (HTTP 401 handling).
