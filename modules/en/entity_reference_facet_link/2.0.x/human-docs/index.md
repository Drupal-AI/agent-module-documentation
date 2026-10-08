# Entity Reference Facet Link — manual setup guide

**Entity Reference Facet Link** (`entity_reference_facet_link`) provides field
formatters that turn an entity-reference field — most often a taxonomy term field
— into links that point at a **faceted search page filtered by that value**,
instead of linking to the referenced entity's own page. So a term shown on an
article can send visitors to search results for that term, rather than to the
plain term page, which is usually a much more useful destination.

It adds two formatters you choose on a field's *Manage display* (or in a view):
**Facet link**, which renders each reference's label as a link to the facet page,
and **Facet URL**, which outputs just the URL as markup for custom theming. In the
formatter settings you pick the target **facet**, and the module is smart about it
— it only offers facets that actually facet the field you're configuring. At
render time it asks the facet's own URL processor to build the link, so the result
automatically matches whatever the facet uses (including Facets Pretty Paths) and
keeps working if you later switch processors. You never have to know or hardcode
the facet's path.

This is a display-only tool with no admin page, no permissions, and no Drush. It
does nothing on its own: it **requires the [Facets](https://www.drupal.org/project/facets)
module and an existing faceted search page** (typically Search API + Facets + a
view) whose facet targets the same field you're formatting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Facets).

## Where it lives in the admin menu

There's no settings page. You choose a formatter and its target facet on a
bundle's **Manage display** page (e.g. *Structure → Content types → {type} →
Manage display*), or in a view's field settings.

## How to use it

**Before you start**, make sure you have the Facets module installed and a working
faceted search page whose facet targets the reference field you want to link (for
example a "Topic" facet on a news search page that facets `field_topic`).

Then:

1. Go to the field's **Manage display** page
   (`/admin/structure/types/manage/<bundle>/display`), or the field's settings in
   a view.
2. Set the field's **Format** to **Facet link** (for a clickable label) or **Facet
   URL** (for just the URL).
3. Click the settings cog and pick the **facet** the labels should link to. Only
   facets that face this same field are listed; if several search pages facet the
   field, give the facets distinct labels so you can tell them apart.
4. **Update**, then **Save**.

Now the reference field renders as one-click links into your filtered search — no
custom Twig or preprocess code needed. Because the link is built from the facet's
own configuration, it always matches the facet's active URL format. You can set a
different formatter per view mode (say, facet links on teasers but the normal
display on the full page). Note that if no matching facet is selected, the field
simply renders nothing.
