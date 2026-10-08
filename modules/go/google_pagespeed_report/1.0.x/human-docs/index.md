# Performance Monitoring (PageSpeed) — manual setup guide

**Performance Monitoring (PageSpeed)** (`google_pagespeed_report`) records the
performance of your pages over time and shows the results in admin reports. It
measures page speed — typically through Google's PageSpeed Insights service — and
keeps a history so your team can watch trends and tell whether a change made the
site faster or slower.

The module works as a monitoring-and-reporting tool: it collects performance
measurements, stores them, and presents them back to you in dashboards inside the
admin area. Because the measurements come from Google's PageSpeed Insights API,
you will need a Google API key, which is configured on the site and should be kept
as a secret rather than committed to code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supply the PageSpeed API key and
   store it securely.

## How to use it

Once installed and given an API key, the module records page performance and
surfaces it in its reports section of the admin area. Review those reports
periodically to track site speed and spot regressions after deployments.
