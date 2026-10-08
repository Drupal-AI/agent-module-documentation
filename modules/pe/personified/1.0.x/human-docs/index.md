# Personified — manual setup guide

**Personified** (`personified`) provides a **client‑side block** that shows
personalized content to each visitor. The block runs in the browser: it makes a
request to a **JSON endpoint**, building the request URL from values that already
exist on the visitor's device — local storage, the data layer, cookies, URL
parameters, or window variables — then transforms the JSON response through a
**Handlebars template** and updates the page's DOM to display the result. The
visitor ends up seeing content tailored by state found on their own device,
rendered in a progressively decoupled way.

Because the personalization is driven by client‑side variables, Personified works
best when two things are true: there are useful variables available in the browser
(often written by other client‑side scripts such as trackers or widgets), and a
**JSON endpoint** exists that can return content filtered by those parameters — a
Drupal **View with a JSON output**, for example. That means it is **not a
plug‑and‑play block**: you lay some groundwork first (make the variables
available, expose the JSON endpoint, write the template), and after that it gives
you an easy way to pull personalized content back from Drupal.

It depends on the **JS Cookie** (`js_cookie`) and **JSON Template**
(`json_template`) modules, which supply the cookie handling and the templating
respectively. Personified holds no special content permissions and has no
access‑control role of its own. A couple of practical cautions: if the JSON comes
from an **external source**, treat that as outbound/inbound traffic you should
confirm and secure, and make sure values rendered from the JSON are **output
safely** (escaped) so a response can't inject unwanted markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it along with its JS Cookie and JSON Template dependencies.

This module has **no dedicated settings page**; you configure each Personified
block where you place it, as described below.

## How to set it up

Personified is configured per block, so setup happens on **Block layout** rather
than a global settings form:

1. **Prepare the groundwork first.** Make sure the client‑side variables you want
   to personalize on (from local storage, the data layer, cookies, URL
   parameters, or window variables) are actually being written in the browser,
   and that you have a **JSON endpoint** — for instance a View configured with a
   JSON display — that returns content filtered by those parameters.
2. **Place a Personified block.** Go to **Structure → Block layout** (`/admin/
   structure/block`) and add the Personified block to a region.
3. **Configure the block** to:
   - build its request URL against your JSON endpoint, pulling in the client‑side
     values you want to personalize on, and
   - render the response through your **Handlebars template** so the returned JSON
     becomes the markup shown to the visitor.
4. Save the block and load a page where it appears to confirm it fetches and
   renders the personalized content.

## Troubleshooting

If a Personified block shows the wrong data, it is almost always caching. **Clear
the Drupal cache**, and any **Varnish** and **PHP OPcache** in front of the site,
then reload.
