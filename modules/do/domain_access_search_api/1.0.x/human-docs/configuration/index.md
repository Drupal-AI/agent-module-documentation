# Configuration

This module has no settings page. You configure it in two places you already use:
the **Search API index** and the **view**. Follow these three steps.

## 1. Index the required fields

Open your Search API index at
`/admin/config/search/search-api/index/<id>/fields` and add:

- **`field_domain_access`** (add it as type **string**) — **required**. This is
  the field the filter matches against. Without it on the index, the filter has
  nothing to compare and cannot restrict anything.
- **`field_domain_all_affiliates`** (type **boolean**) — required only if you plan
  to enable the all-affiliates processor in step 2.

Save the index and reindex its content so the new fields are populated.

## 2. (Optional) Enable the all-affiliates processor

If you have content marked "send to all affiliates" and want it to appear in every
domain's search results, enable the processor on the index's **Processors** tab:
**"Apply domain access all affiliates to allowed domains property"**.

What it does: while indexing, for any item whose `field_domain_all_affiliates` is
true, it rewrites that item's indexed `field_domain_access` value to include *every*
domain's id. As a result the item matches the current-domain filter no matter which
site is searched. **Reindex** after enabling it so existing content picks up the
change.

Skip this step if you do not use the all-affiliates flag — the filter works fine
on its own.

## 3. Add the filter to a view

Edit any view whose data source is your Search API index, and add a filter:

- Under the **Domain** group, choose **Search API: Current domain**
  (`current_all`).
- It is a simple Yes/No filter — there is no operator selector.
- Set the value to **Yes** to restrict the view to the visitor's current domain.
  This is usually a fixed (non-exposed) value; leaving it *No* or empty adds no
  condition and returns everything indexed.

At runtime the filter reads the active domain from Domain's negotiator and adds a
`field_domain_access = <current domain id>` condition to the search query. It also
adds the `url.site` cache context, so results are cached separately per domain.

## Important: this is a display filter, not access control

The filter only narrows results **when you add it to a view and set it to *Yes***.
It does not automatically enforce Domain Access on Search API queries the way node
access grants do. If a search view must never leak other domains' content, you are
responsible for adding this filter (value *Yes*) to **every** such view — omitting
it returns all indexed items regardless of domain. Treat it as query scoping for
site-building, not as a substitute for real access control.
