# Configuration

Email Registration has **no settings page of its own** — its single option is added to
core's Account settings form, and there's very little to set. Most of the behavior
(hiding the username field, generating a username, accepting email at login) turns on
automatically the moment the module is enabled.

## The one option

1. Go to **Configuration → People → Account settings**
   (`/admin/config/people/accounts`). You'll need the **Administer account settings**
   permission.
2. Find the **Email Registration** section on that form.
3. Set **Allow login with username**:
   - **Off** *(default)* — people log in with their **email address only**. The login
     and password‑reset forms present the field as "Email address."
   - **On** — people may log in with **either** their email address **or** their
     (auto‑generated) username in the same field.
4. Click **Save configuration**.

The setting is stored in the `email_registration.settings` config object and exports
with `drush config:export`. Nothing else is configured — usernames are generated
automatically when an account is saved, not set here.

## Welcome‑email tip

Because the username is now auto‑generated (and often not something the user
recognizes), the default welcome email's `[user:display-name]` greeting can look odd.
On the **same** Account settings form, edit the account/welcome email templates and
replace the `[user:display-name]` token with `[user:mail]` so new users are greeted by
their email address.

## Regenerate usernames for existing accounts

If you enable the module on a site that already has users, you can regenerate their
usernames from their email addresses in bulk:

1. Go to the **People** view (`/admin/people`).
2. Select the users you want.
3. Choose the **"Update username (from email_registration)"** action and apply it.

Each selected account's username is regenerated from its email address.

## Letting users keep a chosen username

If you want privileged users to still set an explicit username, grant them the **Change
own username** permission (core) — the username field stays editable for them while
remaining hidden for everyone else.
