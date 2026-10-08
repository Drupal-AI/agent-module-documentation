# Restrict IP — manual setup guide

**Restrict IP** (`restrict_ip`) locks a whole Drupal site down to an
administrator‑defined **allowlist of IP addresses**. Any visitor whose IP is not
on the list is shown a themeable "Access Denied" page instead of the content they
asked for. It is the standard way to keep a staging site, pre‑launch site, or
back‑office admin site private to your office, VPN, or a fixed set of known
addresses.

The check runs very early on every request (from an event subscriber on
`kernel.request`), so blocked visitors never see your blocks, JavaScript, or
cached pages — just the Access Denied page, which can carry a contact email so
they know how to request access. Beyond the basic allowlist you can: let certain
**roles bypass** the restriction (e.g. editors working from home); **whitelist**
specific paths so a few pages stay public, or **blacklist** only a few sensitive
paths; log blocked attempts to Drupal's log; and — with the optional
[ip2country](https://www.drupal.org/project/ip2country) module — allow or deny by
**country**.

Two safety details are worth knowing before you switch it on. First, the master
switch is **off by default**, so nothing is blocked until you enable it. Second,
because it is possible to lock *yourself* out, the allowed list and the enable
flag can also be forced from `settings.php` — the documented escape hatch if you
ever get shut out. A Drush command lets you flip the restriction on or off from
the command line. The module depends on core's **Block** and **User** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field:
   the allowed IP list, role bypass, page white/blacklist, country filtering,
   plus the `settings.php` overrides and lockout recovery.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → People → Restrict IP**
(`/admin/config/people/restrict_ip`). Reaching it requires the **Administer
restricted IP addresses** permission (`administer restricted ip addresses`), which
is a trusted, restricted permission because it controls who can access the site.
The restriction itself does not take effect until you tick **Enable Restricted
IPs** and add at least one allowed address.
