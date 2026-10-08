# Field Select Filter — manual setup guide

**Field Select Filter** (`views_field_select_filter`) adds a Views **exposed
filter** that turns a single text or integer field into a dropdown populated with
the values that actually exist in that field. Instead of asking visitors to type
an exact value into a text box — and risk misspelling it or landing on an empty
result set — you give them a select list built from the real, distinct values
stored in the field.

It works automatically: for every `string` and `integer` field on your site, the
module registers a second filter handler next to the field's normal one, labelled
**"<Field label> (selector)"**. You add that "(selector)" filter to a view and
expose it; when the page loads, the module runs a `SELECT DISTINCT` against the
field and uses the returned values as the dropdown options. If your view also
filters by content type, the options are scoped to just those bundles. Two extra
expose settings let you order the options ascending or descending and, on
multilingual sites, limit them to the current language.

There is no settings page, no permission, and nothing to configure globally — you
simply add the filter to a view. It's a lightweight, self-maintaining alternative
to a hand-curated "allowed values" list or a full faceted search for a single
low-cardinality field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no settings page. You use it entirely in the **Views UI**
(*Structure → Views*) when adding and exposing a filter.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit a view at *Structure → Views* and, under **Filter criteria**, click
   **Add**.
3. Find the field you want to filter on — the module has added a second entry
   labelled **"<Field label> (selector)"**. Add that one (not the field's plain
   filter).
4. Choose **Expose this filter to visitors** when prompted, then configure the
   two extra expose options:
   - **Value order** — sort the dropdown options **ascending** or
     **descending**.
   - **Options in current language only** — on multilingual sites, restrict the
     options to values in the visitor's current interface language. (This option
     only appears when the site has more than one language.)
5. Save the view. The exposed filter now renders as a select list of the field's
   distinct values, and it can be a multi-select (an "is one of" filter), so
   visitors can pick several values at once.

A couple of notes:

- The filter only does anything when **exposed** — as a non-exposed filter it has
  no value form and stores nothing.
- Only single-value **string** and **integer** fields are supported.
- The dropdown's option list is built with a direct query that is **not**
  node-access filtered, so option values could include ones from content the
  viewer can't otherwise see (the actual result rows are still access-checked by
  Views). Avoid using it on fields whose mere values are sensitive.
