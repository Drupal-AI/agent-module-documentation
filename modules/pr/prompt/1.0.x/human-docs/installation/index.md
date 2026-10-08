# Installation

> **Remember this module is deprecated.** For new projects, install the
> [AI module](https://www.drupal.org/project/ai) instead. These steps are for
> maintaining an existing Prompt-based site.

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Token** module (`token`) — used for inserting entity field values into
  prompt templates. Composer pulls it in with the command below.
- An **account and API key** with whichever provider you use (OpenAI for
  ChatGPT/GPT-3, or Gladia). The OpenAI API is paid; running a prompt calls a paid
  third-party service.

## Install with Composer

From the project root:

```bash
composer require drupal/prompt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Token
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prompt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module and a provider submodule

Enable the base module plus at least one provider submodule for the AI service you
intend to use:

| Submodule | Machine name | Provider |
|-----------|--------------|----------|
| **Prompt ChatGPT** | `prompt_chatgpt` | OpenAI chat completions (GPT-4/GPT-3.5 family) |
| **Prompt GPT-3** | `prompt_gpt3` | OpenAI legacy completions endpoint |
| **Prompt Gladia** | `prompt_gladia` | Gladia text and audio transcription |

For example, to use ChatGPT:

```bash
drush en prompt prompt_chatgpt -y
```

## Verify it worked

Go to **Configuration → System → Prompt** (`/admin/config/system/prompt`) and
confirm you can reach the prompt collection page. Then continue to
[Configuration](../configuration/index.md) to enter your provider API key and
create a prompt.
