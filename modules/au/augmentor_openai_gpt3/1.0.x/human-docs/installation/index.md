# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[Augmentor](https://www.drupal.org/project/augmentor)** module
  (`augmentor`) — a hard dependency; this is a provider plugin for it.
- An **OpenAI account and API key**.

There are no additional Composer library or PHP requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/augmentor_openai_gpt3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Augmentor and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/augmentor_openai_gpt3 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en augmentor_openai_gpt3 -y
```

Enabling it will also enable Augmentor if it wasn't on already.

## Next steps

The module has no settings form of its own. Configure it from inside Augmentor by
adding an OpenAI-type Augmentor and supplying your OpenAI API key and model — see
[How to use it](../index.md#how-to-use-it) for the credential-handling steps.
