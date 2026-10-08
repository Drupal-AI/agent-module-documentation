# AI usage limits — manual setup guide

**AI usage limits** (`ai_usage_limits`) puts a ceiling on how many tokens your
site is allowed to spend with each AI provider. Out of the box, Drupal's AI module
will happily keep calling a paid LLM provider with no cap — which is fine until an
automated job, a runaway loop, or a busy demo burns through your API budget. This
module fixes that by letting an administrator set per-provider quotas and by
automatically blocking further AI calls once a quota is reached.

For each provider it can limit five separate kinds of token usage — **input**,
**output**, **total**, **cached**, and **reasoning** tokens — so you can be as
coarse or as fine-grained as you like. It counts usage as responses come back from
the AI module and, before each new request, checks the running total; if a limit
is already exceeded it stops the request before the provider is ever called, so
you don't pay for the call that would have tipped you over.

The counters are windowed. Each provider's usage is tracked from a start date, and
Drupal's cron clears the counters once a **retention period** (30 days by default)
has elapsed — so you can line the window up with your billing cycle, or shorten it
so counts roll over daily on a high-traffic site. The live counts are kept in
Drupal's state (not in exported configuration), while the limits themselves are
saved as configuration.

It has been tested primarily with the **OpenAI** provider; other providers built
on the same OpenAI-style base may work but are not guaranteed. It supports Drupal
10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI module.
2. [Configuration](configuration/index.md) — set per-provider token limits and the
   retention window on the settings form.

## Where it lives in the admin menu

The settings form sits under the AI configuration at **Configuration → AI → AI
Usage Limits** (`/admin/config/ai/usage_limits`). Access is gated by the AI
module's **Administer AI providers** (`administer ai providers`) permission — this
module does not add permissions of its own. There are no public or anonymous
endpoints; enforcement happens server-side.
