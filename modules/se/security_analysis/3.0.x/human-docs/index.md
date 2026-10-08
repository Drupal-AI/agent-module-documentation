# Security Analysis — manual setup guide

**Security Analysis** (`security_analysis`) is an admin dashboard that grades your
site's security configuration. It reads the settings of the common Drupal security
modules — **SecKit**, **Login Security**, **Password Policy**, **CAPTCHA/reCAPTCHA**,
and **Security Review** — and compares each value against a bundled "ideal"
configuration set. From that comparison it produces an overall rating (a letter grade
and a percentage) with charts and gauges, giving developers, site builders, and even
managers a clear at-a-glance picture of how hardened the site is.

The dashboard lives at **`/admin/security_analysis`**. Alongside the on-screen rating
it can **export the full report as an Excel (`.xlsx`) workbook**, which makes it easy
to share a hardening summary with a team or attach it to an audit. It is aimed at
helping teams prevent common attack classes — clickjacking, brute force, XSS, code
injection — by measuring where their configuration falls short of the recommended
baseline.

Two things are worth understanding. First, the module is **read-only reporting**: it
tells you how your security settings score, but it does **not** change any of them for
you — acting on the findings is up to you. Second, it depends on the
**PhpSpreadsheet** module (which generates the Excel export), and the report page loads
the **Chart.js** charting library from a public CDN — so the rating charts need
outbound internet access from the browser to render, something to note on locked-down
or air-gapped environments. The module can run in production, though the maintainers
advise running it on development, integration, or QA environments.

There is no settings form to fill in — the dashboard simply reads whatever the other
security modules are already configured to do. Access is gated by two permissions:
**access security analysis admin overview** (to see the dashboard) and **download
security analysis report** (to export the Excel file).

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including
   PhpSpreadsheet) and enable the module.

## Where it lives in the admin menu

Open the dashboard at **`/admin/security_analysis`**. You will see the overall
letter/percentage rating, per-module breakdowns for SecKit, Login Security, Password
Policy, CAPTCHA, and Security Review, and rating charts — plus a button to download the
findings as an Excel workbook (if you hold the download permission).

## A note on versions

This 3.0.x release of Security Analysis is built to work with **Security Review
3.0.x**. (Security Analysis 2.0.0-alpha1 pairs with Security Review 2.0.x instead.)
Make sure the Security Review version on your site matches.
