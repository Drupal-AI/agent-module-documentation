# Restrict By IP — manual setup guide

**Restrict By IP** (`restrict_by_ip`) limits **who can log in** and **which roles
are active** based on the visitor's IP address. You supply allow‑lists of IP
ranges in CIDR notation (IPv4 or IPv6), and the module enforces them in three
independent layers: a **global login** list that applies to every login, a
**per‑user** list set on the user edit form, and a **per‑role** list that strips a
role from anyone whose IP is outside its ranges. Typical uses are pinning admin
logins to an office or VPN range, or keeping a privileged role's permissions
available on‑network but revoked off‑network.

The module "fails closed": a list that is configured but doesn't match the request
denies access, and a malformed range never matches — so mistakes err toward
restriction rather than leaking access. Login denials are shown as an inline error
on the login form (so no session is ever created), and an already‑authenticated
user whose IP falls out of range is logged out and redirected. Per‑role
restrictions are re‑evaluated on **every request**, so a role can appear and
disappear as a user's IP changes.

Crucially, the client IP comes from Symfony's `Request::getClientIp()`, which uses
the real connecting socket address and only honors `X-Forwarded-For` when the
request comes from a **trusted reverse proxy that you've configured in
`settings.php`**. That means it's safe against a spoofed header by default, but it
also means you *must* configure Drupal's trusted‑proxy settings correctly behind a
load balancer — otherwise every request looks like it came from the proxy.

> ## ⚠️ Lockout warning
>
> It is easy to lock yourself out with this module — for example by setting a
> global login range that doesn't include your own IP. A one‑time login link does
> **not** rescue you: the IP firewall signs you straight back out. Before you turn
> on a restriction, make sure your own address is covered, and know the recovery
> path — the `drush restrict_by_ip:allow` and `restrict_by_ip:status` commands
> described in [Configuration](configuration/index.md).

Restrict By IP requires **Drupal 11.3+ / 12**, has no dependencies beyond core,
and defines a single permission, **Administer restrict by IP** (a restricted‑access
permission that also gates the per‑user IP field). It provides two Drush commands
and a set of alter hooks for supplying ranges at runtime.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the login, per‑user, and per‑role
   restriction forms field by field, reverse‑proxy notes, the Drush commands, and
   lockout recovery.

## Where it lives in the admin menu

Settings live at **Configuration → People → Restrict by IP**
(`/admin/config/people/restrict_by_ip`), with sub‑forms for login and role
restrictions. Per‑user ranges are set in a "Restrict by IP" area on each user's
add/edit form. All of it requires the **Administer restrict by IP** permission.

## How to use it

Decide which layer you need. For a site‑wide login lock, enter your allowed ranges
on the **login** settings form. To pin one account, edit that user and fill in
their personal ranges. To make a role network‑dependent, add ranges under the
**role** settings form. An empty list means "no restriction" for that layer; a
non‑empty list means the IP must fall inside at least one range. See
[Configuration](configuration/index.md) for the details and the all‑important
recovery commands.
