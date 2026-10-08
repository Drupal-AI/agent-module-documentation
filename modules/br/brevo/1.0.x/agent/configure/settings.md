# Configure Brevo

## Settings form

Route `brevo.admin_settings_form` → `/admin/config/services/brevo/settings`, permission **`administer brevo`**
(`restrict access: true`). Form class `BrevoAdminSettingsForm` (extends `ConfigFormBase`).

Flow:
- If no account is connected it shows an **onboarding** UI (create account link + an `api_key` textfield).
- On submit the entered key is validated by calling the Brevo **Account API** (`validateBrevoApiKey()`); an
  invalid key sets a form error and is not saved.
- Once connected it shows account details (name, company, plan credits) and a **Logout** button that clears
  `api_key` + `client_key`.
- If `getMarketingAutomation()` is available on the account it offers the **Activate Marketing Automation**
  checkbox and displays the read-only, auto-fetched `client_key`.

## Config object `brevo.settings`

Schema `brevo.schema.yml`; defaults in `config/install/brevo.settings.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | Brevo API **v3** key. Used by `BrevoFactory` for every SDK client. |
| `activate_marketing_automation` | bool | `false` | When on, Brevo's JS SDK is attached to all **non-admin** pages with the public `client_key`. |
| `client_key` | string | `''` | Public Marketing-Automation client key (auto-fetched from the account; used only by the front-end JS). |

## API key / settings.php override

The key persists in config but is an **operator deployment choice** — it can be overridden per environment
without editing config:

```php
// settings.php
$config['brevo.settings']['api_key'] = getenv('BREVO_API_KEY');
```

The settings form is aware of this: if `api_key` is empty in editable config but set in the immutable
(overridden) config, the field is made optional and other settings stay available. (Via Symfony Mailer the
key also flows into the transport DSN — see the brevo_mailer submodule.)

## Marketing Automation front-end injection

`brevo_page_attachments_alter()`: when `activate_marketing_automation` is TRUE and the route is **not** an
admin route, it attaches library `brevo/brevo-marketing-automation` (which depends on
`brevo/brevo-js-sdk` → external `https://cdn.brevo.com/js/sdk-loader.js`) and passes the public `client_key`
in `drupalSettings.brevo.clientKey`. If `client_key` is empty it is fetched once from the Account API.

## Permission

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer brevo` | true | The Brevo settings form, plus the brevo_mailer settings/test forms (both routes require it). |

## Status report

`hook_requirements` (`brevo.install`) reports on the Status report page whether the library is installed and
the API settings are configured (`BrevoHandler::validateBrevoApiSettings()`).
