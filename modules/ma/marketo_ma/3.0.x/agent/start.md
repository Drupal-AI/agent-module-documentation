<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Marketo MA (marketo_ma) — agent index

Adobe **Marketo** marketing-automation integration for Drupal. Two mechanisms in the base module:
1. **Munchkin tracking** — `marketo_ma_page_attachments()` → `PageAttachment::pageAttachments()` attaches
   `js/marketo_ma.js` + `drupalSettings.marketo_ma` (Account ID, library URL, init params) on pages that
   pass path/role visibility filters; the JS calls `Munchkin.init()` and optional `associateLead` actions.
2. **REST lead sync** — an OAuth Guzzle client (`neclimdul/marketo-rest`, base `https://{account_id}.mktorest.com`)
   reads/writes leads, submits Marketo forms, reads activities.

The `tracking_method` config picks client-side Munchkin (`munchkin`) or server-side REST (`api_client`);
REST can be immediate or queued (`marketo_ma_lead` QueueWorker, cron) when `rest.batch_requests` is on.

Base module deps: `drupal:user`. Library dep: `neclimdul/marketo-rest`. Configure route:
`marketo_ma.settings` at `admin/config/services/marketo-ma`, permission **`administer marketo`**
(`restrict access: true`). Version **3.0.0**, core `">=9.2"`.

## Key services (marketo_ma.services.yml)
- `marketo_ma` (`Service\MarketoMaService`) — worker: `updateLead()`, `postForm()`, field catalogue.
- `marketo_ma.api_client` (`Service\MarketoMaApiClient`) — wraps the REST Leads/Activities APIs.
- `marketo_ma.munchkin` (`Service\MarketoMaMunchkin`) — Munchkin params + signed `associateLead` action.
- `marketo_ma.page_attachment` (`PageAttachment`) — visibility filters + attaches JS/settings.
- `marketo_ma.secrets` — pluggable secret store (see below).
- `marketo_ma.rest.client` — Guzzle client via `ClientFactory::createOauthClient` (TLS verify default on).

## Secrets layer (src/Secrets/)
`SecretsFactory` picks the store by installed module: `EncryptionSecrets` (Encrypt) > `ImmutableConfigSecrets`
(plain config, the **default**). `KeySecrets` exists but is not wired by the factory. Only the Encrypt path
is `SaveableSecretsInterface` (editable in the settings form). Secrets: REST `client_id`/`client_secret`,
Munchkin `api_private_key`.

## Submodules
- **marketo_ma_user** — sync on user login/create/update; per-user Lead + Activity tabs. See `submodules/user.md`.
- **marketo_ma_webform** — `marketo_ma` Webform handler (field mapping, Forms 2.0, list add). See `submodules/webform.md`.
- **marketo_ma_contact** — capture core Contact form submissions (needs contact_storage). See `submodules/contact.md`.
- **marketo_ma_contact_block** — Contact block carrying extra hidden Marketo-mapped values.
- **marketo_ma_legacy_client** — swaps in old CSD\Marketo SOAP/Guzzle-3 client (unmaintained, PHP 8 broken).

## Detail docs
- `config/settings.md` — settings form, config keys, tracking methods, visibility filters.
- `api/rest-client.md` — REST client, Lead object, sync/form-submit/activity flows, hooks.
- `submodules/user.md`, `submodules/webform.md`, `submodules/contact.md` — capture points.

## Data handling note
Ships identified PII (email + mapped profile/form fields) and a named browsing profile to a third-party
platform. Not consent-gated by the module. Hold REST client id/secret and the Munchkin private key in an
environment-backed **Key**/**Encrypt** secret rather than plain exportable config.
