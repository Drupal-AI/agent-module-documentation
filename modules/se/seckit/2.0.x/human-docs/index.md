# Security Kit — manual setup guide

**Security Kit** (`seckit`, often shortened to SecKit) hardens a Drupal site
against common web attacks by adding and configuring **HTTP security response
headers** — Content Security Policy, X-Frame-Options, HTTP Strict Transport
Security (HSTS), and more. Browsers read these headers on every response and
enforce the rules they describe, which lets a single admin form mitigate
whole classes of attack — cross-site scripting (XSS), clickjacking, cross-site
request forgery (CSRF), and SSL-stripping — without writing any code or editing
your web-server configuration.

Under the hood SecKit builds and sends the headers you enable on every page via
an event subscriber, and stores everything in one exportable configuration
object (`seckit.settings`). This guide is written for a **human** clicking
through the admin UI: it walks you step by step, with screenshots, from
installing the module to turning on each header safely. If you are looking for
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Security Kit settings page with its collapsible sections](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits on a single page: **Configuration → System →
Security Kit** (`/admin/config/system/seckit`). Access is gated by the
**administer seckit** permission. The page is organised into collapsible
sections, one per family of protections:

- **Cross-site Scripting** — Content Security Policy and the legacy
  X-XSS-Protection header.
- **Cross-site Request Forgery** — an Origin/HTTP-referrer based CSRF check.
- **Clickjacking** — X-Frame-Options plus an optional JavaScript-based
  anti-framing technique.
- **SSL/TLS** — HTTP Strict Transport Security (HSTS).
- **Expect-CT** — Certificate Transparency enforcement.
- **Feature policy** — a Feature-Policy / Permissions-Policy string.

## Contents

1. [Installation](installation/index.md) — install Security Kit with Composer
   and enable it.
2. [Configuration](configuration/index.md) — work through each section of the
   settings form and turn on the headers your site needs, testing CSP safely
   before you enforce it.
