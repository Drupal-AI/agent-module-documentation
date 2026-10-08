<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pusher mini — configuration

## Key (credentials)
Create a Key entity of type `pusher` (plugin `PusherKey` / input `PusherKeyInput`) holding `app_key` and `app_secret`. Reference it as `pusher_mini.settings:key_id`. `PusherFactory::createPusher()` and `HookPageBottom` both read it via `key.repository`; only `app_key` is ever sent to the browser.

## `pusher_mini.settings` keys
- `key_id` — machine name of the Key entity.
- `app_id`, `app_cluster`.
- `disable_auth` (bool) — when true, the auth route is not offered to the client.
- `client.forceTLS`, `client.enableStats`, `client.wsHost`/`wsPort`/`wssPort` — front-end client options.
- `server.host`/`scheme`/`port`/`timeout`/`useTls` — optional self-hosted Pusher-compatible backend. Default (no host) forces `useTLS => TRUE`.

## Endpoint
`POST /pusher/user-auth` — requires an authenticated user with `pusher_mini authenticate`. `PusherAuth::__invoke` rejects a missing or >32-char `socket_id` with 400, else returns `pusher->authenticateUser()` JSON keyed to the current user.

## Client bootstrap
`HookPageBottom::hookPageBottom()` emits `window.PusherConfiguration = {...}` in the page bottom for users with `pusher_mini use`; cache-varied by `user.permissions` and `config:pusher_mini.settings`.
