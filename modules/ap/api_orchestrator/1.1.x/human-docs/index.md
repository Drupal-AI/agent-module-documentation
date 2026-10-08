<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator — manual setup guide

**API Orchestrator** (`api_orchestrator`) is a framework for coordinating calls to
external APIs reliably. It adds request **queueing** and **retry logic**, supports
both **REST and GraphQL**, and provides service management around your
integrations — so that instead of firing a bare HTTP request and hoping, your
integrations queue their work and retry on failure, making them more resilient.

This is a developer/integration framework, not an end-user feature. You use it as
a foundation for building resilient API integrations: you own the endpoints and
credentials it calls, and you build the orchestrated flows. The module provides
its own permission for managing the orchestration.

Because it calls external APIs and the flows it runs may carry sensitive data,
handle it with the usual care: store credentials as secrets (never hard-coded),
call over HTTPS, build your flows deliberately, and gate management behind the
module's permission. It supports Drupal 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Once enabled, and with its management permission granted to trusted roles, you
configure the orchestration services and build your API flows on top of the
framework — letting it handle queueing and retries for the external calls. Store
API credentials as secrets (for example in environment variables or a Key
entity), always call endpoints over HTTPS, and keep the management permission
limited to trusted roles, since orchestrated flows may move sensitive data.
