# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other Drupal module dependencies and no special PHP libraries.
- A **working, monitored mailbox** for the guarded account (user 1). Because
  password login is removed, this mailbox becomes the way back in — treat it as a
  credential in its own right.

## Prepare user 1 before enabling

This matters, so do it first:

- Make sure the **user 1 account has the correct email address**, and that this
  address matches the `init` column for that account in the user database table.
  The password‑reset path depends on this being right.
- **System administrators:** assign a **shared inbox or group mail address** that
  the development team can all reach, so the reset mail isn't tied to one person.
  Then, when someone leaves the project, revoking their access to the webserver and
  the shared inbox is enough to secure user 1 — there is no shared password to
  rotate.

## Install with Composer

From the project root:

```bash
composer require drupal/guardian -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/guardian -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en guardian -y
```

## Verify it worked

Confirm that ordinary password login no longer works for the guarded account, and
that both supported entry paths do:

- **Password reset:** go to `/user/password`, request a reset for the account, and
  confirm the mail arrives at the configured mailbox and logs you in.
- **Drush one‑time login:** run `drush uli 1` and confirm the generated link logs
  you in.

If neither works, do **not** leave the site in that state — resolve the mailbox or
shell access before you rely on Guardian.
