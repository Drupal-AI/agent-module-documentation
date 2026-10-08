# Secure Password Reset Log — manual setup guide

**Secure Password Reset Log** (`secure_password_reset_log`) adds a security layer around
Drupal's password-reset process. Where core simply sends the reset email, this module
**logs every reset request** — successful and failed — **monitors** for suspicious
patterns, and applies **flood control** to slow down and eventually block abusive
bursts of requests. The result is an audit trail of who is asking for password resets,
plus automatic protection against reset-flooding and enumeration abuse.

It is designed for sites that need higher security standards — e-commerce, membership
portals, enterprise applications — anywhere account abuse is a real concern. You get
configurable thresholds and time windows for blocking excessive requests, per-IP and
per-account monitoring of repeated attempts, and administrative visibility into reset
behaviour through the logs. The module works silently in the background; it creates no
content types or text formats and does not change the reset workflow your users see.

The logs it keeps are security-sensitive, so access is gated by two permissions:
**view secure password reset logs** (to read the log data) and **administer secure
password reset logs** (to change settings). Grant the view permission only to trusted
roles. The module depends on core's **User** module and requires **Drupal 11**.

It also has two optional integrations. If you run the **Flood Control** or **Security
Kit (Seckit)** modules they complement it well, and from version 1.0.2 it can emit
**CrowdSec** signals for suspicious reset activity when the CrowdSec Drupal module is
installed and configured — a purely optional integration with no hard dependency.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set logging preferences, flood limits,
   and blocking thresholds.

## Where it lives in the admin menu

The settings page is under **Configuration → Security → Secure Password Reset Log**,
reachable at **`/admin/config/security/password-reset-flood`**. Reset events are
recorded there and also flow into Drupal's normal log reports (`/admin/reports/dblog`).
