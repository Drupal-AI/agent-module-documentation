<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DiscordPHP (discord_php) — agent index

**Wraps the DiscordPHP gateway library to run a Drupal-managed Discord bot: inbound events, outbound messages, and ECA integration.**

- **Version:** 2.0.x
- **Core:** ^10.3 || ^11
- **Depends:** key:key
- **Service:** `discord_php.services.discord_php_manager` (`DiscordPhpManager`) — builds the `Discord\Discord` client from Key `discord_php_token`.
- **Drush:** `discord-php:run [--timeout=N]` runs the websocket loop.
- **Events:** `MessageCreateEvent`, `ReadyEvent`; typed-data `Message` plugin + `MessageNormalizer`.
- **Submodule:** `discord_php_eca` — ECA event (message received) + `SendMessageAction`.

**Security:** the bot token is loaded via the Key module and there are **no inbound HTTP routes or webhooks** (no unauthenticated callback surface); all traffic is outbound over the library's TLS. Caveat: the shipped default Key `discord_php_token` uses the `config` provider (plaintext-in-config) — move it to an env/file provider before storing a real token. The bot runs with its Discord role's privileges and MESSAGE_CONTENT intent.

See [api/discord.md](api/discord.md).
