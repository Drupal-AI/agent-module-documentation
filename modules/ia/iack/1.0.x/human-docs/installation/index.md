# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The Drupal AI modules **AI Agents** (`ai_agents`) and **AI Assistant API**
  (`ai_assistant_api`) — part of the Drupal AI ecosystem. These pull in the base
  AI module and its dependencies.
- The **PhpSpreadsheet** library (`phpoffice/phpspreadsheet`), which Composer
  installs for you to read the uploaded `.xlsx` workbook.
- A **configured AI provider and AI assistant** — the module needs a working
  assistant to run its generated prompts against.

## Install with Composer

From the project root:

```bash
composer require drupal/iack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including PhpSpreadsheet and the AI modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iack -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iack -y
```

This enables the AI Agents and AI Assistant API modules as dependencies. After
enabling, set up an AI provider and an AI assistant (via the Drupal AI modules'
own configuration) so IACK has something to run its prompts against.

Grant the restricted **Upload information architecture** permission only to
trusted administrators.

## Verify it worked

Go to **`/admin/config/ai/iack`**. You should reach the upload form. Download or
locate the shipped template (`template/iatemplate.xlsx`), fill in a small test IA
(for example one vocabulary with a couple of terms), upload it, and confirm the
structures appear under **Structure → Taxonomy** / **Content types**. See
[How to use it](../index.md#how-to-use-it) for the full workflow.
