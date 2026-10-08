<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GlobalLink Connect is a TMGMT translator plugin that hands Drupal translation jobs to GlobalLink Project Director, the translation management system run by translations.com, and imports the finished translations back into TMGMT.

---

TMGMT provides the whole Drupal-side workflow — jobs, job items, checkout, review, acceptance — and delegates the actual translation to a translator plugin. This module is the plugin for one commercial vendor: it exports each job as XLIFF via `tmgmt_file`, opens a GlobalLink submission over the vendor's SOAP API, uploads the XLIFF documents, and later downloads the translated XLIFF and folds it back into the job. All API traffic goes through the vendor's own PHP library, `translations-com/globallink-connect-api-php` (pinned to 4.18.6 in composer.json), which the module drives through a thin adapter (`GlExchangeAdapter`). It therefore only makes sense on a site whose translation work is already contracted to translations.com; there is no offer for sites that are not.

It requires TMGMT, `tmgmt_file`, and the vendor library, and it needs the PHP `soap` extension (enforced by `hook_requirements` in `globallink.install`). Configuration is not a settings form of its own — you add a TMGMT translator of type "GlobalLink" and fill in the API URL, username, password, project id, submission prefix and classifier as translator settings (see `agent/config/settings.md`). The plugin supports both discrete jobs and TMGMT continuous jobs, can combine all job items into one document or send one document per item, and can pull completed translations either on demand (a "Pull translations" button on an active job) or automatically on cron. An event subscriber lets continuous jobs skip content by URL or entity-id exclusion filters, and a `hook_tmgmt_message_insert` hook can email a configurable address when TMGMT log messages of selected severities are written.

Practical notes for anyone evaluating it: the module carries a `^8.8 || ^9 || ^10 || ^11` core constraint, which is unusually wide and means the codebase has been carried forward rather than rewritten. The GlobalLink project on the vendor side must already define the language directions and file-format classifiers you configure — the validation on the translator form actually calls the API to verify the project id, classifier and language mappings, so a mismatch surfaces there. GlobalLink treats one submission as the unit of work, so aborting a job cancels the whole submission on the remote side.

---

- Send Drupal content to GlobalLink / translations.com for professional translation.
- Use GlobalLink Project Director as a TMGMT translator plugin.
- Submit a discrete translation job to a GlobalLink submission.
- Run a TMGMT continuous job that streams new/changed content to GlobalLink.
- Export a translation job as XLIFF (via tmgmt_file) and upload it to the vendor.
- Combine all job items into a single translatable document, or one document per item.
- Retrieve completed translations automatically on cron.
- Pull completed translations on demand with the "Pull translations" button on an active job.
- Set a per-job due date and a default due-date offset in working days.
- Mark a translation job urgent for higher-priority handling.
- Attach free-text instructions/comments to a submission.
- Set a submission-name prefix so GlobalLink submissions are recognisable.
- Choose a GlobalLink file-format classifier for the uploaded documents.
- Map Drupal language codes to GlobalLink language directions.
- Restrict a continuous job's scope with URL-wildcard or entity-id exclusion filters.
- Email a chosen address when TMGMT log messages of selected severity are recorded.
- Tell GlobalLink which environment (dev/test/stage/prod) the connector runs in.
- Abort a job and cancel the whole GlobalLink submission on the remote side.
- Validate connection credentials, project id and classifier against the live API from the config form.
- Route content translation through an existing translations.com vendor contract.
- Install the vendor library with `composer require drupal/globallink` (pulls globallink-connect-api-php).
- Keep the whole translation workflow inside TMGMT's jobs/checkout/review UI.
- Review and accept translations in TMGMT before they are applied to content.
