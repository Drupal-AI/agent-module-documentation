# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Push Framework** (`push_framework`) module — this is a hard dependency;
  Push Framework Email is a channel plugin for it. Composer pulls it in when you
  require this module.
- A working **mail transport** on your site, so the email channel can actually
  send messages.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/pf_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches the required Push Framework module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pf_email -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pf_email -y
```

This enables the Push Framework too if it is not already on.

## Verify it worked

Log in as an administrator and open the Push Framework configuration (under
**Configuration → System → Push framework**). The **email** channel should be
available to enable. Send a test notification and confirm the email arrives — if
it doesn't, check your site's mail transport configuration first.
