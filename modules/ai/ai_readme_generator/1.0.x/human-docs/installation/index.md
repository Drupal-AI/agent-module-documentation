# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal's **AI** module, configured with a working **AI provider** and its API
  key stored via the **Key** module. This is the provider that writes the README.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_readme_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_readme_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_readme_generator -y
```

## After enabling

Make sure an **AI provider** is configured in the AI module with its API key
stored as a Key (env‑backed), not in plain configuration. Then generate a README
for the module you want documented, and review the output before you rely on it —
the module's code is sent to your AI provider, so only run it on code you may
share.
