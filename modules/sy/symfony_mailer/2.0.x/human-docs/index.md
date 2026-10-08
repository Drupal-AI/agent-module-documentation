# Mailer Plus — manual setup guide

**Mailer Plus** (`symfony_mailer`) replaces Drupal's legacy mail system with a modern,
object‑oriented email pipeline built on the **Symfony Mailer** component. Core's
`MailManager` and `hook_mail` API are string‑oriented, plain‑text‑first, and awkward
to theme. Mailer Plus supersedes them with a structured `Email` object that flows
through defined phases (init → build → pre‑render → post‑render → post‑send), so
modules and processors can shape an email at exactly the right moment. The result is
real **HTML email**, rendered through a Drupal theme, with CSS automatically inlined
so it survives email clients, and a plain‑text alternative generated for you.

Every kind of email — user account mail, contact forms, Commerce orders, Simplenews
newsletters, update‑status notices, and more — is produced by a **component mailer**
and identified by a hierarchical tag such as `user__password_reset`. That tagging lets
you target configuration and code at one email type without touching the others.
Cross‑cutting behavior (the From address, a BCC, choosing a transport, converting to
plain text, skipping sending, and so on) is applied by **email processors** and, via
the Mailer Policy submodule, by configurable **policy** rules. Delivery goes through
pluggable **transports** — SMTP, Sendmail, a DSN string, native, or null.

Mailer Plus depends on core's **Filter** module and the bundled **Mailer Transport**
submodule, and it pulls in three Composer libraries (`symfony/mailer`,
`html2text/html2text`, and `css-to-inline-styles`) automatically. The base module
gives you a **verify** page to test that outgoing mail works; most of the real
configuration lives in three submodules — **Mailer Transport**, **Mailer Policy**, and
**Mailer Override** — which you enable as needed. All administration is gated by the
`administer mailer` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its libraries with
   Composer, enable it, and turn on the submodules you need.
2. [Configuration](configuration/index.md) — the verify page, and where transports,
   policies, and legacy overrides are configured.

## Where it lives in the admin menu

Everything sits under **Configuration → System → Mailer Plus**
(`/admin/config/system/mailer`). That landing page is the **verify** screen — it sends
a test email and reports whether outgoing mail and your transport are working — and it
links out to the submodule configuration: **Transports**
(`/admin/config/system/mailer/transport`), **Policies**
(`/admin/config/system/mailer/policy`), and the legacy **Override**
(`/admin/config/system/mailer/override`). See [Configuration](configuration/index.md)
for the details.
