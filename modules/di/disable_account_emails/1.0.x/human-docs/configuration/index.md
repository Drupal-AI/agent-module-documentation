# Configuration

Disable Account Emails does nothing until you tell it which emails to suppress, so
this page is where the real work happens. The settings live on the core account
settings page rather than on a page of their own.

## Open the settings

1. Log in as a user with the **Administer account settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings**
   (`/admin/config/people/accounts`).
3. Find the **Disable Account Emails** fieldset near the site's email settings.

## Choose which emails to disable

Inside the fieldset you'll find a checkbox for each of the automated account emails
Drupal can send — the welcome messages (for admin-created accounts, for accounts
pending approval, and for self-registration), the account-activated and
account-blocked notices, the account-cancellation confirmation, the
password-recovery email, and the email-change notification.

**Ticking a box disables that email** — the module will prevent it from being sent.
Leaving a box unticked keeps the email flowing as normal. Click **Save
configuration** when you're done.

## Which emails to leave enabled

Not every account email is optional. Some are part of how users prove who they are
or regain access, and disabling them causes real harm:

- **Password recovery** — this is how a locked-out user gets back in. Disabling it
  can strand people with no way to reset their password. Keep it on unless you have
  a deliberate alternative recovery path.
- **Account activation / email-change confirmation** — these verify a person's
  identity and confirm changes to their account. Disabling them removes a
  verification step, which can, for example, allow an email address to be changed
  with no confirmation.

Only disable the plain **notification-style** mails you truly don't need — the most
common case being the "welcome" message on a site where administrators create every
account and no one needs the automatic greeting. When in doubt, leave the email
enabled.
