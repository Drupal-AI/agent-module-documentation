# Configuration

Lowercase Username's settings let you widen the allowed character set beyond the
base `a–z`, and set the help text shown to users.

## Open the settings form

1. Log in as a user with the **Administer lowercase username** permission. Grant
   this only to trusted administrators, since it controls your username policy.
2. Go to **Configuration → User interface → Lowercase Username**, or navigate
   directly to `/admin/config/user-interface/lowercase_username`.

## Allowed characters

The validator always allows lowercase letters `a–z`. Each of the following toggles
adds a category of characters on top of that base:

- **Allow numbers** — also permit digits `0–9` (e.g. `user2024`).
- **Allow dots** — also permit `.` (e.g. `first.last`).
- **Allow underscores** — also permit `_` (e.g. `first_last`).
- **Allow hyphens** — also permit `-` (e.g. `first-last`).

Anything outside the resulting set — including uppercase letters and other
punctuation or symbols — is rejected on save with *"The username contains an
illegal character."* Turn these on to match how you want account names to look,
and leave them off to keep names strict.

## Help description

A free‑text **description** shown under the account‑name field on the user forms.
Use it to tell people what your policy allows, e.g. *"Usernames must be lowercase
and may contain letters, numbers, and hyphens."* Clear guidance here saves people
a failed submission.

## Save

Click **Save configuration**. The new rules apply to the next username entered or
edited. Existing account names are **never** changed — the module only validates
new input, so tightening the rules won't rename anyone; it just prevents new names
that break them.

> **Tip:** because the settings are stored in configuration
> (`lowercase_username.settings`), you can export them with your site config and
> deploy them across environments, or script them with
> `drush config:set lowercase_username.settings …`.
