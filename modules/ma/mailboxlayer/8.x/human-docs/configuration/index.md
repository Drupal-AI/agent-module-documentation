# Configuration

There are two parts to configuring Mailbox Layer Integration: setting the API key
(and cache retention) on the module's settings page, and turning validation on for
the individual email fields you care about.

## Open the settings page

1. Log in as a user who can administer the module.
2. Go to **Configuration → Mailbox Layer** (`/admin/config/mailboxlayer`).

## The API key

The **API key** is what authenticates your site to the mailboxlayer service. The
settings page has a field for it, but there's an important caveat about *where* to
store it.

### Prefer storing the key outside configuration

The settings-page field is fine for quick testing on a local or development
environment, but it has a real downside: **when you export your site
configuration, the key is exported with it.** That puts a live credential into
your config files (and version control), and it means dev and production would
share the same key — undesirable, since mailboxlayer request limits are per key.

The recommended approach is to **override the key in `settings.php`** so each
environment supplies its own and the key never lands in exported config:

```php
$config['mailboxlayer.settings']['mailbox_layer']['api_key'] = getenv('MAILBOXLAYER_API_KEY');
```

Storing the value in an **environment variable** rather than hard-coding it keeps
the secret out of your codebase entirely. With DDEV you can set the variable like
this:

```bash
ddev dotenv set .ddev/.env --mailboxlayer-api-key=YOUR_KEY_HERE
ddev restart
```

That makes `MAILBOXLAYER_API_KEY` available inside the container for the
`getenv()` call above. Keep `.ddev/.env` out of version control.

> If you do type the key straight into the settings form, at minimum exclude
> `mailboxlayer.settings` from configuration import/export so the credential
> doesn't travel between environments.

## Cache retention

The module stores each mailboxlayer response in the database so the same address
isn't checked twice, saving API calls. Because the response fields can change over
time, stored results are purged automatically after a set number of days. The
settings page lets you configure this **retention period** (default: **1 day** /
24 hours). Increase it to save more API calls at the cost of staler results;
decrease it if you want checks re-run more frequently.

## Turn on validation for a field

Enabling the module doesn't validate anything on its own — you choose which fields
to check:

1. Edit the webform whose email field you want to validate, and open its **build**
   UI.
2. On the **email field's** settings, tick the **mailboxlayer validation
   checkbox**.
3. **Save** the field, then save the webform.

From then on, when someone submits that form, the address in that field is checked
against mailboxlayer (the module currently uses the SMTP check to judge validity)
and an invalid address is rejected.

## Privacy note

Enabling validation means the email addresses your visitors enter are **sent to a
third party** (mailboxlayer) for checking, and results are cached in your
database. Make sure that's compatible with your site's privacy policy and any
consent you rely on, and keep the cache-retention period no longer than you need.
