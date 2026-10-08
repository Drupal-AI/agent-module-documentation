# Configuration

Mail Login works with its defaults, so this page is about tuning the behavior:
whether usernames are still allowed, how email matching is done, and what the form
fields say.

## Open the settings form

1. Log in as a user with the **Administer mail login** permission (see below).
2. Go to **Configuration → People → Mail Login**, or navigate directly to
   `/admin/config/people/mail-login`.

All settings are stored in one config object (`mail_login.settings`), so you can
export them and deploy the same behavior between environments.

## Login behavior

- **Enable email login** — the master switch. When on (the default), any login
  identifier that looks like a valid email address is matched to the account by its
  email. Turn it off to fall back to plain username-only login.
- **Email only** — when on, username login is disabled entirely. Anyone who types a
  username instead of an email is rejected with the message *"Login by username has
  been disabled. Use your email address instead."* Leave it off (the default) to
  accept **either** a username or an email in the same field. This only applies when
  email login is enabled.
- **Case sensitive** — controls how emails are matched. On (the default) matches
  emails case-sensitively, following the RFC 5321 standard. Off makes matching
  case-insensitive — so `User@example.com` matches `user@example.com` — but the
  match is accepted only when exactly one account matches, to avoid ambiguity.

## Custom field labels

- **Override login labels** — when on (the default), the module replaces the titles
  and descriptions of the login and password-reset form fields with the custom text
  below. Turn it off to leave Drupal's standard labels untouched.

When label overrides are on, you can set separate text for the normal mixed
username/email mode and for email-only mode:

- **Username field title / description (mixed mode)** — shown on the login form when
  both usernames and emails are accepted. Defaults explain that either can be used.
- **Email-only title / description** — shown on the login form when email-only mode
  is active.
- **Password field description (email-only mode)** — the help text under the
  password field in email-only mode.
- **Password-reset field title / description** — the label and help text on the
  password-reset form (`user_pass`), with separate versions for mixed mode and
  email-only mode.

Every label field is translatable, so you can localize them per language.

## Save

Click **Save configuration** to apply. Changes take effect on the next visit to the
login or password-reset form.

## Permissions

At **People → Permissions** the module defines a single permission:

- **Administer mail login** (`administer mail login`) — required to reach this
  settings form. It's a trusted, administrative permission because it controls how
  users authenticate, so grant it only to site administrators. Note this permission
  does *not* control who can log in by email — that's governed entirely by the
  settings above; it only protects who can change them.
