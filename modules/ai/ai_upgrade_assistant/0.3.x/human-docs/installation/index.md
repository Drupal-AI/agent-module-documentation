# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **System** and **Update** modules (always present in a standard Drupal
  site).
- The **Upgrade Status** module (`upgrade_status`) — this is what scans your code
  and reports deprecations; the assistant builds on its findings.
- The **AI** module, installed and configured with a working provider, with the
  provider's API key stored as a secret (via the Key module or an environment
  variable). The AI-assisted fixes run through it and are billed by that provider.

Upgrade Status is enabled automatically as a dependency when you turn this module
on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_upgrade_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update
Upgrade Status and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_upgrade_assistant -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_upgrade_assistant -y
```

After enabling, assign the module's permissions (`access upgrade assistant` and
`administer upgrade assistant`) under **People → Permissions**, and confirm the AI
module has a provider configured before you run the assistant.
