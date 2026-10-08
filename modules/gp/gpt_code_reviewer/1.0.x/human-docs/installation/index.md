# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **active OpenAI API key**.
- A running **GPT API server** — a separate service (the project describes running
  it as a Docker container) that receives the code from Drupal and relays it to
  the OpenAI API. You will point the module at this server's URL.
- No additional Composer or PHP library requirements for the Drupal module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/gpt_code_reviewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gpt_code_reviewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gpt_code_reviewer -y
```

## Post‑installation

1. Start your **GPT API server** (the service that connects to the OpenAI API).
2. Go to the module's settings and enter the **server URL**, your **OpenAI API
   key** and the **model** — see [Configuration](../configuration/index.md).
3. Grant the `add gpt_code_reviewer review` permission only to the trusted roles
   who should be allowed to run reviews (each review is a paid API call).

## Verify it worked

With the server running and settings entered, create a review from the module's
UI and confirm a **Review** entity is created and its feedback is displayed
through the bundled View.
