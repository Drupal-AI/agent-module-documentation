# Configuration

Conditional 404 Pages is configured by creating one or more **conditional 404
page** entries, each pairing a piece of content with the path pattern(s) that
should display it as the not-found page.

## Manage conditional 404 pages

1. Log in as a user with the module's management permission (grant it under
   **People → Permissions** to trusted site builders/administrators).
2. Open the module's conditional 404 pages listing from the admin menu. This is
   where you add, edit, and delete entries.

## Create a conditional 404 page

For each entry you configure:

- **Referenced content** — choose an existing content item to display as the 404
  page for this section. Create the content first (a node describing "page not
  found for Brand A", for example) so you can reference it here.
- **Path pattern(s)** — the path(s) that should trigger this 404 page. Use a
  wildcard to cover a whole section, for example `/brand-a-site-section/*`. A
  request to any non-existent URL matching that pattern will show the referenced
  content instead of the generic 404.

Save the entry. You can create as many as you need — one per site section, brand,
market, or language area.

## Translations

The referenced content item can be translated into any configured language. When
a visitor hits a language-specific path (for example a Spanish
`/es/brand-a-site-section/does-not-exist`), the referenced content's Spanish
translation is displayed. Translate the referenced content through Drupal's normal
translation workflow.

## Keep 404 pages clean

Because these pages are shown for unknown URLs, make sure the referenced content
contains only the helpful, public-facing message you intend — no diagnostic detail
or internal information that could disclose how your site is structured.
