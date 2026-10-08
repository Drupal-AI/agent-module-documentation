# Guest suite — manual setup guide

**Guest suite** (`guest_suite`) connects your Drupal site to the **Guest Suite**
customer‑reviews platform. It pulls your reviews and per‑establishment statistics
from the Guest Suite REST API and stores each review locally as a
`guest_suite_review` content entity — so you can display real customer reviews and
ratings on your pages using Views, blocks, and templates, rather than embedding a
third‑party widget.

Reviews come in with a rich set of fields (reviewer name, title, comment, dates,
type, global rating, establishment identifiers, an authenticity URL, and more).
Importing can run automatically on cron — fetching all reviews or just the latest
— or you can trigger it manually from the review collection page. To avoid
duplicates, the import is split into queued fetch and import jobs.

For aggregate display, the module provides two tokens — the **average rating** and
the **total number of reviews** — that you can drop into blocks or templates, plus
an **establishment block** that shows the information for one selected
establishment.

Authentication to the Guest Suite API is by an **access token**. The API is
reached over HTTPS at a fixed host. Keep your configuration exports out of any
public repository (see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it depends on
   several core and contrib modules) and enable it.
2. [Configuration](configuration/index.md) — enter your API token and set up the
   import.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Guest suite**
(`/admin/config/services/guest-suite`), gated by **Administer site
configuration**. A review overview page is available behind the dedicated **Access
guest suite review overview** permission.
