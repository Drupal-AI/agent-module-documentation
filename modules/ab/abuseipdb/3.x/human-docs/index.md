# AbuseIPDB — manual setup guide

**AbuseIPDB** (`abuseipdb`) connects your Drupal site to
[AbuseIPDB](https://www.abuseipdb.com/), a crowd-sourced database of malicious IP
addresses. It works in two directions: it can **report** IP addresses that
misbehave on your site to AbuseIPDB, and it can **ban** visitors whose IP has a
bad reputation according to AbuseIPDB's data. It is a security and
abuse-mitigation tool.

Banning is handled through two optional submodules so you can plug into whichever
ban mechanism your site already uses: **`abuseipdb_core_ban`** integrates with
Drupal core's Ban module, and **`abuseipdb_advban`** integrates with the Advanced
Ban (advban) module. Enable whichever one matches your setup.

Two operational cautions apply to any reputation-based blocking, and they are
worth taking seriously. First, **false positives** happen: shared addresses,
carrier-grade NAT, and VPN exit nodes can all carry a bad reputation that is not
the fault of the person currently behind them, so review what gets auto-banned
rather than trusting it blindly. Second, **reporting sends IP data to a third
party**, which for the IP addresses of logged-in users has a privacy dimension.
Used judiciously, it adds a genuine layer of defence against known-bad traffic.

The module needs an **AbuseIPDB API key**, which is a credential and should be
kept out of plain configuration — store it in an environment variable. The module
provides its own permissions, so restrict its administration to trusted admins.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

> **Note on the available documentation.** The upstream agent docs describe the
> module's behaviour but do not spell out an exact settings-page path or a
> field-by-field breakdown of its forms, so the setup described here is
> high-level. Confirm the specifics against the module's own README once it is
> installed.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, choose a ban submodule, and store your API key.

## How to use it

After enabling the base module and one of the ban submodules, provide your
AbuseIPDB API key (stored in an environment variable — see Installation). From
there you can choose to report offending IPs to AbuseIPDB and to ban incoming
visitors based on their AbuseIPDB reputation. Start conservatively: review what
the module would auto-ban before relying on it in production, keeping the
shared-IP and VPN caveats above in mind, and grant its administration permission
only to trusted staff.
