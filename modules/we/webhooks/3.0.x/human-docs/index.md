# Webhooks — manual setup guide

**Webhooks** (`webhooks`) lets your site trade HTTP callbacks with other systems.
It works in two directions. **Outgoing** webhooks POST a JSON or XML payload to a
remote URL whenever something happens in Drupal — a node is created, a user logs
in, cron runs, and so on. **Incoming** webhooks give you an endpoint that outside
services (GitHub, Stripe, an automation platform like Zapier or Make) can POST to,
and Webhooks turns each received request into a Drupal event that other modules
can act on.

Each webhook is a small configuration entity you create in the admin UI. You pick
its direction (incoming or outgoing), the target URL (for outgoing), the payload
format, and — importantly for security — an optional shared **secret** used to
sign or verify the request with an HMAC signature, or a legacy **token**. For
outgoing webhooks you also choose exactly which entity and system events it should
react to.

Because the payloads and the signing secret are sensitive, keep secrets out of
version control — set them per environment (for example via `settings.php`
overrides or environment variables) rather than committing them to exported
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether you need the optional storage submodule.
2. [Configuration](configuration/index.md) — create and edit webhook entities,
   incoming vs outgoing, and the module settings, field by field.

## Where it lives in the admin menu

The webhook list sits at **Configuration → Web services → Webhooks**
(`/admin/config/services/webhook`), gated by the **Administer webhooks**
permission. Incoming webhooks are received at the public URL
`/webhook/{machine_name}` — that endpoint is deliberately not permission-gated and
is instead protected by the per-webhook secret or token you configure.
