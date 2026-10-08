# Configuration

Core Views Facets has no settings form of its own. "Configuring" it means walking
through a short workflow across your **view**, the **Facets** UI, and **Block
layout**. Follow the steps in order — step 3 (the URL processor) is the one people
most often miss, and facets simply won't filter without it.

## Step 1 — Prepare the view

You need a **View** that has:

1. At least one **page** display (a display with a real URL path), and
2. On that display, at least one **exposed filter** and/or one **contextual filter
   (argument)**.

The exposed/contextual filters are what become facets. For example, a "Content
catalogue" view page with an exposed *Content type* filter and an exposed *Tags*
(taxonomy) filter can become two facets.

After creating or editing the view, run `drush cr` (or clear caches) so the facet
sources refresh — the module also clears them automatically when a view is saved.

## Step 2 — Find the facet source

Go to **Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`). Your view display now appears as one or two
**facet sources**:

- one for its **exposed** filters (named like
  `core_views_exposed_filter:<view>__<display>`), and
- one for its **contextual** filters (named like
  `core_views_contextual_filter:<view>__<display>`).

## Step 3 — Set the URL processor (required)

Open the **facet source** for your view display and set its **URL processor** to
**"Core views url processor"**. Save.

This step is mandatory. That URL processor is what formats the facet links so they
round-trip through Views' exposed filters correctly. If you leave the default URL
processor in place, clicking a facet value will *not* filter the view — this is the
single most common reason a setup "doesn't work."

## Step 4 — Add a facet

Go to **Add facet** (`/admin/config/search/facets/add-facet`) and:

1. Choose the **core-views facet source** you just configured.
2. Pick the **field** — for an exposed-filter source this is one of the view's
   **exposed filter** identifiers (e.g. the *Content type* filter); for a
   contextual source it's the **argument** id.
3. Give the facet a name and save.
4. Configure the facet's **widget** (for example *List of links*, optionally with
   result counts shown) and any processors you want, exactly as you would for any
   Facets facet.

Repeat for each filter you want to expose as a facet.

## Step 5 — Place the facet block

Each facet is a block. Go to **Structure → Block layout**
(`/admin/structure/block`), place the facet's block (its plugin is
`facet_block:<facet_id>`) into the same region as the view — typically a sidebar
beside the listing — and save. Configure the block's visibility so it shows on the
view's page.

## The result

Visitors can now drill down the listing by clicking facet values, and multiple
facets combine so they can filter by several attributes at once. A few behaviours
worth knowing:

- **AJAX views refresh in place.** If the underlying view display has AJAX enabled,
  the module attaches a small library so facet blocks update without a full page
  reload.
- **Cleanup is automatic.** If you delete the view display, its facet sources and
  their facets are removed for you, so you won't be left with orphaned config.

## Extending to custom filters (developers)

Under the hood each Views filter/argument is handled by a "filter type" plugin that
knows how to build the facet's count query and render its values. The module ships
handlers for taxonomy terms, node bundles and booleans, plus a generic fallback. If
you have a custom Views filter that needs special handling, you can add your own
filter-type plugin — see the [`agent/`](../agent/start.md) docs for the plugin
interface and a skeleton.
