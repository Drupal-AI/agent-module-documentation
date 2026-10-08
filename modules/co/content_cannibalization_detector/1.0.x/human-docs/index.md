# Content Cannibalization Detector — manual setup guide

**Content Cannibalization Detector** (`content_cannibalization_detector`) finds
**SEO keyword cannibalization** on your site — the situation where several pages
target the same search keywords and end up competing against each other in search
results, splitting ranking authority and dragging all the competing pages down. It
depends on core's Node and Path Alias modules and runs on Drupal 10, 11, and 12.

Under the hood it extracts keywords from each published node's **title, body, URL
path alias, and meta‑tag fields** using TF‑IDF scoring (including two‑word phrases),
weighting the sources so titles count most and body text least. It then compares
every pair of nodes with cosine similarity to spot overlapping keyword profiles.
Each overlap is classified by severity — **Critical, High, Medium, or Low** — and
paired with a concrete recommendation: *merge* nearly identical pages, *redirect* a
weaker one, *set a canonical URL* on the secondary page, or *differentiate* the
keyword targeting.

You review the findings in a visual **admin dashboard** with summary cards and a
color‑coded severity table, drill into per‑node detail pages that break down the
keywords and list competing pages, and — if you have Drush — run the same analysis
from the command line. It's an SEO **audit** tool: it reports and recommends, it
doesn't change your content for you. This project is *not* covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus the recommended Metatag and Drush).
2. [Configuration](configuration/index.md) — choose content types, similarity
   threshold, keyword sources, and custom stop words.

## Where it lives in the admin menu

- **Settings:** **Configuration → Search and metadata → Content Cannibalization
  Detector** (`/admin/config/search/cannibalization`).
- **Report / dashboard:** **Reports → Content Cannibalization**
  (`/admin/reports/cannibalization`) — run the analysis and review results there.

Two permissions control access: **Administer Content Cannibalization Detector**
(configure settings and trigger analysis) and **View cannibalization reports**
(open the dashboard and node detail pages).

## How to use it

1. Configure the module (content types, threshold, sources) — see
   [Configuration](configuration/index.md).
2. Go to **Reports → Content Cannibalization** and click **Run Analysis** to scan all
   configured content.
3. Review the results table, sorted by severity, and click **View details** on any
   row to see the keyword breakdown and the competing pages.
4. Act on the recommendation for each issue — merge, redirect, set canonical, or
   differentiate.

If you have Drush 12+, the same work is available from the CLI: `drush ccd:analyze`
(run a full analysis), `drush ccd:report` (summary of all issues), and `drush
ccd:node` (keywords and competitors for one node).
