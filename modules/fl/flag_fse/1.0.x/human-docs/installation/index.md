# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Flag** module (`flag`) — Flag for someone else extends it, and it is
  installed as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_fse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_fse -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_fse -y
drush cr
```

Enabling also turns on the Flag module if it isn't already on.

## Grant the per‑flag permissions

For each flag you set to the **For someone else** link type, the module generates
a `flag fse [flag_id]` permission. At **People → Permissions**
(`/admin/people/permissions`), grant those permissions only to trusted roles
(moderators, administrators). Flagging on behalf of others is a privileged action,
so keep these permissions tightly scoped.

## Verify it worked

Edit a flag at **Structure → Flags** (`/admin/structure/flags`) and confirm you
can set its **Link type** to **For someone else**. Then, as a user who holds that
flag's `flag fse [flag_id]` permission, view the flagged content — you should see a
"Flag for someone else" link alongside the standard flag link, and clicking it
should open the user‑selection form.
