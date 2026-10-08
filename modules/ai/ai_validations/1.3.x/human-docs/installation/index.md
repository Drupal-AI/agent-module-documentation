# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Field Validation** module (`field_validation`) — this module adds AI rule
  types to it.
- The **AI** module (`ai`), installed and configured with a working provider whose
  API key is stored as a secret (via the Key module or an environment variable).
  The AI module performs the evaluation calls and handles credentials.
- Core's **Image** module (`image`), which is a dependency.

Field Validation, AI, and Image are enabled automatically as dependencies when you
turn this module on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_validations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update Field
Validation, the AI module, and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_validations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_validations -y
```

After enabling, confirm the AI module has a provider configured, then add the AI
rule types to a Field Validation ruleset on the field you want to check.
