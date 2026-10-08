<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Complete Webform Exporter packages a webform submission as a ZIP containing a spreadsheet of its values **and the files attached to it**, from a per-submission route or as a Views bulk action.

---

Webform's own exporters produce the submission data; the attachments are a separate problem, and on forms that collect documents — applications, claims, tenders, HR intake — the attachments are usually the point. This module closes that gap: `ExporterService` builds the spreadsheet, collects the file ids and signature images the submission references, and zips everything together. A `WebformSubmissionsExporterAction` gives the same thing in bulk from a Views listing.

## How it works

- The per-submission download is a route,
  `/admin/structure/webform/manage/{webform_id}/submission/{submission_id}/files_download`, exposed
  as an **Export submission** operation link on each submission row. It requires the module's
  **Download any webform submission managed files** permission, which is defined `restrict access: TRUE`.
- The bulk **Export submission** action is registered into Webform's submission bulk-operations list
  at install. It acts on the submissions you select and requires **update access** to those
  submissions.
- Either way you get a single ZIP: one `.xlsx` sheet (fixed columns for serial, submission id,
  created date, user, language and IP address, then a column per form element) together with the
  submission's uploaded files and any signature images.

## Worth knowing before you rely on it

**The service type-hints concrete classes rather than interfaces**, and that breaks the download on some sites. `ExporterService::__construct()` takes `FileUrlGenerator` and `StreamWrapperManager` — the implementations, not `FileUrlGeneratorInterface` / `StreamWrapperManagerInterface`. `file_url_generator` is a service that decoupled and CDN modules routinely replace. **Verified:** with `lupus_decoupled_ce_api` installed, which provides its own `FileUrlGenerator implements FileUrlGeneratorInterface`, the route returns HTTP 500 with a `TypeError`. Check whether your site swaps `file_url_generator` before depending on this feature.

---

- Download a submission's data and attachments as one ZIP.
- Export application forms complete with uploaded documents.
- Give a reviewer everything a claimant submitted in one file.
- Bulk-export selected submissions from a Views listing.
- Include signature images in the export.
- Produce a spreadsheet of a submission's values.
- Hand a complete submission to an external reviewer.
- Archive submissions with their attachments.
- Export tender responses with their documents.
- Move submissions out of Drupal for offline processing.
- Satisfy a records request with the original uploads.
- Grant the export permission only to the roles that should hold it.
- Check whether the site replaces `file_url_generator` before relying on it.
