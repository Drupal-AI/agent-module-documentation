# Configuration

There is no standalone settings page. This module adds a **Phrase** translator
plugin to TMGMT, and you configure it by creating a TMGMT **Provider**.

## Create the Phrase TMS provider

1. Go to **Configuration → Regional and language → Translation Management →
   Providers** (`entity.tmgmt_translator.collection`).
2. Click **Add Translator** (or **Add Provider**).
3. Set the **Translator plugin** to **Phrase**.
4. Fill in the connection and option fields (below) and save. On save, the module
   attempts to log in to Phrase TMS; if the endpoint or credentials are wrong,
   validation fails, so you'll know immediately whether the connection works.

## Choose an authentication method

The **Authentication method** field offers two choices:

- **User name and password** — enter the Phrase TMS **User name** and
  **Password** the module should log in as.
- **Platform API Token** — enter a Phrase *Platform API Token*. The module
  exchanges it for a short-lived access token and refreshes that automatically, so
  you don't store a long-lived password.

Once a provider has been saved, a **Change password** / **Change Platform API
Token** checkbox appears so the stored secret is kept untouched unless you
explicitly choose to replace it.

## Provider settings

| Setting | What it does |
|---------|--------------|
| **Phrase TMS Home URL** (`service_url`) | Your Phrase TMS home address, e.g. `https://cloud.memsource.com/web`. Required. |
| **Authentication method** (`memsource_auth_method`) | User name and password, or a Platform API Token. |
| **User name** / **Password** | The Phrase TMS user the module logs in as (password method). |
| **Platform API Token** | A Phrase Platform API Token (token method). |
| **Enable translation of file attachments** (`enable_file_translation`) | Upload attached Office documents (DOCX/XLSX/PPTX and older DOC/XLS/PPT) alongside the XLIFF and download the translated files back with a language suffix (e.g. `document_de.docx`). |
| **Set job to Delivered after import** (`memsource_update_job_status`) | After importing a translation into Drupal, mark the Phrase job as *Delivered*. |
| **Webhook security token** (`memsource_webhook_token`) | Optional. A token Phrase TMS presents on the callback so the module can confirm the call is genuine. See "The webhook" below. |
| **Pull translations on cron** (`memsource_cron_use`) | Let cron fetch completed translations automatically. |
| **Cron start / end hour** (`memsource_cron_start_hour` / `..._end_hour`) | The active window (0–23) during which cron pulls; defaults 8 and 18, so pulls only happen between 08:00 and 18:00. |
| **Minutes between pulls** (`memsource_cron_time`) | How often cron checks (minimum 5). |
| **Items per cron run** (`memsource_cron_limit`) | Cap on how many job items each cron run processes (default 100). |
| **Live Preview method** (`memsource_preview_method`) | *Legacy connector* (a Phrase preview connector) or *Preview package* (Drupal renders and uploads a preview at job creation, so no Drupal credentials are stored in Phrase TMS). |
| **Preview connector** (`memsource_connector_token`) | For the legacy method: the Phrase preview connector to use. Only appears once a successful connection is established. |
| **Source entity URL — Custom Field** (`memsource_source_url_custom_field_uid`) | Optional. A Phrase job-level Custom Field that receives the public URL of the entity being translated, so linguists can open the live source page. |
| **Public site base URL override** (`memsource_public_base_url`) | Optional. Use a different public-facing domain (reverse proxy, staging, multi-domain) for the URL written to the Custom Field above. |
| **Export from workflow step** (`memsource_export_workflow_step_uid`) | Optional. Treat completion of a specific Phrase workflow step as "done"; defaults to the project's last step. |

## Per-job options

When you submit an individual TMGMT job to this provider, you can additionally
set: a **project template** (apply a Phrase template with its translation
memories, term bases, and providers), a **due date** (forwarded to Phrase), and
**group jobs** / **force new project** options that control whether several jobs
share one Phrase project.

## Getting translations back

Once content is out for translation, results return by any of:

- **Cron** — if you enabled cron pulling, within the active-hours window.
- **The Pull translations button** — on an active job, pull on demand.
- **The webhook** — Phrase POSTs to `/tmgmt_memsource_callback` when a job's
  status changes, and the module imports that job part.

You can also bulk-pull every outstanding translation across all Phrase providers
at `/pull_all_remote_translations` (this route requires the *administer tmgmt* and
*accept translation jobs* permissions).

## The webhook

Phrase TMS calls `/tmgmt_memsource_callback` when a job part's status changes, and
the module then re-fetches and imports that job part. If you set a **Webhook
security token** on the provider and configure the same token on the webhook in
Phrase TMS, the module will only act on callbacks that present that token (in the
`x-memsource-token` or `Authorization` header) and reject the rest. For
environments that keep secrets out of exported configuration, the token can be set
per-environment in `settings.php` (see the project README).
