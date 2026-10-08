# AI 404 Redirect — manual setup guide

**AI 404 Redirect** (`ai_404_redirect`) watches for "page not found" (404)
errors on your site and uses AI to work out where the visitor probably meant to
go. When a broken URL keeps getting hit, the module asks your configured AI
provider to match that path against your existing content and records a
**redirect suggestion** with a confidence score. Strong matches can be turned
into real redirects automatically; weaker ones wait for a human to approve or
reject them.

It is built on top of Drupal's **AI** module and the **Redirect** module. The AI
module supplies the language model that does the matching; the Redirect module
stores the finished redirects. When the AI provider is unavailable, the module
falls back to simpler typo/keyword/path matching so it still produces useful
suggestions.

The public side is deliberately careful. Only the 404 handler is exposed to
anonymous visitors, and it never writes anything on the spot — it detects bots
and crawlers, rate‑limits IP addresses that trigger many unique 404s in an hour,
and blocks known exploit‑probe paths (like `wp-admin` or `.env` scans) before it
ever calls the AI. The actual analysis is queued, so your 404 page still renders
instantly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — the settings form and the
   suggestion review workflow, field by field.

## Where it lives in the admin menu

The settings and review screens live at **Configuration → Search and metadata →
AI 404 Redirect** (`/admin/config/search/ai-404-redirect`). Access is restricted
to administrators via the **Administer site configuration** permission and the
module's own **Administer AI 404 redirect** permission.

## How to use it

1. Set up an AI provider in the AI module first (see Installation), then enable
   AI 404 Redirect.
2. Open the settings form, switch the feature on, choose the provider/model, and
   tune the thresholds (how many times a path must 404 before it is analyzed,
   and the confidence needed for auto‑approval).
3. Let the site run. As real visitors hit broken URLs, suggestions accumulate.
4. Review them in the built‑in list: use the bulk **Approve** / **Reject**
   actions to turn good suggestions into permanent redirects or discard the
   rest.
