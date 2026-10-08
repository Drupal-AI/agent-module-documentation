<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — DiscordPHP

## Bot client
`\Drupal\discord_php\Services\DiscordPhpManager::getClient(): ?Discord`
- Lazily builds `new Discord(['token' => <key>, 'intents' => defaults|MESSAGE_CONTENT, 'logger' => ...])`.
- Token comes from Key repository entry `discord_php_token`; returns NULL (and logs an error) if the key is empty.

## Running the bot
`drush discord-php:run` (class `DiscordPhpCommands`) opens the gateway loop:
- `--timeout=<seconds>` (default 0 = forever) schedules a shutdown timer on `ready`.
- Registers `Event::MESSAGE_CREATE` → dispatches `MessageCreateEvent`; `ready` → `ReadyEvent`.

## Events (subscribe in your module)
- `\Drupal\discord_php\Event\MessageCreateEvent` — carries the inbound `Message`.
- `\Drupal\discord_php\Event\ReadyEvent` — bot connected.
Event names are in `DiscordEvents`.

## ECA submodule (`discord_php_eca`)
- Event plugin: fires an ECA process on a received Discord message (exposes tokens: id, channel_id, guild_id, user_id, content, timestamp).
- Action plugin `SendMessageAction`: composes and sends a message (content, channel_id, optional reply_to id/channel, optional filepath attachment) with token replacement; validates the filepath before sending.

## Secure the token
The default Key uses the `config` provider. Recreate `discord_php_token` with an `env` or `file` provider so the bot token is never written to exported configuration.
