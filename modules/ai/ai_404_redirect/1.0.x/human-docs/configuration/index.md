# Configuration

AI 404 Redirect is configured at **Configuration → Search and metadata → AI 404
Redirect** (`/admin/config/search/ai-404-redirect`). You need the **Administer
site configuration** permission (or the module's **Administer AI 404 redirect**
permission) to reach it.

## Before you start

- Make sure an **AI provider is enabled and configured** in the AI module
  (`/admin/config/ai`) with its API key stored via a Key entity / environment
  variable — see [Installation](../installation/index.md).
- Make sure the **Redirect** and **Views Bulk Operations** modules are enabled.

## The settings form

- **Enabled** — the master on/off switch. When it is off, the module's 404
  listener returns immediately and no analysis happens at all. Turn it on once
  your provider is working.
- **AI provider / model** — which provider and model perform the matching. The
  module hands the broken path to this model (a chat operation) and asks it to
  pick the best existing page.
- **404 count threshold** — how many times a given path must return a 404 before
  the module bothers to analyze it (default **4**). This keeps one‑off typos and
  random probes from consuming AI calls; only genuinely recurring broken URLs get
  looked at.
- **Confidence tiers** — the low / medium / high bands used to label how sure the
  AI is about a match, shown as a 0–100 score on each suggestion.
- **Auto‑approval threshold** — the confidence level at or above which a
  suggestion is turned into a real redirect **automatically**, without waiting for
  a human. Set this high if you want a person to confirm most matches; lower it if
  you trust the model and want hands‑off cleanup. Suggestions below the threshold
  simply wait in the review list.

Save the form to apply your changes.

## How analysis actually runs

When a page 404s, the module's listener catches it, skips admin/system/node/user
paths, and then applies several guards before spending any AI budget: it filters
out bot and crawler user‑agents, rate‑limits any IP that racks up 10 or more
unique 404s in an hour, and drops known exploitation probes (`.env`, `wp-admin`,
SQL‑injection patterns, and the like). Paths that survive those checks — and that
have passed the 404 count threshold — are matched using the AI provider, with a
typo/keyword/path‑structure fallback when AI is unavailable. Each result is stored
as a suggestion with its confidence score. All of this happens on a queue, so the
visitor's 404 page still renders instantly.

## Reviewing and approving suggestions

Open the suggestion list under the module's admin area. Each row is a proposed
redirect with its confidence score. Tick the ones you want and use the bulk
actions:

- **Approve** — converts the suggestion into a real redirect (a Redirect module
  entity), so future visitors to that broken URL are sent to the matched page.
- **Reject** — discards the suggestion so it is not turned into a redirect.

Anything that met the auto‑approval threshold will already have become a redirect
on its own; the review list is for everything below that line.
