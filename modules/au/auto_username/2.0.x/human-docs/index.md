# Automatic User Names — manual setup guide

**Automatic User Names** (`auto_username`) generates each user's username
automatically from a configurable **token pattern** — for example `[user:mail]` so
the username equals the email address — instead of letting people type their own.
It hides the username field on the registration and profile forms, so the name is
*derived* from trusted data rather than chosen. This is handy for enforcing a house
naming convention, keeping usernames in sync with email, or cleaning up messy names
on a legacy or migrated site.

When a user is created (and, if you like, whenever their profile is edited), the
module builds the real username by running your token pattern through Drupal's
Token system, then **cleaning** the result: it can strip HTML, transliterate
accented or non-Latin characters to ASCII, apply per-character punctuation rules,
remove "ignore words," collapse whitespace to a separator, lowercase everything, and
truncate to a maximum length. If the generated name collides with an existing
account, it appends `_1`, `_2`, and so on to keep it unique.

Developers can override the whole thing — supply a completely custom generator with
`hook_auto_username_name()`, or post-process the final name with
`hook_auto_username_alter()`. There's also a bulk **Action** on the People admin
screen to regenerate usernames for selected users, and a `bypass auto_username`
permission so chosen accounts (admins, system users) keep their fixed names.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Token module) and enable it.
2. [Configuration](configuration/index.md) — the pattern, the cleaning options,
   update-on-edit, the bulk action, and the permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Account settings → Patterns**
(`/admin/config/people/accounts/patterns`), reached via the *Patterns* tab, and is
gated by the restricted **Administer auto username** permission.

## How to use it

Enable the module, open the Patterns form, and set the token pattern you want (the
default is `[user:mail]`). Choose any cleaning options that suit your naming rules,
save, and new users will get generated names with the username field hidden on
registration. Use the bulk action on the People page to apply the pattern to
existing users. See [Configuration](configuration/index.md) for every option.
