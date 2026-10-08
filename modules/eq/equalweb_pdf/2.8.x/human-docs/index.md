# EqualWeb PDF Accessibility — manual setup guide

**EqualWeb PDF Accessibility** (`equalweb_pdf`) finds **every PDF already on your
site**, scores each one against the **PDF/UA** accessibility standard with a
detailed rule-by-rule report, and can optionally **remediate** inaccessible files
automatically through the EqualWeb service — replacing a file in place (keeping a
restorable backup) or saving a new accessible copy alongside it.

The accessibility *check* is free and needs no account, no API key and no signup:
install the module, open the dashboard, and you get scores and reports for the PDFs
already on your site at no cost. (Keyless checks are rate-limited; adding a free
EqualWeb API key removes the limit.) Only the optional **AI remediation** — which
tags the document, fixes reading order, heading levels, tables, lists and links,
runs OCR on scans, and writes real alternate text for images — uses EqualWeb
credits and needs a free EqualWeb account.

Checks and remediation are aligned with PDF/UA (ISO 14289), WCAG 2.2 Level AA,
Section 508, ADA and EN 301 549. It supports Drupal 10.3 and 11.

> **External service & privacy.** When you run a check or remediation, the PDF and
> its metadata are sent to the EqualWeb service for processing — nothing is
> transmitted until you actually run one. All EqualWeb traffic happens server-side,
> so API keys are never exposed to the browser. By using the service you agree to
> EqualWeb's Terms of Service and Privacy Policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the dashboard, site registration,
   permissions and the remediation workflow.

## Where it lives in the admin menu

The dashboard sits under **Reports → EqualWeb PDF Accessibility**
(`/admin/reports/equalweb-pdf`). It lists the site's PDF (and office) files with
their accessibility scores and is the hub for checking, reporting and remediating.
