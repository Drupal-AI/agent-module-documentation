# Theme Tokens — manual setup guide

**Theme Tokens** (`theme_tokens`) is a small utility module that exposes the
active theme's **logo** and **favicon** as Drupal tokens, so you can drop them
into any text where token replacement runs — email templates, field default
values, Views rewrites, Metatag patterns, web app manifests, and so on — without
hard‑coding a file path.

It adds a `theme` token type with four tokens. Two of them render ready‑to‑use
`<img>` markup, and two return just the raw URL:

| Token | What it gives you |
|-------|-------------------|
| `[theme:logo]` | A full `<img>` tag for the theme logo |
| `[theme:logo-url]` | The logo's URL only (for an `href`, `src`, meta tag, etc.) |
| `[theme:favicon]` | A full `<img>` tag for the favicon |
| `[theme:favicon-url]` | The favicon's URL only |

The values come straight from the current theme's own logo and favicon settings,
and they resolve for whichever theme is handling the request — so if the active
theme changes, the tokens automatically produce the right image. There's nothing
to configure: enabling the module simply makes the four tokens available
everywhere Drupal tokens are supported.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires the contributed Token module).

## Where it lives in the admin menu

Theme Tokens has no configuration page (`configure` is `null`) and adds nothing
to the admin menu. It only provides tokens. If you have the Token module's token
browser open on a form, you'll see the new **Theme** token group listed among the
available tokens.

## How to use it

Place any of the four tokens wherever token replacement is supported. For
example, put `[theme:logo]` in a transactional email template to brand it with
the site logo, or use `[theme:logo-url]` to populate a structured‑data logo
property or an Open Graph image field. Use the `-url` variants whenever you only
need the path (a link, a meta tag, a manifest), and the plain `[theme:logo]` /
`[theme:favicon]` when you want a complete `<img>` element.

In custom code you can resolve them through Drupal's token service:

```php
$markup = \Drupal::token()->replace('[theme:logo]');
$url    = \Drupal::token()->replace('[theme:logo-url]');
```
