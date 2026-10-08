# Configuration

All configuration lives under **Configuration → People → Okta User Sync**
(`/admin/config/people/okta_user_sync`), and every tab requires the **Administer site
configuration** permission.

## 1. Connect to Okta

On the **Overview** tab, provide:

- **Okta base URL** — your Okta org URL (for example `https://your-org.okta.com`).
- **UPN** — a user principal name used for test lookups.
- **API token** — your Okta API token, sent to Okta as an `Authorization: SSWS
  <token>` header.

Then use the **test connection** action, which fetches a sample user from Okta
(`<base>/api/v1/users/<upn>`) to confirm the credentials work. The module can also
fetch the list of Okta attributes to populate the mapping UI.

## 2. Map attributes

On the **Mapping** tab, map Drupal user fields to Okta attributes (name, email, and
any custom fields you want synchronised).

## 3. Choose a provisioning direction and mode

- **Drupal → Okta** tab — enable provisioning of Drupal users into Okta.
- **Okta → Drupal** tab — enable pulling users from Okta into Drupal.
- Real‑time sync runs from Drupal's user create/update/delete hooks; manual
  (single/all users) and cron/scheduler options are available too. Start with manual
  provisioning of a test user before switching on real‑time or scheduled sync.

Review results any time on the **Audits / Logs** tab.

## Securing the Okta API token

The Okta API token is a powerful credential — anyone holding it can manage users in
your Okta org — so protect it carefully:

- **Restrict admin access.** In this module the token is stored in plain module
  configuration (`okta_user_sync.settings`, key `okta_user_sync_bearer_token`) and is
  rendered back into the admin form field. That means both **admin access** and
  **configuration exports** expose it. Treat the **Administer site configuration**
  permission as credential access and grant it sparingly.
- **Keep it out of exported config.** Consider excluding this configuration object
  from your configuration exports (or overriding the value per environment) so the
  token isn't committed to version control.
- **Store the value in the environment.** With DDEV, keep the token in an environment
  variable rather than typing it into files you commit:
  `ddev dotenv set .ddev/.env --okta-api-token=<value>` (never commit `.ddev/.env`),
  then `ddev restart`. Where you can, reference it via `getenv()` from `settings.php`
  as a config override, or through the [Key](https://www.drupal.org/project/key)
  module.

## Transport and egress

Outbound calls to Okta (and to miniOrange's licensing/notification endpoints on
`login.xecurify.com`) use Guzzle with **default TLS verification enabled** — do not
disable certificate verification. Be aware that enabling this integration means user
data (names, emails, and the attributes you map) is sent to Okta and, for licensing,
to miniOrange; make sure that egress and the data it carries are acceptable for your
site's privacy and consent requirements before turning on sync.
