# HTTP Parameter Pollution — manual setup guide

**HTTP Parameter Pollution** (`parameter_pollution`) is a small security‑hardening
module that cleans up ambiguous URLs before Drupal acts on them. When the same
query parameter appears more than once in a request — for example
`?id=1&id=2&id=3` — different layers of a web stack can disagree about which value
"wins", and attackers sometimes exploit that disagreement to slip past filters or
confuse server‑side logic. This technique is known as HTTP Parameter Pollution
(HPP).

The module inspects each incoming request through a `KernelEvents::REQUEST`
subscriber. When it finds duplicate query parameters, it rebuilds the query string
keeping only the **last** occurrence of each one, then redirects the visitor to the
cleaned URL. This "last wins" choice deliberately matches PHP's own default
behavior, so downstream code sees a single, predictable value per parameter. It
does not reject requests — it normalizes them.

Think of it as a quiet, defense‑in‑depth control rather than a feature you
interact with. It has no settings, no permissions, and no bearing on content
access; it simply hardens how Drupal parses request parameters. There is nothing
to configure — install it, enable it, and it starts working.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form and
begins protecting your site the moment it is enabled.

## How to use it

Once enabled, HTTP Parameter Pollution works automatically and site‑wide. You do
not need to add it to any route, form, or content type. Any GET request that
carries duplicate query parameters is normalized and redirected to a clean URL,
so the rest of Drupal — and any custom code that reads `$_GET` — receives one
unambiguous value per parameter.

Because it is a positive, additive control with no configuration, the safest way
to confirm it is doing its job is described in [Installation → Verify it
worked](installation/index.md#verify-it-worked).
