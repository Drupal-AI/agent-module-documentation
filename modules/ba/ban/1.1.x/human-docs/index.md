# Ban — manual setup guide

**Ban** (`ban`) lets administrators block visits to a Drupal site from individual
IP addresses. A banned address gets a plain **403** response very early in the
request — before Drupal renders a page or serves it from cache — so a spambot,
scraper, or abusive visitor is turned away cheaply. This is the contrib
continuation of Drupal's former core Ban module, so if you have used "banned IPs"
on an older site, this is the same feature living on as a contributed project.

You manage the ban list from an admin page: add a single IPv4 or IPv6 address to
ban it, and select one or more addresses to unban. Bans are stored in a dedicated
database table and enforced by an HTTP middleware that runs before the page cache.
An **allowlist** — defined only in `settings.php` — protects chosen IPs or whole
subnet ranges so they can never be banned, which is a good place to put your
office or static company address so nobody accidentally locks it out. The admin
form also refuses to let you ban your own current IP.

There are a couple of deliberate limits. The ban list accepts **single addresses
only** — subnet ranges are not supported there, for performance (ranges are only
allowed in the allowlist). Ban has **no configuration object** of its own; the old
`ban.settings` config was removed. Alongside the UI, it ships CLI commands
(`ban:ban`, `ban:unban`, `ban:list`, `ban:flush`) for scripting, a service so
custom code can ban programmatically, and a Drupal 7 migration for blocked IPs.
Access to the admin page is gated by the **Ban IP addresses** permission. Ban runs
on Drupal 11.2+ / 12 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the IP‑bans admin page, how bans are
   stored, and the `settings.php` allowlist.

## Where it lives in the admin menu

Once enabled, the ban management page sits at **Configuration → People → IP
address bans** (`/admin/config/people/ban`). Reaching it requires the **Ban IP
addresses** permission (`ban IP addresses`), a trusted permission since it lets a
user block site access by IP.
