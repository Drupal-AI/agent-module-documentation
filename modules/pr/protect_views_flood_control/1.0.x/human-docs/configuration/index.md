# Configuration

Protect Views Flood Control has no settings page of its own. You configure it
**per View display**, so protection can differ from one display to the next.

## Turn on protection for a display

1. Go to **Structure → Views** (`/admin/structure/views`) and edit the View you
   want to protect.
2. Select the display whose exposed form you want to protect (for example a Page
   or Block display with exposed filters).
3. In the **Advanced** panel, find the **Flood control** section (labelled "Flood
   control & Maximum filters at once") and open it.
4. Tick **Enable flood control** and set the options below.
5. Save the View.

Repeat per display — you can protect a public search display while leaving other
displays of the same View open, and apply different thresholds to each.

## The options

**Flood throttling**

- **Enable flood control** — turns on rate‑limiting for this display's exposed
  form. *(Off by default.)*
- **Window** — the time window in seconds over which submissions are counted.
  Default **30**, minimum 10.
- **Threshold** — how many submissions are allowed within the window. Default
  **5**, minimum 1. So the default is "no more than 5 exposed‑form submissions
  every 30 seconds".
- **Protect by IP range** — group the count by IP subnet (IPv4 /24, IPv6 /48)
  rather than by exact IP address, to catch clients that rotate through nearby
  addresses. *(Off by default. See the caveat below.)*

**Maximum filters cap**

- **Enable max filters** — turns on a cap on how many filters (and options within
  a filter) a single submission may use, to counter combinatorial scraping.
  *(Off by default.)*
- **Maximum filters at once** — the largest number of active filters allowed in one
  submission. Default **3**; set to 0 or leave blank for no limit.
- **Maximum options per filter** — the largest number of options selectable within
  a single multi‑value filter. Default **3**; 0 or blank means no limit.

## What visitors experience over the limit

- **Non‑AJAX requests** (typical for scraper bots) get an HTTP **429 Too Many
  Requests** response with a `Retry-After` header (equal to the window) and an
  `X-RateLimit-Limit` header — so well‑behaved bots back off.
- **AJAX requests** (a real person using an AJAX exposed form) get a friendly
  validation error like "You cannot submit the filters more than N times in T
  seconds" instead of a hard error page.

Throttling only counts when the exposed form actually runs with non‑empty input —
plain page loads, pager clicks, and fully cached results are never counted.

## Settings that live in the parent module

The **IP whitelist** (to exempt trusted crawlers and monitoring tools) and
**blocked‑submission logging** are configured on the **Protect Form Flood
Control** settings page (`protect_form_flood_control.settings`), which the Flood
control section links to — not here.

## Caveat about "Protect by IP range"

In this release there is a known mismatch in the option keys behind the **Protect
by IP range** toggle, so enabling it may not actually switch the throttling
identifier to the IP subnet — throttling can remain per exact IP. If you depend on
subnet grouping, verify the behavior against your running version before relying on
it.
