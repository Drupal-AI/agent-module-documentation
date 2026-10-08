# Statistics Rolling Period — manual setup guide

**Statistics Rolling Period** (`statistics_rolling`) extends Drupal core's
Statistics module so that view counts are tracked over a **rolling time window**
instead of only as an all-time total. For example, you can ask "how many times was
this node viewed in the last 15 days?" — which makes popularity reflect recent
activity rather than everything that ever happened.

The problem it solves is recency. An all-time counter tells you what has been
popular forever, but not what is popular *now*. By counting views within a moving
window, this module gives you recency-weighted popularity that you can use to
surface currently-trending content. It counts views via AJAX, so it keeps working
even behind a caching layer such as Varnish, and it exposes a Views field for the
daily counts across the rolling period so you can build your own reports.

It depends on core's Statistics module and needs a little configuration to work:
core Statistics' own "count content views" option must be on, and you set the
length of the rolling period. The module does not yet reproduce every feature of
core Statistics, but it covers the rolling-window use case.

A privacy note worth keeping in mind: like all view-tracking, this records viewing
activity, which can be personal data. Minimize and anonymize what you keep,
disclose it per your privacy policy, and make sure any report built on it is gated
behind an appropriate permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer command,
   and enabling the module.
2. [Configuration](configuration/index.md) — turning on core view counting,
   setting the rolling period, and using the Views field.

## Where it lives in the admin menu

There is no separate settings form of its own — the rolling period is configured
on core's Statistics settings page at **Configuration → System → Statistics**
(`/admin/config/system/statistics`). The daily-count data is exposed as a field in
Views.
