# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Comment** and **System** modules enabled (the declared dependencies).
- A working **AI provider** configured through the
  [AI](https://www.drupal.org/project/ai) module. Screening runs through that
  provider, so it must be set up with valid credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_comment_guard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_comment_guard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_comment_guard -y
```

Grant **Administer comment sanitizer** to your moderators and, if you want to
exempt trusted users, **Bypass comment sanitizer** to those roles.

## A note on secrets

Comment screening sends text to your AI provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects. Remember that the text of every screened comment is transmitted to that
provider.
