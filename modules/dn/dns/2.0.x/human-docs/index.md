# DNS — manual setup guide

**DNS** (`dns`) lets you manage DNS zones and their records directly inside
Drupal, modelled as ordinary **content entities**. Instead of keeping zone files
in a text editor or juggling a provider's control panel, you create *zones* (like
`example.com`) and add *records* to them (A, AAAA, CNAME, NS, MX, TXT, PTR, CAA,
SRV, HTTPS, SVCB) through the normal Drupal admin UI, with DNS-aware validation
based on the relevant RFCs (including CNAME exclusivity rules).

Because zones and records are content entities, they work with the tools you
already know — Views, REST, JSON:API, and the entity access system. The module
also understands internationalized domain names: you can type a domain such as
`münchen.de`, and it is stored internally as Punycode while still being displayed
to you in Unicode. A built-in Views listing shows records, and each zone page
embeds a listing of its own records.

Access works in two layers. Site-wide **permissions** (assigned to roles) control
general capabilities such as creating zones or administering DNS, while **per-zone
collaborator delegation** lets you grant fine-grained rights (view/edit/delete a
zone, and CRUD its records) to specific users on specific zones. Records inherit
their access from the parent zone. The module works as soon as you enable it —
there is no settings form to fill in; you simply start creating zones and records.

Note that the 2.x branch is a complete rewrite of the old Drupal 7 module and is
currently **alpha** — great for testing and early adoption, but review it before
trusting it with production-critical DNS workflows. There is not yet any live
provider sync (Cloudflare, Route 53, PowerDNS, and similar are on the roadmap), so
today the module is a place to *model and manage* DNS data rather than to push it
to a provider automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `field_ipaddress` dependency) and enable the module.

There is **no configuration page** for this module — it has no central settings
form. You work with DNS data directly as content entities, as described below.

## Where it lives in the admin menu

DNS does not add a settings form. Once enabled, it registers **Zone** and
**Record** content entity types that you create, edit, and delete through the
standard Drupal admin UI, and an admin listing of records built with Views. Which
of these actions a user can take is governed by the DNS permissions at **People →
Permissions** (for example *create zones* and *administer DNS*) plus any per-zone
collaborator delegations you assign on individual zones.

## How to use it

1. Give the appropriate roles the DNS permissions at **People → Permissions**
   (administering DNS, creating zones, and so on).
2. Create a **zone** for each domain you want to manage (for example
   `example.com`). Unicode domains are accepted and normalized to Punycode
   automatically.
3. Inside a zone, add **records** — pick the record type (A, CNAME, MX, TXT, …)
   and fill in its values. The module validates each record against DNS rules as
   you save.
4. Optionally add **collaborators** to a zone to delegate specific capabilities
   (view/edit/delete the zone, or manage its records) to particular users.

If you are migrating from the Drupal 7 DNS module, the 2.x branch ships built-in
Migrate support for `dns_zones` and `dns_records`, with tolerant handling of
imperfect legacy data.
