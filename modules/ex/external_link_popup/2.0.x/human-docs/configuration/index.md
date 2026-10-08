# Configuration

External Link Pop-up has two things to configure: the individual **pop-ups** (each with
its own wording and target domains) and one **global settings** form. Both require the
**Administer external link popup** permission.

## Managing pop-ups

1. Go to **Configuration → Content authoring → External Link Pop-up**, or navigate to
   `/admin/config/content/external_link_popup`.
2. You'll see the list of pop-ups, including the shipped **default** one. From here you
   can **Add pop-up**, edit, delete, or enable/disable each one.

> Tip: don't delete the default `*` pop-up if you rely on it as a catch-all fallback —
> disable it instead if you want to turn it off temporarily.

### Fields on a pop-up

- **Name** — an administrative label to identify the pop-up in the list.
- **Show close icon** — whether the dialog shows a close (X) icon in its corner.
- **Title** — the heading shown at the top of the dialog.
- **Body** — the message, edited with a rich-text format so you can include formatted
  text and links.
- **"Yes" button label** — the text on the confirm/continue button (for example
  "Continue").
- **"No" button label** — the text on the cancel button (for example "Stay here").
- **Domains** — the external domains this pop-up applies to, one per line:
  - `example.com` matches that domain **and its subdomains** (`*.example.com`).
  - `*` on its own matches **every** external link — a catch-all.
- **Open in new tab by default** — when ticked, links without their own target open in a
  new browser tab after the visitor confirms.
- **Status** and **Weight** — whether the pop-up is enabled, and its position in the
  matching order.

### How the right pop-up is chosen

When a visitor clicks an external link, the enabled pop-ups are checked **in weight order
(lowest first), and the first one whose Domains match wins**. So a catch-all `*` pop-up
placed above the others will fire for everything and hide the more specific ones — order
specific pop-ups above your `*` fallback.

## Global settings

Go to **Configuration → Content authoring → External Link Pop-up → Settings**, or
navigate to `/admin/config/content/external_link_popup/settings`. This form has three
options that apply across all pop-ups:

- **Trusted domains (whitelist)** — a list of domains, one per line, that should **never**
  trigger a pop-up (subdomains are matched too). Use this for partner or first-party sites
  that technically count as "external" but that you trust.
- **Show on administration pages** — off by default. Turn it on if you also want pop-ups
  to appear on admin routes, not just the public-facing site.
- **Dialog width** — the default width of the pop-up dialog, as a value plus units (the
  default is `85%`). Adjust this for your layout, especially for responsive designs.

## Per-link overrides (for site builders and themers)

You don't need the admin forms for these, but they're worth knowing:

- **Exclude a single link** from any pop-up by adding the CSS class
  `external-link-popup-disabled` to it.
- **Force a specific pop-up** on a link — even an internal one — by adding the attribute
  `data-external-link-popup-id="<machine name>"`, where the machine name is the ID of the
  pop-up you want.

The front-end JavaScript also emits events (`externalLinkPopup:yes`, `:no`, `:notFound`,
`:skipped`) that you can listen for to record exit-intent analytics.
