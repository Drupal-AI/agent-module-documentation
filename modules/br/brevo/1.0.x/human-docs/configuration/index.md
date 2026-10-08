# Configuration

All of Brevo's setup starts on one screen: the **Brevo settings** form. You need
a Brevo account and an API v3 key (create one in your Brevo dashboard under
*SMTP & API*).

## Open the settings form

1. Log in as a user with the **Administer Brevo** (`administer brevo`)
   permission — an administrator by default.
2. Go to **Configuration → Web services → Brevo → Settings**, or navigate directly
   to `/admin/config/services/brevo/settings`.

## Connect your account

The form adapts to whether an account is already connected:

- **Not connected yet** — you see an onboarding screen with a link to create a
  Brevo account and an **API key** field. Paste your API v3 key and save. Before
  saving, the module calls Brevo's Account API to check the key is valid; an
  invalid key is rejected with an error and nothing is stored.
- **Already connected** — the form shows your account details (name, company,
  remaining plan credits) and a **Logout** button that clears the stored keys so
  you can connect a different account.

## Marketing Automation

If your Brevo plan includes Marketing Automation, the form offers an **Activate
Marketing Automation** checkbox and displays a read-only **client key** (Brevo
fetches this public key from your account automatically).

When you tick this box, Brevo injects its JavaScript tracking SDK
(`cdn.brevo.com/js/sdk-loader.js`) into every **non-admin** page of your site,
using that public client key. Leave it unchecked if you do not want front-end
tracking. Note that this loads a script from Brevo's CDN, which has privacy and
consent implications you should confirm against your site's policy.

## The stored settings

Everything the form saves lives in the `brevo.settings` configuration object:

| Setting | Meaning |
|---------|---------|
| **API key** (`api_key`) | Your Brevo API v3 key. Used for every call the module makes to Brevo. |
| **Activate Marketing Automation** (`activate_marketing_automation`) | When on, the Brevo tracking JS is added to non-admin pages. |
| **Client key** (`client_key`) | The public Marketing-Automation key, fetched from your account. Only used by the front-end script. |

## Keep the API key out of version control

The API key is a secret. Although the form stores it in configuration, the
recommended approach is to keep the real value in an **environment variable** and
override the config from `settings.php` per environment:

```php
// settings.php
$config['brevo.settings']['api_key'] = getenv('BREVO_API_KEY');
```

The settings form understands this override: if the editable config leaves the API
key empty but an override supplies it, the key field becomes optional and the rest
of the settings stay usable.

> **Using DDEV?** Store the value with DDEV's dotenv helper rather than committing
> it: `ddev dotenv set .ddev/.env --brevo-api-key=<value>` (keep `.ddev/.env` out
> of git), then `ddev restart` so the container picks it up. The variable
> `BREVO_API_KEY` is then available to `getenv()` as shown above.

## What you can do once connected

- **Send transactional email from a Webform** — add the **Brevo Transactional
  Email** handler to a Webform, pick a Brevo template, and map submission values to
  the template's parameters (supplied as YAML). A debug option prints the send
  result on screen.
- **Route all site mail through Brevo** — enable the **Brevo Mailer** submodule
  (see [Installation](../installation/index.md)); it has its own settings and test
  forms under the same `administer brevo` permission.
- **Add a newsletter opt-in at checkout** — enable **Brevo Commerce** and add its
  subscription pane to your Commerce checkout flow.
- **Call Brevo from custom code** — the `brevo.brevo_client_factory` service builds
  any Brevo API client (Contacts, Deals, SMS, WhatsApp, and more), and
  `brevo.contacts_api_client_helper` wraps common contact operations including
  double opt-in. See the [`agent/`](../../agent/api/services.md) docs for the exact
  service names and methods.

## Permission

| Permission | Gates |
|------------|-------|
| **Administer Brevo** (`administer brevo`) | The Brevo settings form, plus the Brevo Mailer settings and test forms. This is a restricted, trusted-admin permission — it exposes your API key. |
