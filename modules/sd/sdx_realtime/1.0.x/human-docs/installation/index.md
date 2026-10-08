# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **SDX** framework (`^1 || ^2`) — SDX Realtime extends it.
- The three bundled submodules: **`sdx_reactive`**, **`sdx_websocket`**, and
  **`sdx_broadcast`**.

This is an early release (`1.0.0-alpha6`) — treat it as pre-production and test on a
non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/sdx_realtime -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdx_realtime -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable only what you need

Each submodule installs cleanly on its own, so enable just the pieces you want:

```bash
drush en sdx_reactive sdx_websocket sdx_broadcast -y
drush sdx:resolve   # picks up the new *.sdx.yml manifests
```

| Submodule | What it provides |
|-----------|------------------|
| **`sdx_reactive`** | Server-driven reactive components in pure PHP. Works out of the box — place a reactive component in a render array and the pre-render hook does the rest. Settings under *Configuration → Development → SDX → Reactive*. |
| **`sdx_websocket`** | Bidirectional WebSocket channels with presence. Needs the server running (see below). |
| **`sdx_broadcast`** | Server-Sent Events push, and optional cache-tag fan-out. |

## Start the WebSocket server (for sdx_websocket)

The WebSocket server is a long-running process; start it under a supervisor of your
choice (systemd, supervisord, and so on):

```bash
drush sdx:ws --host=0.0.0.0 --port=8080
```

Then set the public URL clients connect to under **Configuration → Development →
SDX → WebSocket**. The URL and a per-session token are injected into `drupalSettings`
automatically.

## Enable SSE cache-tag fan-out (for sdx_broadcast)

SSE is available at `/api/sdx-broadcast/stream/{channel}`. The auto-live DataProvider
feature (cache-tag fan-out) is **opt-in**:

```bash
drush cset sdx_broadcast.settings broadcast_cache_tags 1
```

Sensitive cache tags (`user:*`, `session`, `permissions:*`, `config:user.role.*`) are
blocklisted by default. If your site emits tags you do not want on the wire, adjust
the blocklist in `sdx_broadcast.settings:cache_tags_blocklist`.
