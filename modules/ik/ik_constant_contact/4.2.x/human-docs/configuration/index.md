# Configuration

All configuration lives under **Configuration → Web services → Constant Contact**
(`/admin/config/services/ik-constant-contact`), behind the **Administer constant
contact configuration** permission. There are three tabs — the main config form, the
**Lists** tab, and a read-only **Custom Fields** tab.

## Step 1 — Provide your API credentials

You can supply the app's API key and secret in one of two ways:

**Option A — `settings.php` (recommended).** Add the credentials to your site's
`settings.php`:

```php
$settings['ik_constant_contact'] = [
  'client_id'     => 'your-api-key',
  'client_secret' => 'your-client-secret',
  'auth_type'     => 'auth_code', // only the Authorization Code flow is supported
];
```

When credentials come from `settings.php` the admin form shows them read-only and hides
the Save button — a good way to keep the secret out of the database and out of exported
config.

**Option B — the admin form.** Enter the API key and secret directly on the config form
and save. They are stored in the `ik_constant_contact.config` object (the secret is
masked as `*******` when the form is redisplayed).

## Step 2 — Authorize your account

On the config form, click **Authorize Your Account**. This sends you to Constant
Contact's sign-in/consent screen. After you approve, Constant Contact redirects back to
`/admin/config/services/ik-constant-contact/callback`, which exchanges the returned code
for an access token and a refresh token. Those tokens are saved in the database (table
`ik_constant_contact_tokens`) and used for all subsequent API calls.

The form warns you if cron is not configured — cron is what keeps the tokens fresh, so
make sure Drupal cron runs regularly (the `automated_cron` module is a simple option).

## Step 3 — Enable contact lists

Open the **Lists** tab. The module fetches every list on your Constant Contact account
and shows them as checkboxes. Tick the lists you want to use on the site and save. Only
**enabled** lists are available to the signup blocks, the webform handler, the field
type, and the REST endpoint — an un-enabled list is rejected everywhere.

## The Custom Fields tab

The **Custom Fields** tab is read-only. It lists every custom field defined on your
Constant Contact account together with its ID (UUID). You need those IDs when you want a
signup block or webform to collect a custom field — copy the ID into the relevant form.

## Tokens and cron

- Access and refresh tokens live in the `ik_constant_contact_tokens` database table.
  (Very old installs kept them in config; update hooks migrate them to the table.)
- The refresh token is used automatically before each API request and by cron, so the
  connection stays live. Cron also re-caches your lists and prunes expired tokens.

## Uninstalling

Uninstalling the module deletes its configuration. Your contacts on Constant Contact are
unaffected — they live on Constant Contact, not in Drupal.
