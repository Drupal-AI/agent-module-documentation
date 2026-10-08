# Ignition Error Handler — manual setup guide

**Ignition Error Handler** (`ignition`) replaces Drupal's plain error page with
the [spatie/ignition](https://github.com/spatie/ignition) error screen — the same
polished page many PHP developers know from Laravel. Instead of a wall of text,
you get a readable stack trace, the failing line shown in context with the
surrounding source, request information, and — the distinctive part — **suggested
solutions** for the error in front of you.

The module ships several Drupal-aware "solution providers" that recognise common
mistakes and tell you what to do about them: an entity query missing an access
check, a permission that does not exist, a MySQL isolation-level problem. There is
also an optional AI provider that can ask a model to explain an unfamiliar error
right inside the page.

> **This is a development tool — never enable it on a production site.** Ignition's
> whole purpose is to display source code, stack traces and request context when an
> error occurs, which is exactly the information you must not leak to the public. It
> lives in the `Development` package for that reason. Only turn it on in local or
> staging environments, and make sure production keeps Drupal's error display set to
> *None* (see the note in [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set Drupal's error level so Ignition can take over.
2. [Configuration](configuration/index.md) — the settings form, the required
   error/log level, the `view ignition error page` permission, and how to keep the
   module safely out of production.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Ignition**
(`/admin/config/development/ignition`). You need the **Administer site
configuration** permission to open it. Beyond that, Ignition takes over error
rendering automatically for any user who holds the `view ignition error page`
permission — there are no pages to build.
