<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Sends messages from Drupal to a Discord channel using a Discord incoming webhook URL.
- Supports plain text messages and rich "embed" messages (title, description, color, author, URL).
- Exposes a `discord` service (`Drupal\discord\Discord`) and two Rules actions (send message / send embed) for automation.

---

## Install & configure

- Enable the module (optionally the Rules module to use the provided Rules actions).
- Configure at `/admin/config/services/discord/config` (route `discord.admin_settings`, permission `administer site configuration`): set the webhook URL, default bot username and avatar URL.
- Create the webhook in Discord under Server Settings -> Integrations -> Webhooks and paste its URL.
- Test with the built-in `/admin/config/services/discord/test_message` and `/test_embed` forms.

---

## Usage & API

- Programmatic send: `\Drupal::service('discord')->sendMessage($text, $username, $avatar)`.
- Rich embeds: `->sendEmbed(['description'=>..., 'color'=>'#RRGGBB', 'url'=>..., 'author'=>['name'=>...]], $username, $avatar)`.
- Requests go out over HTTPS via the core Guzzle `http_client`; TLS verification is left at Guzzle defaults (enabled) — no `verify=>false`.
- The webhook URL is admin-only configuration; treat it as a secret since anyone with it can post to the channel.
- `processMessage()` converts `<a href>` links to Discord `<url | text>` syntax and strips all other HTML tags before sending.
- Embed descriptions are `strip_tags()`-cleaned and truncated to 1000 characters.
- Embed color accepts a `#hex` string and is converted to the decimal integer Discord expects.
- Failures (404/500 from Discord) are caught, logged to the `discord` channel, and return FALSE rather than throwing.
- All four admin routes are gated by `administer site configuration`; there are no anonymous endpoints.
- Empty webhook config short-circuits with an error message instead of making a request.
- Use it for build/deploy notifications, content-moderation alerts, or contact-form pings to a team channel.
- Combine with Rules to fire a Discord message on node publish, user registration, etc.
- The service is stateless; multiple modules can call it concurrently.
- No inbound webhook / bot listener is provided — this is outbound-only.
- Message content passed by callers is the caller's responsibility to sanitize for the channel context.
- Store the webhook via a Key or environment variable if you want to keep it out of exported config.
