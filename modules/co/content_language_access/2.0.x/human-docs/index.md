# Content Language Access — manual setup guide

**Content Language Access** (`content_language_access`) stops visitors from
viewing a published node whose language does not match the language the site has
negotiated for the current request — unless an administrator has explicitly
allowed that pairing. In short: it enforces "this language's content only appears
under this language's URL."

It is designed for **domain‑ or prefix‑per‑language** sites — for example
`example.com` serving English and `example.com.br` serving Portuguese, or URL
prefixes like `/en/…` and `/pt/…`. When someone reaches an English node through
the Portuguese URL, the module returns a **403 Access Denied** so untranslated
content doesn't leak into the wrong regional site. Language‑neutral content (menus,
utility pages) and content that matches the current language are always allowed.

An admin form gives you a **matrix** of "from site language → allowed content
language" checkboxes, so you can whitelist specific cross‑language pairings (say,
allow English content to be viewed from the German site). There is also a bypass
option for a configurable list of routes (and for CLI), and a **bypass**
permission that exempts trusted roles entirely.

> **Important — it starts working the moment you enable it.** Mismatch denial is
> **on immediately** with no configuration. The admin form only ever *loosens* the
> restriction. So enable it deliberately, with your language detection already set
> up, or you may unexpectedly 403 content.
>
> **Scope limitation:** this is a view‑only check on the canonical node page. It
> does **not** filter node listings, search results, or query‑level access — only
> the direct node view is restricted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up language detection, the
   cross‑language allow matrix, and the bypass options.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Content
language access** (`/admin/config/regional/content_language_access`). You need the
**Administer content_language_access settings** permission to open it.

## How to use it

1. First configure **language detection** (URL prefix or domain) under
   Configuration → Regional → Languages, since the module keys off the negotiated
   language.
2. Install and enable the module — mismatch denial is active right away.
3. Use the settings form to whitelist any cross‑language pairings you actually
   want to allow, and to set up route/role bypasses.
