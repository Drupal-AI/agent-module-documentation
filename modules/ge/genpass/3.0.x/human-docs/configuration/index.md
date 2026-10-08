# Configuration

Generate Password has no settings page of its own — it adds its options to the
core **Account settings** form.

## Open the settings

1. Log in as a user with the **Administer account settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings**, or navigate directly to
   `/admin/config/people/accounts`.

Genpass adds three areas to that form, described below.

## Registration behavior

- **Password entry on registration** — controls whether a person registering an
  account may type their own password:
  - *Required* — they must choose a password (core's normal behavior).
  - *Optional* — they may type one, but leaving it blank generates a strong one.
  - *Restricted* — no password field is shown; a password is always generated.

  **Note:** this setting is interlocked with core's **Require email verification
  when a visitor creates a new account**. When email verification is on, the
  registration form has no password field, so only *Restricted* is valid — the
  form will reject *Required* or *Optional* in that state.

## Admin (create/edit user) behavior

- **Admin password entry** — controls whether an administrator creating or editing
  a user may set the password:
  - *May set a password* — the admin can type one (blank generates one).
  - *Cannot set a password* — the password field is hidden for admins, so a
    password is always generated.

## Generation and display

- **Password length** — the length of generated passwords, from **5 to 32**
  (default **12**). Longer is stronger.
- **Display generated password** — whether to show the generated password once, at
  creation time, and to whom:
  - *Nobody* — never shown (default).
  - *Admin* — shown to the admin who created the account.
  - *User* — shown to the user who just registered.
  - *Both* — shown to both.
- **Replace core password generator** — when on (the default), Drupal uses
  Genpass's stronger generator everywhere. Turn it off to keep core's default
  generator while still controlling the generated length.

Click **Save configuration** when you're done. (Changing these on the form
refreshes Genpass's cached character sets automatically.)

## The "Set new random password" bulk action

Genpass adds a **Set new random password** action on the People page:

1. Go to **People** (`/admin/people`).
2. Select one or more users.
3. Choose **Set new random password** from the action dropdown and apply.

Each selected user gets a freshly generated password, and each new password is
shown to you (the operator) via a status message — useful for bulk resets or
provisioning imported accounts without emailing chosen passwords.
