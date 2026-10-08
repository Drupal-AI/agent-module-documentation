# Configuration

Setting up SendPulse has a few stages: add your API credentials, authorize the
connection, enable the lists you want, then wire those lists into blocks, webform
handlers, or content fields.

## 1. Set permissions

Go to **People → Permissions** (`admin/people/permissions`) and grant the
SendPulse administration permission to the roles that should manage the
integration.

## 2. Add your API credentials

Create an app on the SendPulse developer portal and copy the API user ID and
secret. You can provide them two ways:

- **In `settings.php`** (recommended for keeping them out of exported config):

  ```php
  $settings['sendpulse_api'] = [
    'api_secret' => 'your_api_secret',
    'api_user_id' => 'your_api_user_id',
  ];
  ```

- **In the admin UI** — go to **Configuration → Web services → Sendpulse**
  (`admin/config/services/sendpulse-api`), enter the values, and click **Save**.

Treat these credentials as secrets: they authenticate every call the module makes
to SendPulse. Prefer `settings.php` (backed by an environment variable) or a Key
entity over plain, exportable configuration, and keep the connection over HTTPS.

## 3. Authorize and enable lists

On the settings form, click the **Authorize** button to authorize your account and
generate tokens. Once tokens are generated, go to
`admin/config/services/sendpulse-api/lists` and **enable the lists** you want to
use as blocks, webform targets, or REST endpoints.

## 4. Wire the lists into your site

**Signup block** — go to **Structure → Block layout**, place the **Sendpulse**
block, and configure it with the available options.

**Webform handler** — go to **Structure → Webforms** (`admin/structure/webform`),
edit a form, open the **Emails / Handlers** tab, click **Add handler**, and choose
**Sendpulse Api**. Fill in the form. For this to work you need at least one list in
your SendPulse account, at least one list enabled in the module settings, and at
least one Email field on the webform.

**Content‑type field** — go to **Structure → Content types**, pick a content type,
and add a **Sendpulse Lists** field, then configure it as needed.

## A note on data and privacy

Contacts and messages you sync leave your site for the SendPulse service, which is
an external transfer of personal data. Handle consent and disclose the transfer in
your privacy policy as your jurisdiction requires.
