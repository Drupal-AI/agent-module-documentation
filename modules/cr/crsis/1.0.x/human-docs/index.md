# CRSIS — manual setup guide

**CRSIS** (`crsis`) — Content Readability Score & Improvement Suggestions — helps
content editors and site administrators measure and improve how readable their
content is. It scores each published node's body text using the well-known
**Flesch-Kincaid Reading Ease** formula and presents the results, along with
actionable suggestions, on a dedicated dashboard.

The dashboard lists up to 50 published nodes with their readability score, word
count, and grade level, and classifies each into one of seven grades — from *Very
Easy* through *Standard* to *Very Difficult*. Color-coded badges (green, amber, red)
make it easy to spot content that needs attention, and summary cards at the top show
the total content analyzed, the average score, and how many nodes read well versus
need improvement. When a node falls below a minimum score you set, CRSIS flags it and
offers specific tips such as shortening sentences or using simpler words.

The Flesch-Kincaid calculation happens entirely in PHP — there are no external
libraries or third-party APIs, and nothing leaves your site. CRSIS depends only on
core's **Node** module (`node`), works on Drupal 10, 11, and 12, and all its
user-facing strings are translatable. It defines two permissions: *Access CRSIS
dashboard* (to view the report) and *Administer CRSIS* (to change settings).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable readability analysis and set
   your minimum acceptable score.

## Where it lives in the admin menu

- Settings are at **Configuration → Content authoring → CRSIS Settings**
  (`/admin/config/content/crsis`).
- The report is at **Content → CRSIS Dashboard**
  (`/admin/content/crsis-dashboard`).

## How to use it

1. Enable readability analysis and set a minimum acceptable score on the settings
   page (see [Configuration](configuration/index.md)).
2. Grant **Access CRSIS dashboard** to roles that should view the report, and
   **Administer CRSIS** to those who manage settings (**People → Permissions**).
3. Open **Content → CRSIS Dashboard** to see readability scores, grades, and
   suggestions for your published content. CRSIS analyzes the **body field** of
   published nodes — create or edit content and revisit the dashboard to see updated
   scores.
