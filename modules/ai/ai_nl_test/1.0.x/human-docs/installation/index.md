# Installation

## Requirements

AI Natural Language Test needs the AI framework and secure key storage:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) — enabled and configured with a working AI provider,
  which generates and runs the tests. (The AI module is pulled in with the AI
  provider you configure; this module lists core dependencies directly.)
- The **Key** module (`key`) — so the AI API key is stored as a secret.
- Core's **System**, **Serialization**, and **File** modules (enabled
  automatically).

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_nl_test -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_nl_test -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_nl_test -y
```

Drupal enables the `key`, `serialization`, and `file` dependencies for you if
they are not already on.

## After enabling

1. Make sure the **AI** module has a provider configured, with its API key stored
   as a **Key** entity (per this project's conventions, back the Key with an
   environment variable set through DDEV's dotenv command).
2. Grant the module's permissions to the roles that should author and run the
   natural-language tests.
