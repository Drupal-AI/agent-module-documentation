# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **AI** module (`ai`) enabled, with at least one **AI provider** configured
  and a valid provider API key stored as a secret (a Key entity or an
  environment variable — never in plain configuration). Composer pulls the AI
  module in as a dependency.

There are no additional third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_seo_link_advisor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the AI module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_seo_link_advisor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_seo_link_advisor -y
```

## Set up the AI provider

This module produces nothing until the AI module has a working provider. If you
have not already done so:

1. Enable and configure the **AI** module and a provider module (for example the
   OpenAI or Anthropic provider) under **Configuration → AI**
   (`/admin/config/ai`).
2. Store the provider API key as a secret — a **Key** entity backed by an
   environment variable is the recommended pattern; never paste the key into
   plain configuration.
3. Grant the AI SEO Link Advisor permission to the roles that should be allowed
   to run the analysis.

Remember that running an analysis sends the URL and page content to that
provider, so confirm the egress is acceptable for the content involved.
