# Advanced Ban — manual setup guide

**Advanced Ban** (`advban`) is a drop-in replacement for Drupal core's Ban
module that blocks unwanted visitors by IP address — but with everything core's
Ban leaves out. On top of banning a single address you can ban a whole IPv4
range, give each ban an expiry date so the visitor is unbanned automatically
after an hour, a day or a week, record a free-text reason for the ban, and keep
a protected (allow-listed) list of IPs that can never be banned by accident.

Bans are enforced by an HTTP middleware that runs *before* Drupal's page cache,
so a banned client can never be served a cached page — they get a plain `403`
response with a message you can customise. The protected list always wins: on
every request the module checks whether the visitor's IP is protected first, and
only then whether it is banned. Expired bans are cleaned up automatically on
cron, and when you first install the module it imports any addresses already
banned through core's Ban module.

Everything lives behind a single permission and one admin section at
**People → Advanced Ban** (`/admin/config/people/advban`), where you can add,
search, edit, bulk-delete and configure bans. Developers can also ban, unban and
check IPs from code through the `advban.ip_manager` service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the ban list, the add-ban form, and
   the settings that control durations, protected IPs and ban messages.

## Where it lives in the admin menu

Once enabled, Advanced Ban adds an administration section at **Configuration →
People → Advanced Ban** (`/admin/config/people/advban`). That page shows the
current ban list and the form for adding a new ban; tabs across the top take you
to **Search** (find which entry bans a given IP), **Delete all** (bulk deletion)
and **Settings** (durations, protected IPs and ban messages). All of it is gated
by the single **Ban IP addresses** permission.

## How to use it

To ban an address, go to **Configuration → People → Advanced Ban**, type the IP
into the **IP address** field, optionally add an end address to ban a whole
IPv4 range, pick an expiry duration and write a reason, then click **Add**. The
ban takes effect on the next request from that address. To let a ban lift itself
after a set time, choose one of the expiry durations instead of *never*; cron
will delete it once it expires. To make sure your own office or monitoring
addresses can never be banned, add them to the protected list on the Settings
tab.
