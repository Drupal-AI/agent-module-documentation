# Analyze Broken Links — manual setup guide

**Analyze Broken Links** (`analyze_broken_links`) is a submodule of the
[Analyze](https://www.drupal.org/project/analyze) content-analysis framework that checks
your content for broken links — both internal and external. It crawls the links found in
your content, makes outbound HTTP requests to them, and reports which ones fail (for
example a 404 or a timeout), with the results integrated into Analyze's reporting.

Use it to find dead links across your content before your visitors do. It is an
administrator/content-QA tool, not a public feature: running the check requires the
**Administer analyze settings** permission, and only that trusted operator can trigger
the crawl. Because the checker fetches the URLs that appear in your content, the request
targets come from your existing content links and the crawl can only be started by an
admin — so the outbound-request surface stays limited to trusted people. The module has
no access-control role beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## Where it lives in the admin menu

The broken-link check is part of the Analyze framework. Its run/settings route requires
the **Administer analyze settings** permission, and its findings are surfaced through
Analyze's reporting.

## How to use it

With the module enabled and the **Administer analyze settings** permission granted, run
the broken-link analysis to crawl the internal and external links in your content. The
report lists the links that returned errors (404s, timeouts) so you can fix or remove
them. Because the crawl makes real outbound requests, run it as a trusted administrator.
