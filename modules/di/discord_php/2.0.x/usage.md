<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DiscordPHP integrates the `team-reflex/discord-php` gateway library into Drupal, giving a service that manages a bot client, an event system for inbound Discord events, and a Drush command to run the bot loop.

---

The `discord_php.services.discord_php_manager` service reads the bot token from a Key entity (`discord_php_token`, shipped as a `key.key` config with the `config` provider and an empty value) and instantiates the `Discord\Discord` client with default intents plus MESSAGE_CONTENT. `drush discord-php:run` starts the long-running websocket loop; incoming `MESSAGE_CREATE` events are dispatched as Drupal events (`MessageCreateEvent`, `ReadyEvent`), and a typed-data `Message` plugin plus normalizer model the payload. An optional `discord_php_eca` submodule adds an ECA event (message received) and a `SendMessageAction` so no-code workflows can react to and post Discord messages.

Security notes: the bot token is handled through the Key module (good practice) — but the default shipped key uses the `config` provider, which stores the token in plain configuration, so switch it to an environment or file provider before entering a real token. The module exposes no inbound HTTP routes/webhooks, so there is no unauthenticated callback surface; all Discord traffic is outbound over the library's TLS websocket/HTTPS. The bot runs with whatever Discord permissions its token grants, and MESSAGE_CONTENT intent means it receives full message text — scope the bot's Discord role accordingly.

---
- Store a Discord bot token securely via a Key entity
- Run the bot with `drush discord-php:run`
- Limit the run loop with `--timeout=<seconds>`
- React to inbound Discord messages via `MessageCreateEvent`
- Hook the bot `ready` event via `ReadyEvent`
- Get the shared client from `discord_php.services.discord_php_manager`
- Send a message to a channel from custom code
- Reply to a specific message/channel id
- Attach a file to an outgoing Discord message
- Model message payloads with the typed-data `Message` plugin
- Build no-code flows with the ECA submodule
- Trigger ECA processes on a received Discord message
- Post Discord messages from an ECA `SendMessageAction`
- Use tokens/placeholders in ECA-composed message content
- Switch the token Key to an env/file provider before production
- Log Discord manager errors to the `discord_php` logger channel
- Scope the bot's Discord role/intents to least privilege
