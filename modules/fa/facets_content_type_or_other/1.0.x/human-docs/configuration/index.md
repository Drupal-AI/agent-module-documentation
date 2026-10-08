# Configuration

Setting up this module is a short sequence: configure the labels and "Other"
grouping, add the field to your search index, create the facet, choose its sort,
and re‑index. Work through the steps in order.

## 1. Configure the "Content type or Other" settings

1. Log in as an administrator.
2. Go to **Configuration → Search and metadata → Content type or Other**, or
   navigate directly to `/admin/config/search/facets-content-type-or-other`.
3. On this form you decide **how each content type is labelled** in the facet and
   **which content types are grouped into the "Other" bucket**. The content‑type
   labels can be overridden here, so the facet can read exactly how you want (for
   example *Article*, *Basic page*, *Other*).
4. Save the form.

## 2. Add the field to your Search API index

Open your Search API index, go to its **Fields**, and add the **"Content type or
other"** field the module provides. This is the field that carries the grouped
value into the index so it can be faceted.

## 3. Add a facet

On the **Facets** admin page (**Configuration → Search and metadata → Facets**),
add a new facet for the **Content type or other** field you just indexed, and
attach it to the appropriate search display.

## 4. Set the sort order

On the facet's edit form, open **Facet sorting** and:

- Select **"Content type or Other - Sort order"**.
- Make sure **all other sorting options are deselected** — this dedicated sort is
  what keeps your specified types and the "Other" bucket in the intended order.

## 5. Re‑index

Re‑index all content so the "Content type or other" value is populated for every
item. Until you re‑index, existing content will not yet carry the grouped value
and the facet may look incomplete.

## Verify

Load the page that shows the facet and confirm the content types appear with your
chosen labels, that the grouped types collapse into **Other**, and that the order
matches what you configured.
