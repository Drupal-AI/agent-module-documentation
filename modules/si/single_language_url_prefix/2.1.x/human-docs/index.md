# Single Language URL Prefix — manual setup guide

**Single Language URL Prefix** (`single_language_url_prefix`) keeps a language
code in your URLs — like `/en/about` — even when your site has only **one**
enabled language. Drupal core deliberately drops the prefix on monolingual sites,
turning `/en/about` back into `/about`. This module restores it, so a single-
language site can present a consistent language-prefixed URL scheme.

Why would you want that? Usually to prepare for the future or to match an existing
setup: you might be planning to add a second language later and want today's URLs
to already look the way they will then; you might be serving the site behind a CDN
or proxy that expects a language segment in every path; or you might have just
reduced a formerly multilingual site down to one language and want the old
prefixed URLs to keep working. Doing this the "consistent from day one" way means
switching on multilingual later is a configuration change, not a URL migration.

It works quietly through a path processor. When Drupal generates a link it injects
the prefix, and when a prefixed request comes in it strips the prefix back off so
routing still finds the right page. It only acts when the conditions are right — a
single enabled language and core's URL language negotiation set to "path prefix" —
and it does nothing (leaving core in charge) the moment you enable a second
language.

The module adds one setting of its own: a list of **excluded paths** that should
stay prefix-free, so you can keep things like `/admin`, API endpoints, or webhook
callbacks clean.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Two places matter, both under **Configuration → Regional and language**:

- **Languages → Detection and selection**
  (`/admin/config/regional/language/detection`) — this is core's own screen, where
  you enable **URL** language negotiation with the "Path prefix" method and set the
  prefix for your language. This is the setup the module depends on.
- **Languages → Single Language URL Prefix**
  (`/admin/config/regional/language/single-language-url-prefix`) — the module's own
  settings form, holding the list of excluded paths.

Both require the **Administer languages** permission.

## How to set it up

The prefix value itself comes from **core's** language negotiation, not from this
module — the module only decides whether to apply it on a monolingual site. So the
setup has two parts:

1. **Turn on URL prefixing in core.** Go to **Configuration → Regional and language
   → Languages → Detection and selection** and enable the **URL** method. Open its
   settings, choose **Path prefix** as the source, and make sure your single
   language has a prefix set (for example `en`). If the prefix is left empty, there
   is nothing for the module to add.
2. **Nothing else is required** for basic prefixing — once core is configured this
   way and only one language is enabled, the module starts keeping the prefix in
   your URLs automatically.

### Excluding paths from the prefix

Some URLs should stay clean — the admin area, an API base path, health checks, or
callback endpoints third parties hit without a language segment. To exclude them:

1. Go to **Configuration → Regional and language → Languages → Single Language URL
   Prefix** (`/admin/config/regional/language/single-language-url-prefix`).
2. In **Excluded paths**, enter one path per line. Wildcards are allowed (they're
   matched with Drupal's path matcher). For example:
   ```
   /admin
   /admin/*
   /api/*
   /health
   ```
3. **Save**. Those paths will keep working without the language prefix, both for
   incoming requests and for links Drupal generates.

### Good to know

- **Two or more languages enabled?** The module becomes a no-op — core already adds
  prefixes in that case, so there's nothing for it to do.
- The module adds **no permissions** of its own; access to its settings form is
  governed by core's **Administer languages** permission.
