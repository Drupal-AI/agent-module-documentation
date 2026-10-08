# DubBot — manual setup guide

**DubBot** (`dubbot`) brings the external **DubBot** service — automated scanning
for accessibility, broken links, spelling, SEO, and custom web‑governance rules —
right into your Drupal admin. Instead of asking editors to log into a separate
tool, this module surfaces each crawled page's DubBot report inside Drupal: an
overview page that lists pages with their issue counts, an embeddable report block
you can place on a page, and an optional toolbar shortcut to the current page's
report.

The key thing to understand is that DubBot is a **SaaS integration**. The scanning
and reporting happen on DubBot's servers; this module talks to their HTTP API using
an **embed key** you generate in your DubBot account, and displays the results. You
need a DubBot account and a valid embed key for reports to appear — without them the
module has nothing to show.

Once connected, the module is genuinely useful for editorial quality control. The
**Overview** page (`/admin/config/content/dubbot`) lists crawled pages with issue
counts and links to each page's full report, which opens in an off‑canvas side
tray, a top panel, or a modal (your choice). The **DubBot Report** block can be
dropped onto pages so authors see issues inline in context. And a rich set of
permissions lets you control exactly who sees what — right down to individual report
tabs, so a team could see the spelling and broken‑links panes while an accessibility
specialist sees only the accessibility tab.

It has no other Drupal module dependencies, and adds no fields or content entities
of its own — its "state" is just the connection settings, any block placements, and
role permissions. A bundled submodule, **DubBot Toolbar** (`dubbot_toolbar`), adds
the toolbar shortcut.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (and optionally the toolbar submodule), and set permissions.
2. [Configuration](configuration/index.md) — enter your embed key, choose how
   reports open, place the report block, and grant the per‑tab permissions.

## Where it lives in the admin menu

- **Overview** (the reports list) — **Configuration → Content authoring → DubBot**
  (`/admin/config/content/dubbot`), for users with **Access dubbot report**.
- **Settings** — **Configuration → Content authoring → DubBot → Settings**
  (`/admin/config/content/dubbot/settings`), for users with **Administer dubbot
  configuration**.

## How to use it

1. Generate an embed key in your DubBot account and paste it into the settings form.
2. Choose how reports should open (side tray, top panel, or modal).
3. Grant the appropriate permissions to your roles — the overall report access plus
   whichever report tabs each role should see.
4. Editors then review page issues from the Overview page or an inline DubBot Report
   block. See [Configuration](configuration/index.md) for the details.
