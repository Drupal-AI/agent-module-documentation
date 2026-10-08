# Select2 — manual setup guide

**Select2** (machine name `select2_all`) makes Drupal's plain `<select>`
dropdowns searchable and easier to use by applying the popular **Select2**
JavaScript library to them automatically. Instead of scrolling through a long
list of taxonomy terms or referenced nodes, you get a type-ahead search box,
nicer styling, and — for multi-value fields — tag-style selection. The best part
is there's nothing to configure per field: enable the module and your admin
dropdowns are enhanced.

By default the module targets **admin context** — dropdowns on admin routes, or
when the admin theme is active — so your site's front-end forms are left
untouched unless you opt them in. It works entirely through Drupal's render
pipeline, attaching the Select2 library to `select` elements (and to custom form
element types whose name starts with `select_` or ends with `_select`). For
multi-value entity-reference selects it respects the field's cardinality and
removes the empty "- None -" option.

There is **no settings form, no config, no permissions, and no Drush command** —
this is a zero-configuration module. The only choices you make are per element
(opting a specific dropdown in or out) and where the Select2 library loads from
(a CDN by default, or a local copy). Both are described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Select2 has no admin page. Once enabled it works silently across the admin UI —
edit any content, view, or configuration form with a dropdown and you'll see the
enhanced, searchable select.

## How to use it

For most sites, using Select2 is simply: **enable it, and it works.** Log in,
open an admin form with a long dropdown (a node's taxonomy field, a Views filter
select, and so on), and it becomes a searchable Select2 widget. Multi-value
selects gain tag-style chips and honor the field's maximum number of values.

If you need finer control, there are two things you can adjust:

### Opting individual dropdowns in or out

By default Select2 applies to dropdowns in admin context and leaves front-end
forms alone. To change the decision for a specific element:

- **Force it on** (even outside admin) — add the CSS class `select2-enable` to
  the element, or set the form-API property `#select2 => TRUE`.
- **Force it off** — add the CSS class `select2-disable`, or set
  `#select2 => FALSE`. A disabled element gets no Select2 treatment at all.

These are element-level choices, typically made in a custom module or form
alter, not in the admin UI.

### Serving the Select2 library locally instead of from a CDN

Out of the box the Select2 library loads from a public CDN (jsDelivr). If you'd
rather serve it locally — for offline environments, stricter Content Security
Policy, or reliability — download the Select2 distribution and place it so that
these files exist under your Drupal root:

- `libraries/select2/dist/js/select2.min.js`
- `libraries/select2/dist/css/select2.min.css`

(On a typical layout that's `web/libraries/select2/dist/...`.) When that
directory is present, the module automatically uses the local copy instead of
the CDN. Rebuild caches (`drush cr`) after adding the files.
