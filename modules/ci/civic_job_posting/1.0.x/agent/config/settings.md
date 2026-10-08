<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

Config object: **`civic_job_posting.settings`** (single object; install defaults in
`config/install/civic_job_posting.settings.yml`). **No `config/schema/` ships**, so these keys have
no typed-config definitions.

## Route & access

- Form class `Drupal\civic_job_posting\Form\JobPostingSettings` (extends `ConfigFormBase`),
  form id `job_posting_config_form`.
- Route `job.posting_settings_form` → `/admin/config/services/jobpostingtsettings`
  (`civic_job_posting.routing.yml`), permission **`administer site configuration`**,
  `_admin_route: TRUE`. Menu link `job.posting_settings_form` sits under
  *Configuration → Web Services* (`system.admin_config_services`, weight 99).

## Config keys (all in `civic_job_posting.settings`)

| Key | Form field | Purpose |
|-----|-----------|---------|
| `google_site_verification` | textfield | Content code for the `google-site-verification` meta tag (emitted site-wide, see api doc). |
| `enableIndexing` | radios (Yes/No) | Master switch for the Google Indexing API calls in the node hooks. Default `false`. |
| `type` | textfield | Service-account: credential type (e.g. `service_account`). |
| `projectID` | textfield | Google Cloud project id. |
| `privateKeyID` | textfield | Service-account private key id. |
| `privateKey` | textarea | Service-account **private key** (PEM). |
| `clientEmail` | textfield | Service-account client email. |
| `clientID` | textfield | Service-account client id. |
| `authUri` | textfield | OAuth auth URI. |
| `tokenUri` | textfield | OAuth token URI. |
| `authProviderx509CertUrl` | textfield | Auth provider x509 cert URL. |
| `clientX509CertUrl` | textfield | Client x509 cert URL. |

The 10 service-account keys are exactly the fields of a Google service-account JSON key file. The
form offers a **`jsonFile`** `#type => 'file'` upload (validated to the `json` extension) so an admin
can import the downloaded key file, or paste each value manually. Attaches asset library
`civic_job_posting/job_posting_form` (`js/job_posting_settings_form.js`, jQuery-dependent — its
purpose is to populate the fields from the uploaded JSON on the client side).

## Save behavior

`submitForm()` loops over **every** existing key of the config object and writes
`$form_state->getValue($key)` back — it does not enumerate a fixed allowlist, so only keys already
present in the config object are persisted. `getEditableConfigNames()` returns
`['civic_job_posting.settings']`. `buildForm()` calls `$form_state->setCached(FALSE)`.

## Operating it

1. Enable the module (`drush en civic_job_posting`) — this installs the `job` type, fields,
   paragraph type and `job_view` from `config/install/`.
2. To use Google Job rich results only, you can stop here: JSON-LD is emitted automatically on
   published job pages regardless of these settings.
3. To use the **Google Indexing API**, complete Google's prerequisites (enable the Indexing API,
   create a service account, verify ownership in Search Console), then on this form set
   *Enable Google Indexing = Yes* and import/paste the service-account credential.
4. Optionally paste the *Google site verification* code to have the verification meta tag rendered.

`hook_uninstall()` (`civic_job_posting.install`) deletes this config object along with the node
type, paragraph type, every field/storage and the `job_view` view on uninstall.
