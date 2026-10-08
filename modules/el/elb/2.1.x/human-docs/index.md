# External Link Blocklist — manual setup guide

**External Link Blocklist** (`elb`) lets you define a list of URL patterns that are
**forbidden in link fields**, so an editor who tries to enter a matching external
(absolute) link gets a validation error instead of saving a bad link. It gives you
extra control over which external URLs are allowed in your content.

The classic use case is a site under development: editors sometimes paste absolute
links pointing at a dev or staging server (`dev.example.com`, `staging.example.net`)
where they should have used an internal link, and those wrong-domain links then leak
into published content. External Link Blocklist mitigates that by rejecting links
that match your blocklist at the point of entry. It can also enforce an
internal-linking policy or keep links to competitor/wrong domains out of content.

It depends only on core's **Link** module. It provides a link-field **widget**
("External link blocklist") that you select on a field's form display, and it also
integrates with the **Linkit** CKEditor link dialog when Linkit is present, so
blocklisted links are caught there too. Matching is plain **substring containment** —
a pattern like `example.com` matches anywhere in the URL — with an **exceptions**
list so you can still allow a specific subdomain of an otherwise blocked domain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's Link module.
2. [Configuration](configuration/index.md) — apply the widget to a Link field, edit
   the blocklist and exceptions, and mind the upgrade permission caveat.

## Where it lives in the admin menu

The blocklist and exceptions are edited at **Configuration → Content authoring →
External Link Blocklist** (`/admin/config/content/elb`), gated by the **Access the
external links blocklist page** permission. The widget itself is chosen per field
under **Manage form display**.
