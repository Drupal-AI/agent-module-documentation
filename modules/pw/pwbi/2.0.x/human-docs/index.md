# PowerBi Integration — manual setup guide

**PowerBi Integration** (`pwbi`) brings Microsoft **Power BI** into Drupal in two
ways. It lets editors **embed Power BI reports** on the site as media, and it gives
your code programmatic access to the **Power BI REST API** — generating embed
tokens, running dataset queries, exporting reports to files (PDF/PPTX/PNG), and
reading report metadata.

Authentication is handled with an **Azure AD service principal** through the
[OAuth2 Client](https://www.drupal.org/project/oauth2_client) module. You register
an app in Azure, then authenticate either with a **client secret** or with an
uploaded **PEM certificate**. From there a `PowerBiClient` service talks to the
Power BI cloud endpoints on your behalf, and a JavaScript library renders reports
in the browser (with `PowerBiPreEmbed` / `PowerBiPostEmbed` events so front-end
code can customise the embed).

Editors work with reports as **media**: the module provides a "PowerBi Embed" media
source plus a matching field type, widget, and formatter (with per-breakpoint
report heights for responsive layouts). Administrators define which Power BI
workspaces are available, and everything is gated behind a single
**configure pwbi** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Power BI
   JavaScript library, and enable the module and its dependencies.
2. [Configuration](configuration/index.md) — set up the Azure service principal,
   define workspaces, and start embedding reports.

## Where it lives in the admin menu

The module's pages sit under **Configuration → PowerBi** (`/admin/config/pwbi`):

- `/admin/config/pwbi` — the landing/menu page.
- `/admin/config/pwbi/embed_settings` — define the available Power BI workspaces.
- `/admin/config/pwbi/api_test` — an ad-hoc REST API test form.

The OAuth2 service-principal client itself is configured under **Configuration →
System → OAuth2 Client** (`/admin/config/system/oauth2-client`). All PowerBi routes
require the **configure pwbi** (Administer PowerBi configuration) permission.

## How to use it

After [installation](installation/index.md) and
[configuration](configuration/index.md), embedding a report is a media workflow:
create a media type that uses the **PowerBi Embed** media source, create media
entities pointing at the reports you want, and optionally add the `pwbi_embed`
field to a content type so authors can place reports in content. For programmatic
work, inject the `pwbi_api.client` service and call methods like `getEmbedToken()`
or `executeGroupQuery()`.
