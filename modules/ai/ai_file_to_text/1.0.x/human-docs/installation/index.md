# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — the extraction is exposed as automators and agents
  for the AI stack.
- For any downstream step that sends the extracted text to a model, a configured
  AI **provider** whose API key is stored as a **Key** entity. (The extraction
  itself is local file parsing; the AI provider is only involved when a later
  step in your flow uses a model.)

## Install with Composer

From the project root:

```bash
composer require drupal/ai_file_to_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_file_to_text -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_file_to_text -y
```

This also enables the AI module if it is not already on. There is no settings
form; the extraction automators and agents become available for use in the AI
module's tooling. See [How to use it](../index.md#how-to-use-it) in the overview.

## A note on document parsers

Because this module parses uploaded documents, keep the underlying parsing
libraries up to date as part of your regular Composer maintenance, and consider
isolating the parsing of documents that come from untrusted, public sources.
