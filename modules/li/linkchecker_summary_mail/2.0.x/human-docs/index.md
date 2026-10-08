# Link Checker Summary Mail — manual setup guide

**Link Checker Summary Mail** (`linkchecker_summary_mail`) emails a periodic
summary of what the [Link
Checker](https://www.drupal.org/project/linkchecker) module has found. Link
Checker does the heavy lifting — scanning your content's links and building a
report of the broken ones — and this module makes sure someone actually sees
that report by sending it out on a schedule.

The reason it exists is simple: a broken-links report is only useful if someone
looks at it, and on most sites nobody does. Broken links then pile up quietly
until a visitor complains or an audit turns them up. A scheduled summary inverts
that — the findings arrive in an inbox, where the people who can fix them already
are.

Two decisions make or break the feature, and both are yours to make when you
configure it. First, **how often** the digest goes out: too frequent and it
becomes noise people filter away; too sparse and problems sit for weeks. Second,
**who receives it**: "the webmaster address" usually means nobody, whereas the
people who can actually fix a broken link are the ones who own the content it
lives in. A good digest also distinguishes links that *just* broke from the
standing backlog, so the three new failures this week aren't buried under the
hundred that have been broken for a year.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Link
   Checker, and enable it.
2. [Configuration](configuration/index.md) — set the sending schedule and the
   recipients for the summary email.

## Where it lives in the admin menu

Link Checker Summary Mail adds its email-summary options to your site's Link
Checker configuration (under **Configuration → Content authoring → Link
checker**). See [Configuration](configuration/index.md) for the settings it
exposes.

> **A caveat on link checking generally:** a checker requests every external
> link on a schedule, which is real traffic to other people's sites from yours.
> Keep the checking interval reasonable and honour any rate limits — an
> aggressive checker is indistinguishable from a scraper. That interval is set
> in Link Checker itself; this module only decides how often you're *told* about
> the results.
