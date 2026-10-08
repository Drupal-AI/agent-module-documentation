# Bitly Shortener — manual setup guide

**Bitly Shortener** (`bitly_shortener`) shortens URLs through the Bitly API. It
gives you two ways to use that: a Drupal service you can call from your own code,
and a Twig function you can call from templates — `{{ bitly_shortener('https://…')
}}` — so a link can be rendered as a Bitly short link right where you need it.

The module authenticates to Bitly with an **access token** you provide on its
settings form. Calls go out through Drupal's HTTP client (Guzzle) with TLS
verification on by default. The access token is a **secret**: store it in an
environment variable and reference it (for example via a Key entity, or `getenv()`
in `settings.php`), rather than pasting it into configuration that gets committed
to version control.

One thing to keep in mind: the Twig function makes a **live API call to Bitly at
render time**. That means every render sends the URL to Bitly and counts against
your rate limit, so use it judiciously and cache the result where you can. The
module plays no role in access control — it only turns long URLs into short ones.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supply your Bitly access token and
   use the Twig function.

## Where it lives in the admin menu

The module adds a settings form where you enter your Bitly access token. Once the
token is set, use the `bitly_shortener` service in code, or the
`{{ bitly_shortener('…') }}` Twig function in templates, to produce Bitly short
links.
