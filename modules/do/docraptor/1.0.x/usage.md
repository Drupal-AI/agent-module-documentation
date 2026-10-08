<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DocRaptor turns HTML into a PDF (or other document type) by calling the DocRaptor SaaS API from a reusable Drupal service.

---

DocRaptor is a thin Drupal wrapper around the `docraptor/docraptor` PHP SDK for the DocRaptor HTML-to-PDF API, which renders with the commercial Prince engine. It adds a single settings form (`/admin/config/system/docraptor`) where you choose the DocRaptor account credential (as a Key entity used for the API basic-auth "username"), the output document type, and the Prince rendering options (PDF profile, colour conversion, PDF forms, ICC profile, test mode). The behaviour lives in one service, `docraptor.manager` (`DocraptorManager`): custom code calls `preparePdfDocument($html, $filename)` and then `savePdfDocument($absolutePath)` to send the HTML to DocRaptor and write the returned document to disk. The module ships no PDF-generation route, controller, block, field or Views integration of its own — you invoke the service from your own code. It requires the Key module and the `docraptor/docraptor` Composer library, and works on Drupal 10.2+ and 11.

---

- Generate a PDF from arbitrary HTML markup in custom module code via the `docraptor.manager` service.
- Render a rendered Twig template / render array (turned into an HTML string) into a downloadable PDF.
- Produce an invoice or order-confirmation PDF from an e-commerce entity's HTML.
- Create a printable PDF version of a node's body or full view mode on demand.
- Build accessible, tagged PDFs by setting the PDF profile to `PDF/UA-1` (the module default).
- Produce archival PDF/A documents by choosing the appropriate PDF profile and ICC/colour options.
- Fill and flatten interactive PDF forms by enabling the "Enable PDF forms" Prince option.
- Control colour output (e.g. `sRGB` colour conversion) for print-consistent PDFs.
- Embed an ICC colour profile in generated PDFs for colour-managed workflows.
- Develop and test PDF generation for free using DocRaptor test mode (watermarked, non-billed) via the "Enable Test" checkbox.
- Store the DocRaptor API credential securely as a Key entity (env, file, or config provider) instead of pasting it into module config.
- Swap the DocRaptor credential centrally by pointing the settings form at a different Key.
- Batch-generate PDFs (e.g. per user or per node) by calling the service in a queue or cron worker.
- Attach a generated PDF to an outgoing email by saving it to a temporary path first.
- Save generated PDFs into a Drupal file directory (public/private) for later download or as a managed file.
- Log DocRaptor API failures to the `docraptor` logger channel for monitoring and debugging.
- Migrate a Drupal 7 `print_pdf_docraptor` workflow to Drupal 10/11 using the same DocRaptor account.
- Generate certificates, tickets, or badges as PDFs from templated HTML.
- Produce report or dashboard exports as PDF from HTML tables and charts.
- Restrict who can configure the integration with the dedicated "Administer docraptor settings" permission.
- Change the output document type (default `pdf`) to another format supported by your DocRaptor plan.
