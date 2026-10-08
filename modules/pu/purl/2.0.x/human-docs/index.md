# Persistent URL (PURL) — manual setup guide

**Persistent URL** (`purl`) is a framework for attaching **context** to your URLs
that persists as a user navigates the site. In standard Drupal, a URL like
`/about-us` simply points to a piece of content. PURL lets a segment of the URL — a
path prefix, a subdomain, a whole domain, or a query string — trigger site
behavior such as switching the theme, filtering content by a group, or changing a
user's workspace, without needing a separate node for every variation.

The model rests on three terms. A **Provider** is the logic that wants to use PURL
(for example the Group module, or a custom "tenant" module). A **Modifier** is the
specific value in the URL, such as `my-team` or `client-a`. And a **Method** is
where that modifier lives — the supported methods are path (`example.com/my-team/…`),
subdomain (`my-team.example.com/…`), domain (`my-team-portal.com/…`), query string
(`?workspace=my-team`), and, for advanced cases, user-agent/header triggers.

PURL handles the heavy lifting in both directions: **inbound**, it detects the
modifier and stores the current context so your code can ask "which PURL context am
I in?"; **outbound**, it hooks into Drupal's URL generator so every link on the page
is automatically rewritten to carry the context forward. Common uses include
multi-tenancy (many mini-sites from one install), Group-module space prefixes,
dynamic branding, and persistent campaign tracking.

Importantly, **PURL is a framework — you configure it through the modules that
provide PURL modifiers, not through PURL itself.** It establishes context and
rewrites URLs; the consuming modules decide what that context means and enforce
their own access control. PURL has no access-control role of its own. It is in the
System package and requires no other modules; it runs on Drupal `^10.1 || ^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   framework.

There is **no standalone configuration page** for PURL. It is a framework: you
configure it via the provider modules that define modifiers, described in "How to
use it" below.

## Where it lives in the admin menu

PURL itself does not add a top-level settings page you would use on its own.
Configuration happens through whichever **PURL provider** you install — for
example, the [Group](https://www.drupal.org/project/group) module or a custom
tenant/workspace module — which registers its modifiers with the framework.

## How to use it

1. Install and enable **Persistent URL** as the underlying framework.
2. Install a module that acts as a **PURL provider** (or write one). This is what
   defines the modifiers and decides what each context does — filtering content,
   switching a theme, scoping a workspace, and so on.
3. Configure the provider to map its **modifiers** (the URL values like `my-team`)
   to entities or configuration, and choose the **method** (path, subdomain,
   domain, query string, or header) for how those modifiers appear in the URL.
4. Once a visitor enters a PURL context, PURL keeps it: every outbound link on the
   page is rewritten to preserve the context automatically.

### For developers

PURL's plugin architecture (modernized for Drupal 10/11) lets you create custom
**Provider** plugins that map URL modifiers to any entity or configuration. Use it
whenever you need to carry a context in the URL and have Drupal preserve it across
navigation without manually rewriting links.
