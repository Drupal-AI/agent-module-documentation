# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- No contributed‑module dependencies and no third‑party libraries — it is built
  on core APIs (entities, the mail manager, tokens, the Flood/Randomizer
  services).
- A working outbound **email** setup on your site, since the whole confirmation
  flow relies on Drupal being able to send mail.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multiple_email -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_email -y
```

## Grant permissions

The module defines two permissions (see
[Configuration](../configuration/index.md) for detail):

- **Administer multiple emails** — restricted; lets a role open the settings
  form. Grant only to administrators.
- **Use multiple emails** — lets a role manage the extra addresses on their own
  account. Grant to any authenticated role that should get the feature.

Set them at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Log in as a user who has the **Use multiple emails** permission and open their
account edit page — you should see a new **E‑mail Addresses** tab. Add a second
address; a confirmation email should arrive with a link, and following it (while
logged in) should mark the address confirmed on that tab.
