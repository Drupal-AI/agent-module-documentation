# Spam Master — manual setup guide

**Spam Master** (`spammaster`) is a SaaS-backed anti-spam firewall for Drupal. It
blocks spam user registrations, comments, and posts using **real-time threat
lists** pulled from spammaster.org, and rounds that out with a honeypot on your
forms, an IP/email blacklist (its "buffer"), a whitelist for trusted visitors and
form IDs, and optional POST flood control. When it blocks someone, it serves a
branded firewall page showing their IP and browser.

It's designed to protect the anonymous-reachable forms that bots target —
registration, contact, comments — without adding a CAPTCHA. On install it
generates a random license key and automatically creates a **free** Spam Master
license by contacting spammaster.org; you can later upgrade to a Pro key for
higher-volume coverage. A daily sync (via cron) keeps the threat intelligence
current, and the SaaS backend can push updates to your site over an authenticated
endpoint.

Everything runs through a request-time firewall that exempts administrators and
whitelisted IPs, and it only actively blocks when your license is valid and the
site is in production mode — so you can pause protection instantly by flipping a
single setting. Threats, logs, and whitelist entries live in the module's own
database tables and are cleaned on schedules you configure. Admin is spread across
five tabbed forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   let it auto-create a free license.
2. [Configuration](configuration/index.md) — the five admin tabs, the key settings
   (firewall, honeypot, flood control, cleanup, license), and how to pause
   protection.

## Where it lives in the admin menu

All of Spam Master's admin sits under **Configuration → System → Spam Master**
(`/admin/config/system/spammaster`) as five tabs — *Settings*, *Protection Tools*,
*Spam Buffer*, *Whitelist*, and *Statistics & Log* — each gated by the core
**Administer site configuration** permission. It also defines a restricted
**Manage Spam Master** permission.

## How to use it

Install and enable the module; it contacts spammaster.org and sets up a free
license automatically. Review the **Protection Tools** tab to confirm the firewall
and honeypot are on, add any trusted IPs to the **Whitelist**, and watch the
**Statistics & Log** tab. To upgrade coverage, paste a Pro license key on the
**Settings** tab. See [Configuration](configuration/index.md) for the details.
