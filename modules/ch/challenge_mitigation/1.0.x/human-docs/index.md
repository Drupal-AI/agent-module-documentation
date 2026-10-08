# Challenge Mitigation — manual setup guide

**Challenge Mitigation** (`challenge_mitigation`) is a lightweight IP-whitelisting
and challenge layer for Drupal 10+. It enforces a one-time challenge — a
JavaScript check or a form submission — when visitors reach specific parts of your
site. Once a visitor passes, their IP is whitelisted for a duration you choose, so
real users get a smooth experience while automated abuse is slowed down. It's a
pragmatic way to soft-gate exposed endpoints such as `/user`, `/search`, or
`/contact` without forcing login or hard rate limits, reducing spam and automated
attacks.

**It is not a WAF, and doesn't pretend to be.** The maintainers are explicit: a
dedicated Web Application Firewall remains the most robust defense against complex
threats and high-volume (volumetric) attacks. Challenge Mitigation acts *after*
requests reach Drupal, so it can't match a WAF's speed or power — it's a reasonable
compromise for environments where a full WAF isn't affordable or available. Tune
which paths and thresholds you protect to your own needs.

It offers three **challenge modes**: *Automatic JS* (an invisible, auto-submitting
JavaScript check requiring no user interaction), *Hard* (the user manually submits
a form, with CAPTCHA if you enable that integration), and *Adaptive Hard*
(automatically uses the hard challenge for suspicious User-Agents and the invisible
one for everyone else). It supports an optional full-site protection mode,
manual IP whitelisting (IPv4, IPv6, and CIDR ranges), manual User-Agent
whitelisting via regular expressions, optional CAPTCHA integration, and cron-based
cleanup of expired whitelist entries. It provides its own permissions and supports
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and optionally CAPTCHA).
2. [Configuration](configuration/index.md) — choose challenge modes, define
   protected paths, and manage whitelists.

## Where it lives in the admin menu

The settings form is at **Configuration → Security → Challenge Mitigation**, and
whitelist entries are managed at **Configuration → Security → Challenge
Mitigation → Whitelist IPs**.
