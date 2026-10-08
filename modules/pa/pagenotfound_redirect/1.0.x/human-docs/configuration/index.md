# Configuration

Setting up Page Not Found Redirect is two steps: **compose your custom 404 page** in the
module's settings form, then **tell Drupal to use it** as the site's 404 handler.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Page Not Found Redirect**, or navigate directly to
   `/admin/config/system/pagenotfound-redirect`.

## Compose the page

The form has three parts:

- **Title** — the heading shown on your custom 404 page (for example "We couldn't find
  that page").
- **Message** — the body text explaining what happened and inviting the visitor to try
  one of the links below.
- **Link buttons** — a table of **label + URL** rows. Each row becomes a button on the
  404 page pointing wherever you choose (homepage, search, a key landing page, and so
  on). Use the **add‑row** control to add as many as you need, and remove any you don't.

The destination URLs come only from this configuration (not from the visitor's request),
so this is **not** an open‑redirect — a visitor cannot influence where the buttons point.

> **Keep this form to trusted administrators.** Grant **Administer site configuration**
> only to people you trust, and use validated URLs.

Save the form when you're done.

## Activate the custom page

The module publishes its page at **`/friendly-404`**, but Drupal won't use it until you
set it as the site's 404 handler:

1. Go to **Configuration → System → Basic site settings**
   (`/admin/config/system/site-information`).
2. In the **Error pages** section, set the **Default 404 (not found) page** to
   `/friendly-404`.
3. Save.

From now on, any non‑existent URL or deleted node shows your custom page — returning a
correct HTTP 404 status, and served uncached so your edits take effect right away.

## Review the broken‑URL log

Every 404 hit is recorded to the module's **`page_not_found_redirect`** log channel. Check
your site logs (**Reports → Recent log messages**, filtered to that channel) to see which
missing URLs visitors hit most — useful for deciding which redirects or content to add.
