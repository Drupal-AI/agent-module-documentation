Brevo (formerly Sendinblue) integrates a Drupal site with the Brevo CRM/transactional-email platform via the official `getbrevo/brevo-php` SDK, providing an API-key settings form, a factory of typed API clients, contact-management helpers, a Webform transactional-email handler, and (through submodules) a mail transport and a Commerce checkout subscription pane.

---

The base module stores a Brevo API v3 key (config `brevo.settings`) and exposes it through
`BrevoFactory` (service `brevo.brevo_client_factory`), which builds any of the SDK's typed API clients
(Account, Contacts, TransactionalEmails, SMS, Lists, Webhooks, Companies, Deals, and ~30 more) configured
with the key and Drupal's `http_client`. `BrevoHandler` (`brevo.handler`) validates the library and key
(calling the Account API) and surfaces status via `hook_requirements`; `ContactsApiClientHelper` wraps
common contact operations (get/create/update, double-opt-in, fetch lists). The settings form
(`/admin/config/services/brevo/settings`, permission `administer brevo`) provides an onboarding flow, shows
the connected account, and can enable **Marketing Automation**, which injects Brevo's JS SDK
(`cdn.brevo.com/js/sdk-loader.js`) with your public client key on non-admin pages. A `BrevoTransactionalHandler`
Webform handler (extends core Email handler) sends submissions through a Brevo transactional template with
YAML params. A queue worker (`brevo_create_contact`) creates contacts asynchronously on cron. Two submodules
extend it: **brevo_mailer** routes Drupal's `hook_mail` through Brevo (Mail System or Symfony Mailer, with
queue/theme/test options), and **brevo_commerce** adds a Commerce checkout pane for newsletter-list opt-in.
The API key lives in config but can be overridden from `settings.php` (`$config['brevo.settings']['api_key']`)
or, via Symfony Mailer, the transport DSN. No Drush commands.

---

- Connect a Drupal site to a Brevo account with an API v3 key.
- Send transactional emails via Brevo's API using a Brevo template from a Webform (BrevoTransactionalHandler).
- Route all of Drupal's outgoing mail through Brevo (brevo_mailer + Mail System or Symfony Mailer).
- Queue outgoing Brevo emails and send them on cron (brevo_mailer queue option).
- Add newsletter/list subscription checkboxes to a Commerce checkout (brevo_commerce pane).
- Create or update Brevo contacts from custom code via `ContactsApiClientHelper`.
- Create double-opt-in (DOI) contacts with a confirmation template and redirect URL.
- Subscribe a checkout customer to selected Brevo lists (single or double opt-in).
- Fetch a Brevo account's contact lists for use in configuration.
- Call any Brevo SDK API client (Contacts, Deals, Companies, SMS, WhatsApp, …) via `BrevoFactory`.
- Validate an entered API key by calling the Brevo Account API before saving.
- Enable Brevo Marketing Automation tracking JS across front-end pages.
- Send transactional SMS or WhatsApp through the SDK clients exposed by the factory.
- Show connected-account details (name, company, plan credits) on the settings form.
- Report configuration status on the Status report page via hook_requirements.
- Override the API key per-environment from settings.php without editing config.
- Auto-create a Symfony Mailer "brevo" transport when Symfony Mailer is installed (brevo_mailer).
- Keep the Symfony Mailer Brevo DSN in sync with the configured API key (config event subscriber).
- Use Brevo sandbox/test mode so messages are accepted but not delivered (brevo_mailer test mode).
- Apply a text-format filter or theme wrapper to outgoing Brevo mail bodies (brevo_mailer).
- Create Brevo contacts asynchronously through the `brevo_create_contact` cron queue worker.
- Debug transactional Webform sends on-screen with the handler's debug option.
- Restrict all Brevo administration to trusted users via the `administer brevo` permission.
