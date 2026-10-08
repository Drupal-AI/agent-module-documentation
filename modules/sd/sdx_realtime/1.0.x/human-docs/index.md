# SDX Realtime — manual setup guide

**SDX Realtime** (`sdx_realtime`) turns any Single Directory Component into a live,
server-driven surface. It is an umbrella that installs three submodules bringing the
patterns you would otherwise reach for Livewire, Hotwire, Phoenix LiveView, or Pusher
to do — except these speak Drupal natively. Mount a component, declare a few cache
tags or a channel, and the UI re-renders the moment the underlying entity, config, or
message changes on the server. No custom JavaScript is needed for the simple cases,
and full TypeScript hooks are available for the complex ones.

The three submodules are:

- **`sdx_reactive`** — server-driven reactive components. Write a PHP plugin, declare
  state, expose handlers, derive computed values, and react to entity/config events,
  all with PHP attributes; the framework owns DOM morphing, debouncing, and
  HMAC-signed state checksums, so you write zero JavaScript.
- **`sdx_websocket`** — bidirectional WebSocket channels with presence, using a
  pure-PHP RFC 6455 server (no Node, no Ratchet), with channel pub/sub, automatic
  reconnect, presence tracking, and HMAC handshake authentication. A Drush command
  starts it as a long-running process.
- **`sdx_broadcast`** — Server-Sent Events (SSE) for one-way push (notifications,
  tickers, live feeds), with optional automatic entity-CRUD broadcast and an
  "auto-live DataProvider" feature where cache-tag invalidations fan out to
  subscribed components.

Built on the SDX ecosystem, every feature is framework-agnostic at its core and ships
first-party adapters for React, Vue, and Svelte. Security defaults are sensible:
cache-tag broadcasting is **opt-in**, and sensitive tags (`user:*`, `session`,
`permissions:*`, `config:user.role.*`) are blocklisted by default to avoid
information disclosure. Each submodule installs cleanly with no required
configuration; enable only what you need. It requires SDX, targets Drupal 10.3+ and
11, and is an early release (`1.0.0-alpha6`).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable the submodules
   you need, and start the WebSocket/SSE services.

## Where its settings live

There is no single settings form for the umbrella module. Each submodule keeps its
own configuration under **Configuration → Development → SDX** — for example
*SDX → Reactive* and *SDX → WebSocket*. The WebSocket public URL and per-session
token are injected automatically once the WebSocket server is running.
