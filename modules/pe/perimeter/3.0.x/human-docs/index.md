# Drupal Perimeter Defence — manual setup guide

**Drupal Perimeter Defence** (`perimeter`) bans the IP address of any visitor who
triggers a 404 ("page not found") for a URL that matches a configured list of
suspicious patterns — things like `wp-admin`, `.aspx`, or `.jsp`. It is a
lightweight way to fend off the bots and vulnerability scanners that constantly
probe sites for endpoints that do not exist on a Drupal install.

The module works through a single event subscriber. When a request throws a 404,
the subscriber compares the request path against a regex list in its settings. On
a match it hands the client IP to Drupal core's **Ban** module, which stores it in
the `ban_ip` table and then returns a 403 for every subsequent request from that
IP. An optional flood threshold and window let you give offenders a grace count
(for example, ban only on the third probe within an hour) instead of banning on
the first hit. A whitelist of IPs and CIDR ranges, plus a bypass permission,
exempt trusted clients.

It is deliberately tiny and cache-friendly: bans fire only on *uncached* 404
exceptions, so legitimate cached traffic is untouched. It also integrates with the
Honeypot module to ban IPs that fail a honeypot check. Because Perimeter only
*adds* bans, you view and remove them on core Ban's own admin page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the Ban
   dependency, and enable it.
2. [Configuration](configuration/index.md) — the ban patterns, the whitelist, the
   flood threshold and window, and the permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Perimeter**
(`/admin/config/system/perimeter`). Banned IPs are managed separately on core
Ban's page at **Configuration → People → IP address bans**
(`/admin/config/people/ban`).

## How to use it

Enable the module and it starts protecting the site immediately using a built-in
list of about a dozen common probe patterns — there is nothing you *must*
configure. Use the [Configuration](configuration/index.md) page to add your own
patterns, whitelist trusted IPs, or soften the banning with a flood threshold.
