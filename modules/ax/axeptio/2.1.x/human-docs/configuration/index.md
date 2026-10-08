# Configuration

## Open the settings form

1. Log in as a user with the **`administer axeptio`** permission.
2. Open the Axeptio settings form.

## Connect your Axeptio account

Enter the identifier(s) from your Axeptio account (the project/client identifier
Axeptio gives you) so the widget knows which configuration to load. Your banner
design, cookie categories, and wording are managed in the Axeptio dashboard itself;
this form connects your Drupal site to that configuration and loads the widget on
your pages. Save the form and confirm the banner appears on the front end.

## The part that actually matters — gate your trackers

Showing the banner is only half the job. On its own, the widget does not stop any
tracking; it only records the visitor's choice. Compliance depends on whether your
site actually **holds trackers back until consent is given**. So:

- **Inventory every script on the site.** Analytics tags, video embeds, social
  buttons, maps — and importantly, scripts added by **Drupal modules**, not just by
  a tag manager. Each one that sets cookies or tracks needs to be gated behind the
  matching Axeptio consent category.
- **Check the page cache.** A consent decision is per visitor, but Drupal's page
  cache serves one cached copy to everyone. If a page is cached with a tracking
  script tag baked into its markup, that script goes to every visitor regardless of
  what they consented to. Make sure consent‑gated scripts are not hard‑baked into
  cached HTML.

Once trackers are gated, test as a fresh visitor: refuse consent and verify (in
your browser's network tab) that the gated scripts do **not** load; then accept and
verify they do.
