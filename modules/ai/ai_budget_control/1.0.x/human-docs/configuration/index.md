# Configuration

AI Budget Control does two things: it lets you **create usage limits**, and it
gives you a **dashboard** to watch consumption. This page covers both.

You need the **Administer AI budget control** permission to create limits and use
the CSV export; the read‑only dashboard is available to anyone with **View AI
usage dashboard**.

## Create a usage limit

1. Go to **Configuration → AI → Budget Control** (`/admin/config/ai/budget`).
2. Click **Add** to create a new limit.

Each limit has the following fields:

- **Provider** — the AI provider the limit applies to. Pick a specific provider
  plugin (for example your OpenAI provider), or choose **`_all`** to apply the
  limit across every provider at once.
- **Scope** — who the limit counts against:
  - **Global** — everyone on the site combined.
  - **Role** — pick a role, and the limit applies to users in that role.
  - **User** — start typing a username to attach the limit to one specific person.
- **Metric** — what you are measuring:
  - **Tokens** — total tokens sent and received.
  - **Budget** — an estimated dollar figure, calculated from the *price per 1k
    tokens* you set below.
  - **Requests** — the number of AI calls.
- **Limit value** — the ceiling for the chosen metric (for example 100,000 tokens,
  or 25 dollars, or 500 requests).
- **Time window** — how often the counter resets: **hour**, **day**, or **month**.
- **Price per 1k tokens** — the cost you want to assume for every 1,000 tokens.
  This drives the estimated cost shown on the dashboard and powers any **budget**
  limits.
- **Soft limit** — when enabled, the limit becomes a *warning* rather than a
  block. At the **soft limit percentage** (default **80%**) the request is still
  allowed through, but a warning is logged and a `SoftLimitReachedEvent` is fired
  so other code can react. Leave the soft limit off to make it a **hard** limit
  that blocks any request once usage reaches the ceiling.

Save the limit. You can create several limits at once — for example a generous
global monthly budget plus a tighter per‑role daily token cap.

## How enforcement works

- **Before** each AI call, the module checks your limits. If a **hard** limit is
  already exceeded, the provider is never called — the request is short‑circuited
  and a message is returned instead of billing the API. The first hard limit that
  is hit wins.
- **After** each successful call, the module reads the tokens actually used,
  estimates the cost from your price‑per‑1k figure, and writes a row to the usage
  log (user, provider, model, operation type, tokens in/out, estimated cost, and
  a timestamp).
- Independently of your configured limits, anonymous callers are flood‑limited to
  **20 requests per hour** by IP address.

## Monitor usage

- **Dashboard:** **Reports → AI Usage** (`/admin/reports/ai-usage`) shows tables
  of usage and estimated cost per provider and per user. Available to holders of
  **View AI usage dashboard** or **Administer AI budget control**.
- **CSV export:** `/admin/reports/ai-usage/export` downloads the usage log for
  finance or reporting. Requires **Administer AI budget control**.

## What it never does

The module does not store or log your provider API keys, and it makes no outbound
HTTP requests of its own — it only records usage metadata. Your provider key stays
where the AI module keeps it (an environment variable referenced through a **Key**
entity).
