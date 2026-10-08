# Group Sitemap — manual setup guide

**Group Sitemap** (`group_sitemap`) extends the
[Group](https://www.drupal.org/project/group) module by generating a separate XML
sitemap for each group, listing that group's content. Each sitemap is served at
`/group/{group}/sitemap.xml` (with an XSL stylesheet so it's readable in a
browser), giving search engines a per‑group map of URLs to crawl.

Crucially, it respects content visibility. A URL is only included in a group's
sitemap if both the relationship and the target entity are viewable by the
**anonymous** user. Restricted or members‑only content is therefore filtered out
of the public sitemap automatically.

A note on how that safeguard works, so you set it up with the right expectations:
the sitemap route itself is anonymous by design — the protection is applied *per
entry*, by checking each item's view access as the anonymous user, rather than by
locking down the endpoint. The effect is that only content a member of the public
could already see ends up listed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group.

There is **no settings form in the admin UI yet**. As the project notes, the
module is configured through configuration files for now — a UI is on the roadmap.
See "How to configure it" below.

## Where it lives

Each group's sitemap is available at `/group/{group}/sitemap.xml` (replace
`{group}` with a group's ID). There's no admin menu page; the sitemaps are the
front‑facing part of the module.

## How to configure it

Group Sitemap does not yet provide a settings screen — configuration is handled
through Drupal's configuration files (see the module's own `README.md` for the
current options and defaults). Adjust the shipped configuration and import it with
your usual configuration workflow (`drush config:import`, or editing exported YAML
in a config‑managed site).

Because it builds on Group, make sure Group is installed with at least one group
type and some group content before expecting a sitemap to contain anything.
