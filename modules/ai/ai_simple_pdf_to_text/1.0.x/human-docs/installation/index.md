# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module and a configured **AI provider**. This module supplies
  automators/agents that run through the AI framework, so a working provider
  (with its API key stored as a secret) is what actually performs the
  conversion.

There are no additional third-party PHP library requirements. Note the current
release is an alpha (`1.0.0-alpha3`), so test before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_simple_pdf_to_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_simple_pdf_to_text -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_simple_pdf_to_text -y
```

Once enabled, the PDF-to-text automator/agent becomes available inside the AI
module's tooling. Make sure the AI module has a provider configured (under
**Configuration → AI**, `/admin/config/ai`) with its API key stored as a secret
before you build a workflow that uses it.
