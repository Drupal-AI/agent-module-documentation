# Configuration

AG-UI is configured in two places: a set of options in your site's `settings.php`
(which control security and limits), and two permissions. There is also a demo page
for trying the chat.

## The permissions

Assign these under **People → Permissions** (`/admin/people/permissions`):

- **Use agui chat** — required to use the chat and token endpoints
  (`/agui/api/chat` and `/agui/api/token`). Grant it to whichever roles (including
  the anonymous role, if you want public chat) should be able to chat.
- **Administer agui settings** — required to reach the demo page at
  `/admin/agui/demo`. Grant it only to trusted administrators.

## Settings in `settings.php`

AG-UI's operational settings are read from `$settings[...]` in `settings.php`
rather than from an admin form. The main ones:

- **`agui_token_secret`** — the secret key used to sign the short-lived JWTs minted
  by the token endpoint. Treat it like any other secret (keep it out of version
  control). **The token validator fails closed:** if no secret is set, token
  verification will not succeed and the token endpoint returns an error — so set
  this before relying on tokens.
- **`agui_require_token`** — set to `TRUE` to require a valid `Authorization:
  Bearer <token>` on anonymous chat requests. Authenticated users always pass;
  this only gates anonymous callers. Combined with `agui_token_secret`, it stops
  bots from hitting your (paid) AI endpoint anonymously.
- **`agui_flood_limit`** / **`agui_flood_window`** — per-IP rate limiting for
  anonymous chat, using Drupal's Flood API. The defaults are **60 requests per
  3600 seconds** (60/hour); set the limit to `0` to disable rate limiting.
  Authenticated users are exempt.
- **`agui_max_message_length`** — a cap on the length of the latest message, applied
  to **all** requests (anonymous and authenticated). An over-long message is
  rejected with the error code `message_too_long`. This guards against oversized —
  and therefore costly — prompts.
- **`agui_token_expiry`** — how long a minted token is valid, in seconds (default
  **900**, i.e. 15 minutes).

Example:

```php
// settings.php
$settings['agui_token_secret'] = getenv('AGUI_TOKEN_SECRET');
$settings['agui_require_token'] = TRUE;
$settings['agui_flood_limit'] = 60;
$settings['agui_flood_window'] = 3600;
$settings['agui_max_message_length'] = 4000;
$settings['agui_token_expiry'] = 900;
```

Storing the secret in an environment variable (as above) keeps it out of your
committed settings.

## The demo page

Visit **`/admin/agui/demo`** (needs *administer agui settings*) to try the chat.
It offers two modes: chatting with a **local Drupal assistant** and chatting with a
**remote endpoint**. Use it to confirm your agent and settings work before
embedding the component in a real page.

## Embedding the chat (developer step)

The chat itself is embedded by developers in a Twig template using the
`agui:chat` component, passing props such as the chat endpoint, the `agentId` of
the AI Assistant agent to talk to, the token endpoint, and optional suggestion
prompts. It can also be driven from JavaScript via `window.AguiChat`, and custom
tool renderers can be registered with `window.AguiTools`. Those code-level details
are covered in the [`agent/`](../agent/start.md) reference docs.
