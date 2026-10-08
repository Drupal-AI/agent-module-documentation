# DrupalFit — manual setup guide

**DrupalFit** (`drupalfit`) is a site audit and reporting module. From a single
report interface it runs pluggable checks across your site — security, performance,
configuration, and general best‑practice — and presents scored results, findings
grouped by severity, and actionable recommendations. The goal is to give both
developers and business stakeholders a clear, ongoing read on a site's "fitness"
without digging through settings by hand.

The problem it solves is site health visibility. Instead of manually inspecting
permissions, caching, cron, aggregation, and configuration one page at a time,
you open the DrupalFit Report and get an overall site score, category scores for
key areas, and a prioritised list of what to fix. Reports are saved so you can
review history over time. The core audit runs entirely on your own site.

There is an **optional** cloud side: you can register at DrupalFit.com, generate
an API key, and connect the module to the DrupalFit platform for enhanced **SEO**
and **accessibility** reporting. This is entirely optional — leave it unconfigured
and the core, on‑site audit still works. If you do connect it, note that the API
key is a credential and that reports can reveal detailed site and configuration
information, so treat both the key and any exported reports as sensitive.

DrupalFit requires **Drupal 10.2+** and **PHP 8.1+**, depends on core System and
Update, provides two permissions, and ships an optional **report export**
submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally the export submodule), and grant the permissions.
2. [Configuration](configuration/index.md) — the Settings tab, including the
   optional DrupalFit platform connection.

## Where it lives in the admin menu

Once enabled, open **Reports → DrupalFit Report**
(`/admin/reports/drupalfit-report`). The report interface has an **Analysis
Report** tab (your on‑site audit) and a **Settings** tab (the optional platform
connection). A **Help** tab in the module provides further documentation.

## How to use it

1. Go to **Reports → DrupalFit Report** (`/admin/reports/drupalfit-report`).
2. On the **Analysis Report** tab, review your overall site score, the
   category‑based scores, the findings grouped by severity, and the
   recommendations for addressing them.
3. *(Optional)* Connect to the DrupalFit platform on the **Settings** tab for
   enhanced SEO and accessibility reporting — see
   [Configuration](configuration/index.md).
