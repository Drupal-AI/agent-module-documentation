# Configuration

Partial Access has a single, simple settings form. Two things are set there: which
roles may see full content, and the message shown to everyone else.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration.
2. Go to **Configuration → Partial Access Settings** (as named on the project
   page).

## Choose which roles get full content

Select the user role(s) that are allowed to see the **entire** node body. Any
visitor who does not have one of the selected roles — including anonymous visitors,
depending on your choices — will see only a portion of the body, followed by your
call‑to‑action. This is how you decide who is "inside" the paywall and who is
"outside" it. Authors and editors of the content typically retain full access.

## Set the call‑to‑action (CTA) message

Write the message that appears in place of the hidden portion of the body for
restricted visitors. This is your chance to explain why the rest is hidden and
what to do about it — "Subscribe to read the full article", "Members only", a link
to a signup or contact form, and so on. The module's recommended companions here
are **Webform** (to add a subscription or contact form) and **Block Visibility
Groups** (to show a dynamic CTA block).

## Save

Save the form to apply your settings. The truncation and CTA take effect
immediately on the rendered node pages.

## A reminder about what this protects

As covered in the [overview](../index.md), the truncation is enforced only on the
HTML render path. The roles you select here control what appears on the **rendered
page** — they do **not** stop the full body from being returned through JSON:API,
REST, Views feeds, or search indexing. Use Partial Access for presentation‑level
gating, and layer real access control on top if the hidden content is genuinely
sensitive.
