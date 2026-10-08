# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`).
- The **TMGMT** module (`tmgmt`) — the Translation Management Tool. To use machine
  translation you'll also want the relevant TMGMT provider (for example the DeepL
  connector) and TMGMT Content.

Composer resolves the required dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_tmgmt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner, TMGMT and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_tmgmt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_tmgmt -y
```

## Configure TMGMT and store credentials as secrets

Set up your TMGMT translation provider under TMGMT's own settings. If the provider needs
an API key (DeepL, for example), store it as a **secret** — an environment variable or a
Key entity — rather than pasting it into configuration. Remember that translating
content this way sends it to the external provider, so confirm that's acceptable for the
pages you translate.

## Verify it worked

With Pagedesigner, TMGMT and a provider configured, create a translation job for a
Pagedesigner page — the page's content should be available for translation through the
TMGMT workflow.
