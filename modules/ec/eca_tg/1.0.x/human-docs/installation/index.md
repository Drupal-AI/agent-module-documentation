# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- A **Telegram bot token** (from @BotFather) and the **chat id** of the chat or
  channel you want to post to.

Drupal will enable the ECA dependency automatically. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_tg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_tg -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_tg -y
```

This also enables `eca` if it is not already on.

## Store the Telegram bot token securely

The bot token is a **secret**. Never hard‑code it or commit it to version
control. Store it in an environment variable and, where the module accepts one,
reference it through a Key entity.

With DDEV, save the value into the (git‑ignored) `.ddev/.env` file and restart so
the container picks it up:

```bash
ddev dotenv set .ddev/.env --telegram-bot-token=<your-token>
ddev restart
```

The flag `--telegram-bot-token` becomes the environment variable
`TELEGRAM_BOT_TOKEN` inside the web container. Confirm it is present **without
printing its value**:

```bash
ddev exec 'test -n "$TELEGRAM_BOT_TOKEN"'   # exit status 0 means it is set
```

If you manage secrets with the [Key](https://www.drupal.org/project/key) module,
create a Key backed by that environment variable and point the ECA Telegram
action at the Key rather than pasting the raw token into the model.

> **Egress caveat:** this module sends data to Telegram's servers over the
> internet. Keep the connection over HTTPS and avoid sending sensitive
> information to an external chat.

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the Telegram action appears among the available actions. A
quick end‑to‑end test is to build a small model that posts a fixed message to
your chat and check that it arrives in Telegram.
