# Login Security — manual setup guide

**Login Security** (`login_security`) hardens Drupal's login form against
brute‑force and password‑guessing attacks. It tracks failed login attempts and
can automatically block user accounts or ban host IP addresses once they cross the
thresholds you set — protection that core's built‑in flood control doesn't provide
on its own.

Every login attempt (username, IP address, timestamp) is recorded in a tracking
table. On each submission, the module counts the recent failures inside a sliding
**tracking window** and applies your limits: a **per‑user** limit that blocks the
account after too many failures (no matter which host is attacking), a per‑host
**soft** limit that stops an IP from submitting the login form (while still letting
it browse anonymously), and a per‑host **hard** limit that IP‑bans the host
outright. Hard IP banning is delegated to Drupal core's **Ban** module (or the
contrib **AdvBan** module), so one of those must be installed for hard bans to
work.

Beyond blocking, Login Security adds an **attack‑detection** threshold that watches
the total volume of failed logins across the whole site and logs a warning (and
optionally emails administrators) when a coordinated attack appears to be underway.
It can also hide core's login error messages to prevent username enumeration, warn
users how many attempts they have left, and show last‑login / last‑access
timestamps on a successful sign‑in. Every user‑facing message and notification
email is customizable with tokens. It runs **alongside** — not instead of — core's
login flood control, and old tracking rows are cleaned up on cron.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and install Ban/AdvBan for hard IP banning.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   thresholds, soft/hard blocking, attack detection, notifications, and messages.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Login Security**
(`/admin/config/people/login_security`). It's gated by core's **Administer site
configuration** permission (Login Security defines no permissions of its own).

## How to use it

1. Enable the module (and Ban or AdvBan if you want hard IP bans).
2. Open the settings form and set your thresholds — how many failed attempts are
   allowed per account and per IP, and the tracking window.
3. Optionally turn on attack detection, notification emails, and the
   username‑enumeration protection.
4. Save. From then on, accounts and IPs that exceed the limits are blocked or
   banned automatically.

> **Heads‑up:** Blocks are **not** auto‑lifted. A blocked account must be
> re‑enabled at **People** (`/admin/people`), and a banned IP must be removed from
> the Ban module's admin screen (`/admin/config/people/ban`).
