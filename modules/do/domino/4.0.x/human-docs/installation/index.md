# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- **Config Split** (`config_split`) — required.
- **Reroute Email** (`reroute_email`) — required.
- **Features** — optional, only if you want to receive updates to the bundled
  configuration.
- The optional `domino_sms` submodule additionally needs the **SMS Framework**
  module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domino -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Config Split,
Reroute Email, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domino -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domino -y
```

Drupal will prompt to enable Config Split and Reroute Email as dependencies.

> **Heads up:** Domino enables Reroute Email but leaves rerouting *off* by
> default, and will block all outgoing mail until rerouting is configured for
> your non‑production environments. Configure Reroute Email straight after
> enabling — see the "How to use it" section of the [overview](../index.md).

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Domino SMS** | `domino_sms` | Displays outgoing SMS messages as Drupal messages (the SMS counterpart of Domino's "emails as messages" feature). Works with the **SMS Framework** module. |

Enable it only if you need it:

```bash
drush en domino_sms -y
```

## Verify it worked

After enabling, confirm that the **Developer** and **Manager** roles now exist
(**People → Roles**), that test users have been generated, and that your three
environment configuration splits are present in **Config Split**. Then verify
Reroute Email is configured for your current environment before sending any mail.
