<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
APITemplate provides a Drupal client for the APITemplate.io REST API so modules and site builders can generate PDFs from server-side templates, merge PDFs, list templates, and serve the results as downloads.
---
The module wraps APITemplate.io's `/v2` REST endpoints in the `apitemplate_io.client` service (`ApiTemplateClient`). It authenticates by sending the configured API key in an `X-API-KEY` header and posts a JSON payload of template variables to `create-pdf`, `merge-pdfs`, `list-templates`, and `delete-object`. The API endpoint base URL and API key are stored in the `apitemplate_io.settings` config object and edited through admin forms at `/admin/config/system/apitemplate-io`. A Test Tool form lets an administrator try templates and preview a returned PDF before wiring it into a workflow.

Operationally, all three routes (settings, test tool, and the admin menu block) require the `administer apitemplate_io configuration` permission, so there are no anonymous or mutating public endpoints. Requests are sent with Guzzle using the default TLS verification (no `verify => false`), and `http_errors` is disabled so the client can surface API error bodies to the logger. Security notes: the API key is held as plaintext in configuration (a standard `textfield`, not a Key entity), so protect config exports; and `ApiTemplateClient::serveFile()` will, when `$resolve_url` is TRUE, fetch an arbitrary URL server-side — it is only invoked from the admin-gated flows, so keep those callers admin-only.
---
- Enable the module and open `/admin/config/system/apitemplate-io`.
- Enter the APITemplate.io API endpoint and API key on the settings form.
- Use the Test Tool to render a template and preview the PDF.
- Generate a PDF from a template via `apitemplate_io.client`->`createPdf()`.
- Return a PDF as a download URL or as raw binary data.
- Merge two or more PDFs with `mergePdfs()`.
- List available PDF templates with `listTemplates()`.
- Delete a previous transaction object with `deleteObject()`.
- Pass per-call template variables as the JSON body.
- Override config values for a single request with `tempConfigOverride()`.
- Serve an external file as a local download with `serveFile()`.
- Restrict access with the `administer apitemplate_io configuration` permission.
- Store the API key out of version control when exporting config.
- Log API failures via the `logger.channel.apitemplate_io` channel.
- Choose export type (`file` vs `json`) per PDF request.
- Set a default template id used when none is passed to `createPdf()`.
- Build documents (invoices, certificates) from Drupal data via the client.