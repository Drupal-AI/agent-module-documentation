# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`drupal/key`) — a hard dependency, used to hold the bot
  token. Composer pulls it in automatically.
- The **ECA** module (`drupal/eca`) — only needed if you enable the optional
  `discord_php_eca` submodule.
- The `team-reflex/discord-php` PHP library, which Composer installs as a
  dependency of this module.
- A Discord bot (an application with a bot user) whose token you can copy.

## Install with Composer

From the project root:

```bash
composer require drupal/discord_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in the Key module and the `team-reflex/discord-php` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/discord_php -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en discord_php -y
```

For no‑code automation, also enable the ECA submodule (which requires ECA):

```bash
drush en discord_php_eca -y
```

## Create the Discord bot and copy its token

1. Go to the Discord Developer Portal, create an **application**, and add a **bot**
   to it.
2. Copy the bot's **token** — treat it as a password.
3. Invite the bot to your server with the permissions it needs, and no more.

## Store the bot token securely

The module ships a Key entity named `discord_php_token`, but **its default
provider stores the value in plain configuration** — which would end up in your
exported config and version control. Before entering a real token, switch the Key
to a safer provider.

The recommended pattern is an environment variable behind a Key:

> **DDEV:** save the token as an env var without committing it —
> `ddev dotenv set .ddev/.env --discord-php-token=<value>` then `ddev restart`.
> Keep `.ddev/.env` out of version control.

Then edit the `discord_php_token` Key (**Configuration → System → Keys**,
`/admin/config/system/keys`) and set it to the **Environment** (or **File**)
provider pointing at that variable, rather than the default config provider. The
module reads the token from this Key when it builds the bot client; if the Key is
empty it logs an error and does not connect.

## Run the bot

```bash
drush discord-php:run
```

This opens the long‑running websocket connection to Discord and stays connected.
Add `--timeout=<seconds>` to have it shut down automatically after a period, which
is useful while testing. In production, run it under a process manager (systemd,
supervisor, etc.) so it restarts if it stops.

## Verify it worked

With a valid token in the Key, run `drush discord-php:run`. When the bot connects,
the `ReadyEvent` fires; post a message in a channel the bot can see and confirm
your subscriber (or an ECA model) reacts. Errors are logged to the `discord_php`
log channel — check there if the bot fails to connect.
