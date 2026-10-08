# Plausible — manual setup guide

**Plausible** (`plausible`) adds the [Plausible Analytics](https://plausible.io/)
JavaScript tracking snippet to your site's pages, so you can measure traffic with
a privacy‑friendly, cookieless analytics tool instead of Google Analytics — and
without needing a cookie‑consent banner. It gives you fine‑grained control over
*which* pages, roles, and admin routes are tracked, and it can embed your
Plausible dashboard right inside Drupal.

Tracking is injected into every page's `<head>` and gated by a set of visibility
rules you configure: a global on/off switch, page targeting by path (track "all
except listed" or "listed only", just like core block visibility), role targeting
(track or exclude selected roles — handy for keeping staff traffic out of your
numbers), and a rule for whether admin pages are tracked. It supports both the new
**october‑2025** Plausible snippet and the legacy snippet, can point at a
self‑hosted or proxied Plausible instance, and can fire custom events on 403 and
404 responses (useful for spotting broken links and blocked pages).

Two permissions come with the module: **Administer Plausible configuration**
(access the settings form) and **View Plausible dashboard** (see an embedded
reports page that shows your Plausible *shared link* in an iframe — it even matches
the light/dark theme of the Gin admin theme when Gin is in use). The module has no
required dependencies; the Gin and Markdown modules are optional niceties.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the tracking snippet, visibility
   rules, error‑page events, and the embedded dashboard, field by field.

## Where it lives in the admin menu

- **Settings:** **Configuration → Web services → Plausible**
  (`/admin/config/services/plausible`), behind the *Administer Plausible
  configuration* permission.
- **Dashboard:** **Reports → Plausible Dashboard**
  (`/admin/reports/plausible`), behind the *View Plausible dashboard* permission.

## How to use it

1. Create an account (or self‑host) at Plausible and add your site there.
2. Enable the module and open **Configuration → Web services → Plausible**.
3. Set the tracking snippet (script URL, and domain/endpoint if needed), then
   choose your visibility rules — which pages, roles, and admin routes to track.
   See [Configuration](configuration/index.md) for every option.
4. (Optional) Paste a Plausible **shared dashboard link** into the settings so the
   *Reports → Plausible Dashboard* page can embed your stats inside Drupal.
