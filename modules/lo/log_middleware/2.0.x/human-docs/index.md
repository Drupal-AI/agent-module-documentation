# Log Middleware — manual setup guide

**Log Middleware** (`log_middleware`) is developer infrastructure that adds
**middleware support to Drupal's logger**. It ships a customized `LoggerChannel`
and `LoggerChannelFactory` that extend the core equivalents and add one thing:
the ability to run **middleware** around each log message before it's processed.
Nothing else about the core logger behavior is changed — and if no module provides
any middleware, the logger works exactly as core's does.

The point of middleware here is cross-cutting log handling. A middleware can
**alter the log level, message, and context** of a message, or **discard a message
entirely** — so modules can enrich, filter, or route logs in one place rather than
each logger reimplementing that logic. It's a foundation other modules build on,
not a feature you configure through a UI.

Adding middleware is a developer task done in code: you create a service and tag it
`log_middleware`, and it's automatically attached to the logger channel. The tag
supports two optional arguments — **`priority`** (higher numbers run earlier;
negative values allowed) and **`channels`** (an array of channel names the
middleware applies to; empty means all channels). The module itself provides *no*
middleware; example implementations live in its bundled
`tests/modules/log_test_middleware` test module.

A note for whoever adopts it: because log messages can contain **sensitive data**,
any middleware that forwards logs elsewhere should be written and configured with
care. The module itself has no content or access role. It supports Drupal 10.3+ and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it's a developer framework
with no settings. Its behavior is extended in code by other modules that provide
tagged middleware services, as described under "How to use it" below.

## Where it lives in the admin menu

Log Middleware adds no admin page and no settings form. It works entirely at the
service level.

## How to use it

1. Enable the module. On its own it changes nothing — the logger behaves exactly as
   core's until middleware is added.
2. In a custom module, define a service and give it the **`log_middleware`** tag.
   It will be attached to the logger channel and applied before each message is
   processed. Your service can alter the level, message, and context, or discard
   the message.
3. Use the tag's optional arguments to control behavior:
   - **`priority`** — a number; higher runs earlier (negatives allowed).
   - **`channels`** — an array of channel names to apply to; leave empty to apply
     to all channels.
4. Refer to the bundled `tests/modules/log_test_middleware` module for working
   example implementations.
