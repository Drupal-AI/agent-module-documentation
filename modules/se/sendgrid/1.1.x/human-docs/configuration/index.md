# Configuration

Configuring SendGrid is two parts: enter your credentials on the SendGrid settings
form, then tell **Mail System** to route mail through SendGrid.

## Open the SendGrid settings form

1. Log in as a user with the **Administer SendGrid** (`administer sendgrid`)
   permission.
2. Go to **Configuration → Web services → SendGrid settings**, or navigate
   directly to `/admin/config/services/sendgrid/settings`.

## Settings

- **SendGrid credentials (API key)** — paste the API key from your SendGrid
  account. This authenticates every message the module sends, so protect it: store
  it in a **Key** entity or an environment variable rather than in plain,
  exportable configuration, and never commit it to code.
- **Debug mode** *(optional)* — turn this on while testing to get extra diagnostic
  detail about what the module is doing with your mail.
- **IP pool name** *(optional)* — if your SendGrid plan uses IP pools, set the pool
  name you want your mail sent from.
- **Other options** — the form exposes a few additional SendGrid options you can
  set as needed.

Click **Save configuration** to store the settings.

## Route mail through SendGrid

SendGrid delivers mail via the **Mail System** module. Open Mail System's
configuration and select SendGrid as the mail plugin (as the site‑wide sender, or
for specific modules/keys if you only want certain mail to go through SendGrid).
Once selected, Drupal hands the matching outbound email to SendGrid.

## Verify

Trigger a system email — a password reset is an easy one — and check that it
arrives and shows up in your SendGrid activity dashboard. If it doesn't, re‑check
the API key and confirm SendGrid is actually selected in Mail System.
