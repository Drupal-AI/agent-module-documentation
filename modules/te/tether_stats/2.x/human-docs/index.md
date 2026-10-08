# Tether Stats — manual setup guide

**Tether Stats** (`tether_stats`) is a self-contained site-statistics system. It
tracks page hits, link clicks and impressions itself and stores the data in your
Drupal database, so you can collect usage analytics without sending visitor data
to Google Analytics or any other third-party service.

The problem it solves is a gap between "core statistics / Google Analytics" and
the detail some sites actually want. Tether Stats records events on the front
end with a small AJAX-style JavaScript call — which also keeps most bots from
polluting the data — and ties that activity back to your Drupal structure. An
impression, for example, is counted when an item such as a link, a name or an
image appears on a page and is visible to the user; you enable it simply by
adding classes to your HTML. Collected data can reference not just nodes but any
entity type, and it is automatically aggregated into hourly increments in a
separate table to make reporting and data-mining easier. The module also
includes chart rendering (Combo and Pie charts) through a pluggable renderer,
with a Google Charts plugin used by default. The maintainers describe it as
aimed at intermediate-to-advanced Drupal developers.

The trade-off to be clear-eyed about is privacy. Keeping analytics in-house is
an advantage, but it also means your own site is now recording visitor
activity. That data can be personal in aggregate, so it deserves a retention
approach, and the reports should be restricted to staff. Self-hosting analytics
shifts the privacy responsibility onto the site rather than removing it.

Tether Stats works on Drupal 10 and 11, has no contrib module dependencies
(only PHP itself), provides its own permissions, and ships no submodules. There
is no central settings form; it surfaces through its permissions, its tracking
markup, and its reporting/charting features rather than through a single
configuration page.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, Tether Stats begins recording activity via its front-end
JavaScript. Page hits are tracked automatically; to track link clicks and
impressions you add the module's classes to the relevant HTML so it knows what
to count. Reporting and the built-in charts then draw on the collected data.
Because the data can be sensitive, review the module's permissions and grant the
reporting/administration permissions only to trusted staff roles.
