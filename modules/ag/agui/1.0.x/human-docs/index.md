# AG-UI — manual setup guide

**AG-UI** (`agui`) provides a ready-made **agentic chat interface** for Drupal —
a chat component that talks to an AI agent built on the
[AI Assistant API](https://www.drupal.org/project/ai). The chat is delivered as a
Single Directory Component (`agui:chat`) plus a JavaScript API, so a developer can
drop an AI chat window into a page template and have it stream the assistant's
responses token-by-token, render custom tool interfaces, show suggestion pills, and
more.

Under the hood, the chat posts to a streaming endpoint (`/agui/api/chat`) that runs
the configured AI agent server-side and streams AG-UI protocol events (message
chunks, tool calls, state updates) back to the browser. A separate token endpoint
(`/agui/api/token`) mints short-lived signed tokens (JWTs) so a front end can
authenticate calls to remote agent endpoints or to a Mercure subscription. It
depends on the **AI** (`ai`) and **AI Assistant API** (`ai_assistant_api`)
modules.

Because every chat request can incur real cost from an AI provider, AG-UI takes
abuse seriously — especially for anonymous visitors. Authenticated users with the
right permission always pass, but anonymous chat can be protected with an optional
required bearer token, per-IP rate limiting, and a message-length cap. These are
configured through settings in `settings.php` (see
[Configuration](configuration/index.md)).

This module is primarily a **developer** tool — the day-to-day work is embedding
the component and wiring it to an agent in code. This guide covers installation and
the site-level configuration; if you want terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (for git checkouts) build the component assets.
2. [Configuration](configuration/index.md) — the `settings.php` options, the
   permissions, and the built-in demo page.

## Where it lives in the admin menu

There is no traditional settings *form*; AG-UI's operational settings live in
`settings.php`. The one admin screen is a **demo/preview** at
**`/admin/agui/demo`**, which requires the *administer agui settings* permission and
lets you try the chat against either a local Drupal assistant or a remote endpoint.
Developers embed the actual chat component in Twig templates.
