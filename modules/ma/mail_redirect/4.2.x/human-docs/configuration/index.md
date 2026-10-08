# Configuration

Mail Redirect needs to know **where** to send the mail it intercepts. You can set
this either through the settings form in the admin UI, or — often better — in your
site's `settings.php`, which keeps the redirect tied to a specific environment.

## The two modes

Mail Redirect offers two ways to rewrite recipients, chosen by the
**redirect option**:

- **Domain mode** — keeps the local part of each address but swaps the domain. So
  `john_smith@about.com` becomes `john_smith@yourtestdomain.com`. Pair this with a
  **catch-all** mailbox on your test domain and you'll capture every message,
  while still seeing who each one was originally addressed to.
- **Address mode** — sends *everything* to one fixed address, for example
  `you@yourtestdomain.com`, regardless of the original recipient.

Pick whichever fits how you want to review the captured mail.

## Option A — set it in the admin UI

Open the settings form (the `mail_redirect.admin_settings` route, under
**Configuration**) and:

1. Choose the **redirect option** — *domain* or *address*.
2. Enter the **domain** (for domain mode) or the **address** (for address mode)
   that mail should be redirected to.
3. Save the form.

## Option B — set it in `settings.php` (recommended per environment)

Setting the values in `settings.php` is the cleanest way to make sure the redirect
only ever applies where you intend. On your **test** site, add:

```php
// Redirect by domain:
$config['mail_redirect.settings']['mail_redirect_opt'] = 'domain';
$config['mail_redirect.settings']['mail_redirect_domain'] = 'yourtestdomain.com';
```

or, to send everything to a single address:

```php
// Redirect to one address:
$config['mail_redirect.settings']['mail_redirect_opt'] = 'address';
$config['mail_redirect.settings']['mail_redirect_address'] = 'you@yourtestdomain.com';
```

Because these live in the environment's `settings.php`, they won't accidentally
travel to production with your exported configuration.

## A note on CC/BCC

Recent versions set CC/BCC recipients directly on the message headers so those,
too, are redirected. If your emails use CC or BCC, send a test and confirm those
recipients are being rewritten as expected.

## Reminder

Whichever way you configure it, keep this scoped to **non-production**. On a live
site the redirect would stop real users receiving their mail and funnel their
personal data into your test inbox — see the warning in the
[overview](../index.md#-this-is-a-testing-tool--never-run-it-on-production).
