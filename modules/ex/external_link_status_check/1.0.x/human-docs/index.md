# External Link Status Check — manual setup guide

**External Link Status Check** (`external_link_status_check`) keeps an eye on the
outbound links in your content. It scans your content entities for external URLs,
records them in a tracking table, checks whether each one still responds, fetches
a little metadata about it, and flags the ones that have gone dead — so editors
can find and fix broken outbound links before your visitors (or a search engine)
stumble across them.

The work happens quietly in the background. When content is created or updated,
and again on each cron run, the module notices the external links and schedules
status checks through Drupal's Queue API rather than blocking the page request.
That keeps things responsive even on large sites with a lot of content. The
results collect in an admin report you can review and export.

This is a monitoring and reporting tool, so it fits SEO audits, content-quality
reviews, editorial link-integrity checks, and compliance or accessibility
reporting. Because it fetches external URLs from your server while scanning, run
it against content you trust and be mindful that scanning generates outbound
requests from your site. It depends only on core's Link and Node modules and
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — run a manual scan and read the
   broken-link report.

## Where it lives in the admin menu

There are two places to look once the module is enabled:

- **Link scanner** at **Configuration → System → External Link Scan**
  (`/admin/config/system/external-link-scan`) — a page with a single **Start Full Scan**
  button that scans all supported content on demand (there are no tunable options here).
- **The report** at **Reports → External Links**
  (`/admin/reports/external-links`) — see the tracked links, their status, and an
  export option.

Both pages sit behind admin paths, so only users with the appropriate
permissions can reach them.
