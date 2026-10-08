# Views Autocomplete Filters — manual setup guide

**Views Autocomplete Filters** (`views_autocomplete_filters`) adds an
autocomplete (typeahead) dropdown to your Views exposed text‑field filters — and
the clever part is that the suggestions come from the view's *own results*. As a
user types into an exposed filter, they see real, access‑checked values that will
actually return rows, rather than a generic entity lookup or a list of things
that lead nowhere.

Under the hood the module extends four existing Views filter handlers — `string`,
`combine`, `search_api_text`, and `search_api_fulltext` — by swapping in
autocomplete‑capable versions. When one of those filters is exposed and renders as
a single text field, a **"Use Autocomplete"** checkbox appears in the exposed
filter's options; ticking it reveals the rest of the settings. As the visitor
types, an AJAX request re‑executes the view with the typed string and returns
matching rows as suggestions.

There is no site‑wide settings page and no permissions to grant — all
configuration lives per‑filter inside the Views UI, and it exports with the view.
The module needs only core **Views**; Search API filters are supported
automatically when Search API is present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no admin settings page. Everything happens inside the **Views** UI
(`/admin/structure/views`), on the options of an individual exposed filter.

## How to use it

Configuration is done per‑filter, right where you build the view:

1. Edit a view and add a filter on a text field that uses one of the supported
   handlers (`string`, `combine`, or a Search API text/fulltext filter). For a
   plain text field, the **"Contains"** operator works well.
2. **Expose the filter** (so visitors can type into it), and make sure its value
   renders as a single text field.
3. In the exposed filter's options, tick **Use Autocomplete**. New settings
   appear.
4. Choose the **Field with autocomplete results** — the view field whose value
   feeds the dropdown suggestions. (That field must be added to the view's field
   list first, so the module has something to suggest.)

Once enabled, you can fine‑tune the behavior with these options:

- **Minimum characters** — how many characters a user must type before suggestions
  appear (`autocomplete_min_chars`).
- **Number of items** — cap on how many suggestions are returned (`0` = no limit).
- **Dependent suggestions** — make suggestions respect the other exposed filters
  currently set (`autocomplete_dependent`).
- **Contextual suggestions** — let contextual filters / view arguments narrow the
  suggestions (`autocomplete_contextual`).
- **Auto‑submit** — automatically submit the exposed form as soon as the user
  picks a suggestion (`autocomplete_autosubmit`).
- **Raw dropdown / raw suggestion** — show raw database values in the dropdown
  (`autocomplete_raw_dropdown`) and/or insert the raw value rather than the
  rendered markup into the field when a suggestion is chosen
  (`autocomplete_raw_suggestion`).

Because suggestions are produced by actually running the view, they always respect
the view's access controls. And because the settings live in the exposed‑filter
config, they export with the view and deploy between environments like any other
Views configuration.
