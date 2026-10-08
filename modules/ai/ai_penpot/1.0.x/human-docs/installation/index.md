# Installation

## Requirements

AI Penpot builds on the AI Agents stack and needs secure credential storage:

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- The **AI** module (`ai`) and the **AI Agents** module (`ai_agents`) — the agent
  framework this tool plugs into.
- The **Key** module (`key`) and **Easy Encryption** (`easy_encryption`) — so the
  Penpot API credentials are stored encrypted and securely.
- A **Penpot** account and an API credential for it (created in Penpot, supplied
  during configuration — not part of the Composer install).

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_penpot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as AI Agents, Key, and Easy Encryption.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_penpot -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_penpot -y
```

Drupal enables `ai`, `ai_agents`, `key`, and `easy_encryption` as dependencies if
they are not already on.

## After enabling

1. Grant **Administer AI Penpot** to the administrator who will set up the
   connection, and **Use AI Penpot design context** to the agents/users that
   should read design context.
2. Supply your Penpot API credentials through the module's administration; they
   are stored encrypted via Easy Encryption and the Key module. Point the module
   at your Penpot instance and confirm it can read your designs.
