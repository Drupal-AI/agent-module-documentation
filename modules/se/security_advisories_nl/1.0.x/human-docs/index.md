# Security Advisories NL — manual setup guide

**Security Advisories NL** (`security_advisories_nl`) turns your Drupal site into a
central dashboard for Dutch cybersecurity advisories. It automatically fetches
advisories from trusted sources — the NCSC (the Dutch National Cyber Security Centre),
CSAF feeds, and RSS or WordPress endpoints — parses them, and stores each one as a
`security_advisory` content entity in your site. The maintainers compare it to a
"Bloomberg Terminal for threat intelligence": many authoritative sources consolidated
into one place, with a public listing your audience can browse.

Under the hood it uses a set of parser services (one each for NCSC, RSS, and WordPress
sources) behind an HTTP cache, feeding a fetcher that upserts advisory entities. A
queue handles batched fetching, CVE extraction, and severity updates in the
background, so you will want cron running for regular updates. A large admin control
panel gives you manual maintenance actions — fetch now, refetch full article content,
extract CVEs, update severity, clear the cache, process the queue, and clean up
duplicates — and there is a Drush command class for the same tasks. A "latest
advisories" block and two public routes render the advisories to visitors.

The module depends on core **Node** and **Views**, and it defines three permissions:
**administer security advisories nl** (the powerful one — it controls which external
URLs the site fetches from), **manage security advisories** (managing the stored
advisory entities), and **view security advisories** (read-only access to the public
listing). Because the fetch targets are entered through admin forms, only trusted
staff should hold the administer permission — that is the control that decides what
outbound requests your server makes. On the plus side, the module's review found no
SSRF or TLS problems: source URLs are validated, they come only from admin forms, and
the HTTP fetches keep normal TLS certificate verification on. Note the project is
**not covered by Drupal's security advisory policy** and is **minimally maintained**.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Node and Views).
2. [Configuration](configuration/index.md) — add advisory sources, run the fetch, and
   grant read access to your audience.

## Where it lives in the admin menu

The main settings live under the config route `security_advisories_nl.settings` at
**`/admin/config/system/security-advisories-nl`**, with a dedicated **sources**
sub-page at `/admin/config/system/security-advisories-nl/sources`. The public-facing
pages are **`/security-advisories`** (the listing) and
**`/security-advisory/{advisory}`** (a single advisory), both gated by *view security
advisories*.
