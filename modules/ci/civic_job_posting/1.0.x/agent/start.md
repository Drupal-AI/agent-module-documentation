<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Job Posting (civic_job_posting) — agent index

Installs a **`job` node type** (plus a **`job_location` Paragraph type**) whose fields map to
**schema.org/JobPosting**, and injects a **JobPosting JSON-LD** `<script type="application/ld+json">`
into the head of each published job page. Optionally notifies the **Google Indexing API** on job
node insert/update/delete. Package `Civic`. License GPL-2.0-or-later. Version 1.0.8.
Core `^8 || ^9 || ^10 || ^11`.

- **Settings form, config object, Google credential + site verification, indexing toggle** →
  [config/settings.md](config/settings.md)
- **JSON-LD generation, the job/paragraph fields, hooks, the Indexing API, the REST endpoints** →
  [api/jsonld-and-indexing.md](api/jsonld-and-indexing.md)

## Dependencies

- Contrib: **paragraphs** (`^1.2`), **field_group** (`^4.0`); PHP lib **google/apiclient** (`^2.0`,
  provides `Google_Client`).
- Core: `paragraphs`, `field_group`, `serialization`, `rest`, `search` (declared in info.yml);
  uses node/field/views. The `job` node type also pulls in `menu_ui`.

## What it provides (from source)

- **Content model** (config/install/): node type `job`, paragraph type `job_location`, ~20 fields
  (title, `body`, employment type, salary base/min/max/currency/unit, organization name/url/logo,
  identifier name/value, expiry/starting dates, remote flag + applicant countries, apply email/url,
  `field_job_location_group` = paragraph reference), and view `job_view` (admin page at `/admin/job`
  + a Jobs block).
- **Service** `civic_job_posting.indexing` → `Utils\JobPostingUtils` (services.yml). Builds the
  JSON-LD and talks to Google.
- **Settings form** `Form\JobPostingSettings` (`ConfigFormBase`), route
  `job.posting_settings_form` at `/admin/config/services/jobpostingtsettings`, permission
  **`administer site configuration`**; menu link under *Configuration → Web Services*.
- **REST controller** `Controller\JobPostingControllerJson` — three GET routes returning field
  allowed-values as JSON: `/rest/salary-currency`, `/rest/salary-unit`, `/rest/employment-type`
  (all `_access: 'TRUE'`; each just returns the corresponding field's option list).
- **Hooks** (`.module`): `hook_page_attachments_alter` (adds the JSON-LD + a
  `google-site-verification` meta tag), `hook_node_insert/update/delete` (indexing calls),
  `hook_help`, and a `hook_uninstall` (`.install`) that deletes all installed config.
- Config object **`civic_job_posting.settings`** (install defaults in config/install; **no
  `config/schema/`** ships). No permissions of its own, no Drush, no plugin types.
