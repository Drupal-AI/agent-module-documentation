# Access Filter — manual setup guide

**Access Filter** (`access_filter`) restricts access to your site — or to parts
of it — by the visitor's IP address. The rules are stored as Drupal
configuration entities, so they travel with your site's configuration and can be
deployed between environments without touching the web server.

IP restriction is the layer that identity cannot provide. A stolen password
matters far less if the administrative interface only answers requests from known
networks. It is also how a staging site stays private before launch, how a
partner integration is confined to the addresses that should be calling it, and
how an abusive source is cut off quickly — faster than a permissions change can
be planned. You manage the rules at **Configuration → People → Access Filter**
(`/admin/config/people/access_filter`), behind a `manage access filters`
permission.

Three things determine whether the restriction is real rather than merely
reassuring, and they are important enough to state plainly:

- **The client IP must be correct.** Behind any CDN or load balancer, Drupal's
  `reverse_proxy` and `reverse_proxy_addresses` settings (in `settings.php`) must
  be configured. Without them Drupal sees the *proxy's* address, and it trusts an
  `X-Forwarded-For` header that the caller can write — which inverts the control
  entirely and lets an attacker spoof an allowed address.
- **Treat `manage access filters` as an administrative permission.** It governs
  who may reach the site, so grant it only to fully trusted roles.
- **The web server or CDN is usually the stronger place for this.** A rule
  enforced before PHP even starts costs nothing, cannot be bypassed by an
  application bug, and survives a Drupal that will not boot — which is precisely
  when an IP restriction matters most. Reach for Access Filter where the
  infrastructure is not yours to configure, or where the rules must travel with
  the site's configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and manage IP access rules.

## Where it lives in the admin menu

Once enabled, the rule collection lives at **Configuration → People → Access
Filter** (`/admin/config/people/access_filter`).
