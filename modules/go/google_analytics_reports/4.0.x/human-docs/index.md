# Google Analytics Reports — manual setup guide

**Google Analytics Reports** (`google_analytics_reports`) brings your Google
Analytics 4 (GA4) statistics into Drupal and displays them with **Views**. It
adds a Views query backend that talks to the Google Analytics Data API, so you
can build Views whose rows are GA data — sessions, users, page views, broken down
by dimensions like page path, country, or device — and it ships ready‑made report
pages and blocks so you can show traffic figures to editors without giving them
access to the Google Analytics console.

The module builds on a required submodule, **Google Analytics Reports API**
(`google_analytics_reports_api`), which holds the credentials (a Google service‑
account JSON key plus your GA4 Property ID) and makes the actual API calls. This
module adds the reporting layer on top: the Views query plugin, GA field/filter/
argument plugins, a Summary report page, and Summary and Page blocks you can
place. The catalogue of available GA dimensions and metrics is imported into a
database table via an **Import fields** button on the settings form, after which
those fields become available in Views.

Because Google enforces API quotas, query results are cached for a configurable
duration (three days by default). Graphical charts are optional and require the
contrib **Charts** module. A single permission, **Access Google Analytics
reports**, gates the report pages. Note that most of the module only produces data
once you have supplied valid GA4 credentials — the underlying data comes from
Google's external service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its API submodule.
2. [Configuration](configuration/index.md) — supplying GA4 credentials, importing
   fields, the report pages and blocks, cache, and permissions.

## Where it lives in the admin menu

The settings form lives at **Configuration → Web services → Google Analytics
Reports API** (`/admin/config/services/google-analytics-reports-api`). The Summary
report is at **Reports → Google Analytics Reports → Summary**
(`/admin/reports/google-analytics-reports/summary`), and the two blocks are placed
from **Structure → Block layout** (`/admin/structure/block`).

## How to use it

After enabling the module, create a Google Cloud service account with the Google
Analytics Data API enabled, add it as a viewer on your GA4 property, and download
its JSON key. Enter the Property ID and upload the key on the settings form, then
click **Import fields** to load the available GA dimensions and metrics. From
there you can view the shipped Summary report, place the Summary/Page blocks, or
build your own Views using the GA fields.
