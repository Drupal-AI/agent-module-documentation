# Push Notifications — manual setup guide

**Push Notifications** (`push_notifications`) stores mobile **device tokens** and
sends push messages to iOS and Android devices directly from Drupal. Because the
sending happens inside Drupal, a notification can be triggered by the same events
you already have — content published, an order shipped, a comment reply — rather
than by a separate service that has to be told what changed. It supports Apple's
Push Notification Service (APNS), Google Cloud Messaging (GCM), and the older Cloud
to Device Messaging (C2DM) framework, registers and deletes tokens through a REST
interface (via the Services module), and provides an admin interface for mass push
to all users with a registered token, with optional filtering by language.

> **Important compatibility warning.** This is an **alpha** release
> (`8.x-1.0-alpha2`) and it **fatals on Drupal 11.4 and cannot be used there.**
> One of its constraint validators carries a pre-Symfony-6 method signature that
> PHP rejects on class load against Symfony 7, and enabling it has been observed to
> take a site down hard enough that `drush` itself would not run — recovery
> required editing `core.extension` directly in the database. Verify compatibility
> with your exact Drupal/Symfony version on a disposable environment **before**
> enabling it on anything you care about. See the [Installation](installation/index.md)
> page for the details and safer alternatives.

Two things about the problem space are worth knowing regardless of which module you
use. **A device token is both a credential and personal data** — it identifies a
device and can be used to push to it — so the token store deserves a credential
store's protection and a retention rule, since tokens outlive the app installs that
created them. And **provider integration has moved on**: Apple retired the legacy
binary APNs interface in favor of HTTP/2 with token-based auth, and Google retired
the legacy FCM APIs in 2024, so check any module in this space (this one included)
against what the providers currently accept.

It has no hard module dependencies but needs the **Services** module (3.0) to
register device tokens via REST, plus provider credentials (APNS certificate, GCM
API key, or a C2DM-enabled Google account). It declares support for `^9 || ^10 ||
^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the
   compatibility caveat, and enabling the module.
2. [Configuration](configuration/index.md) — provider credentials (APNS/GCM/C2DM),
   the mass-push interface, language limits, and secret storage.

## Where it lives in the admin menu

Once enabled, the module adds its settings and the mass-push interface under
**Configuration**. This is where you enter provider credentials, send a mass push,
and (if you use it) activate PrivateMSG integration.
