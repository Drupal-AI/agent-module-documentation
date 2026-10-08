# Brevo services & extension points

## Services

| Service id | Class | Use |
|---|---|---|
| `brevo.brevo_client_factory` | `BrevoFactory` | Build any Brevo SDK API client, configured with the stored (or passed) API key + core `http_client`. |
| `brevo.handler` | `BrevoHandler` | Validate the library/key, fetch the account, module status. |
| `brevo.contacts_api_client_helper` | `ContactsApiClientHelper` | High-level contact operations. |
| `brevo.brevo_transactional_emails_api_client` | `Brevo\Client\Api\TransactionalEmailsApi` | Pre-built transactional-emails client (factory-created). |
| `brevo.brevo_account_api_client` | `Brevo\Client\Api\Account` | Pre-built account client. |
| `logger.channel.brevo`, `logger.channel.brevo_webform` | — | Logger channels. |

## `BrevoFactory` (build any SDK client)

`getConfiguration(?string $api_key = NULL)` returns an SDK `Configuration` with the key (defaults to
`brevo.settings` `api_key`). One `create<Name>ApiClient(?string $api_key = NULL)` method per SDK API — each
returns the client or **NULL if the library is missing** (`isBrevoLibraryInstalled()` checks
`\Brevo\Client\Configuration`). Available: Account, Attributes, Companies, Contacts, Conversations, Coupons,
CRM, Deals, Domains, Ecommerce, EmailCampaigns, Events, ExternalFeeds, Files, Folders, InboundParsing,
Lists, MasterAccount, Notes, Process, Reseller, Senders, SMSCampaigns, Tasks, TransactionalEmails,
TransactionalSMS, TransactionalWhatsApp, User, Webhooks, WhatsAppCampaigns.

```php
$factory = \Drupal::service('brevo.brevo_client_factory');
$contacts = $factory->createContactsApiClient();          // uses configured key
$sms = $factory->createTransactionalSMSApiClient($otherKey); // override key
```

## `BrevoHandler` (`brevo.handler`)

- `moduleStatus($show = FALSE)` — library + API settings valid.
- `validateBrevoApiKey($key)` — calls Account API `getAccount()`; on failure adds a messenger error with the
  decoded Brevo error code/message; returns bool.
- `getBrevoAccount($key)` — returns the SDK Account model.
- `validateBrevoApiSettings()`, `validateBrevoLibrary()`.

## `ContactsApiClientHelper` (`brevo.contacts_api_client_helper`)

Lazy-loads a Contacts client (throws `RuntimeException` if the library is absent). Methods:
- `getContactInfo($email)` → contact model or NULL.
- `createContact(string $email, array $listIds = [])` — logs on failure.
- `updateContact(string $email, array $listIds = [])`.
- `createDoiContact(string $email, string $redirectionUrl, int $templateId, array $listIds = [])` —
  double-opt-in.
- `fetchAvailableLists(): array` — the account's lists as arrays.

## Webform handler `brevo_transactional` (`BrevoTransactionalHandler`)

Extends core `EmailWebformHandler`. Sends a Webform submission via a Brevo **transactional template**:
select a `template_id` (fetched active templates), supply `brevo_params` as YAML (`contact` attributes +
`data`), optional `debug`. `sendMessage()` builds a `SendSmtpEmail` (to/subject/templateId/cc/bcc/replyTo +
params) and calls `sendTransacEmail()`; on error logs to `brevo_webform` and writes the error to the
submission notes; on success stores the Brevo message id on the submission. Requires the `webform` module.

## Queue worker `brevo_create_contact` (`CreateContactQueue`)

Cron queue worker (`cron time 60`). `processItem($data)` builds `CreateContact($data)` and calls
`createContact()`; on failure logs and re-throws (item retried). Use it to create contacts asynchronously:
`\Drupal::queue('brevo_create_contact')->createItem(['email' => '…', 'listIds' => [...]]);`

## SDK autoload note

`brevo.module` integrates with the optional **Ludwig** module to `require_once` `html2text/html2text` when
libraries are managed by Ludwig rather than Composer.
