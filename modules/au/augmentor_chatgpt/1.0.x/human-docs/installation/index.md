# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- The **[Augmentor](https://www.drupal.org/project/augmentor)** module
  (`augmentor`) — this is a hard dependency; ChatGPT Augmentor is a provider plugin
  for it and does nothing without it.
- An **OpenAI account and API key** to actually talk to ChatGPT.

There are no additional Composer library or PHP requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/augmentor_chatgpt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Augmentor and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/augmentor_chatgpt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en augmentor_chatgpt -y
```

Enabling it will also enable Augmentor if it wasn't on already.

## Next steps

The module has no settings form of its own. Configure it from inside Augmentor by
adding a ChatGPT-type Augmentor and supplying your OpenAI API key and model — see
[How to use it](../index.md#how-to-use-it) for the credential-handling steps.
