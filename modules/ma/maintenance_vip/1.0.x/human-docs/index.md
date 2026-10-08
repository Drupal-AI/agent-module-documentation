# Maintenance VIP Bypass — manual setup guide

**Maintenance VIP Bypass** (`maintenance_vip`) grants chosen visitors access to a
site that's in maintenance mode by having them visit a secret URL — no user
account, no login, no IP whitelisting required. It's built for the common
pre-launch situation where you need to let a client, a stakeholder, or a QA team
review the site while it stays locked to everyone else.

Here's how it works. You set a secret token in the module's configuration. You
then share a link of the form `https://yoursite.com/vip/<your-token>`. When a VIP
visits that URL, the module hands their browser a secure, HTTP-only cookie valid
for 24 hours, and a decorated maintenance-mode service treats cookie holders as
exempt — so they can browse the site normally while the maintenance page stays up
for the public. A `/vip-logout` route lets them drop the cookie and end their VIP
session.

Because it uses a cookie rather than an IP address, it works cleanly for people
on mobile networks, corporate VPNs, or dynamic IPs, and it behaves well behind
Nginx, Varnish, or a CDN. The trade-off is that the token is a **shared secret in
a URL** — effectively a bearer password. Anyone who has the link gets 24 hours of
access, so treat it exactly like a password: choose a **long, random, unguessable
token**, share it only over trusted channels, and rotate it after a review is
done. Note that an **empty** token cannot be used to bypass anything — the module
refuses an empty configured token — so always set a real one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the secret token and share the
   VIP link safely.

## Where it lives in the admin menu

The module's settings are at **Configuration → Development → Maintenance VIP**
(`/admin/config/development/maintenance-vip`), gated by the **Administer
maintenance VIP** (`administer maintenance vip`) permission.
