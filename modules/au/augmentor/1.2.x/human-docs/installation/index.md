# Installation

## Requirements

- **Drupal 10.3, 11 or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The contrib **Key** (`key`) module, where provider API keys are stored. Composer
  pulls it in with the command below.
- At least one **provider submodule** to actually talk to an AI service — for
  example [AWS AI Augmentor](https://www.drupal.org/project/augmentor_aws) or
  [Azure OpenAI Augmentor](https://www.drupal.org/project/augmentor_azure_openai).
  The base module is the framework only.

## Install with Composer

From the project root:

```bash
composer require drupal/augmentor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Key and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/augmentor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en augmentor -y
```

## Enable the integration submodules you need

Enable only the ones that match how you want to use augmentation:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| CKEditor 5 | `augmentor_ckeditor5` | In-editor augmentation in CKEditor 5. |
| CKEditor 4 | `augmentor_ckeditor4` | In-editor augmentation in CKEditor 4. |
| ECA | `augmentor_eca` | Event-driven augmentation via the ECA module. |
| Search API processors | `augmentor_search_api_processors` | Augment items as they are indexed. |
| Demo | `augmentor_demo` | Example augmentors to learn from. |

For example:

```bash
drush en augmentor_ckeditor5 -y
```

Remember to add a **provider submodule** as well, then configure the API key and
create an augmentor — see [Configuration](../configuration/index.md).
