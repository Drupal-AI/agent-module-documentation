# Configuration

Setting up Sendinblue/Brevo has a few stages: add your API key, authorize the
connection, enable the lists you want, then wire those lists into blocks, webform
handlers, or content fields.

## 1. Set permissions

Go to **People → Permissions** (`admin/people/permissions`) and grant the
Sendinblue administration permission to the roles that should manage the
integration.

## 2. Add your API key

Create an app in the Brevo developer portal and copy the API key it gives you. You
can provide the key two ways:

- **In `settings.php`** (recommended for keeping it out of exported config):

  ```php
  $settings['sendinblue_api'] = [
    'api_key' => 'your_api_key',
  ];
  ```

- **In the admin UI** — go to **Configuration → Web services → Sendinblue**
  (`admin/config/services/sendinblue-api`), paste the values, and click **Save**.

Treat the key as a secret: it authenticates every call the module makes to
Sendinblue/Brevo. Prefer `settings.php` (backed by an environment variable) over
plain, exportable configuration, and keep the connection over HTTPS.

## 3. Authorize and enable lists

On the settings form, click the **Authorize** button to authorize your account and
generate tokens. Once tokens are generated, go to
`admin/config/services/sendinblue-api/lists` and **enable the lists** you want to
use as blocks, webform targets, or REST endpoints.

## 4. Wire the lists into your site

**Signup block** — go to **Structure → Block layout**, place the **Sendinblue**
block, and configure it with the available options.

**Webform handler** — go to **Structure → Webforms** (`admin/structure/webform`),
edit a form, open the **Emails / Handlers** tab, click **Add handler**, and choose
**Sendinblue**. Fill in the form. For this to work you need at least one list in
your Brevo account, at least one list enabled in the module settings, and at least
one Email field on the webform.

**Content‑type field** — go to **Structure → Content types**, pick a content type,
and add a **Sendinblue Lists** field, then configure it as needed.

## A note on data and privacy

Contacts you sync — emails, names and related fields — are transmitted to and
stored by Sendinblue/Brevo. Handle consent and disclose the transfer in your
privacy policy in line with GDPR and your local requirements.
