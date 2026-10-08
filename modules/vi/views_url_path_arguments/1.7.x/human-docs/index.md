# Views URL Path Arguments — manual setup guide

**Views URL Path Arguments** (`views_url_path_arguments`) lets a view's
contextual filter accept a human-readable **URL alias** in the address and
resolve it to the underlying entity ID. In plain terms: it lets a view live at a
clean path like `/blog/my-article-title` instead of a numeric one like
`/blog/42`, while the view still filters on the numeric ID internally.

It does this by adding two small Views plugins — an **argument default** and an
**argument validator**, both called *"Entity ID … from URL path alias"*. You
attach one (or both) to a contextual filter such as *Content: ID*. At runtime the
plugin reads the last part of the current path; if it is not already a number it
looks it up as a path alias and hands the resolved entity ID to the view.
Numeric values pass straight through, so the same view keeps working at both
aliased and numeric URLs.

There are only two options, shared by both plugins: a checkbox to **prepend a
static URL segment** and the **segment(s)** text itself — useful when your
aliases sit under a fixed prefix (for example `blog`, so `blog/my-title`
resolves). It depends on core's **Path Alias** (`path_alias`) and **Views**
(`views`) modules and adds no admin page, settings form, permissions, or Drush
commands — everything is configured per view inside the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is **no admin settings page** — you configure this on the view itself.

1. Edit your view and open its **contextual filter** (add one first if needed,
   e.g. **Content: ID**).
2. To derive the value from the current page's alias, under *"When the filter
   value is NOT in the URL"* choose **Provide default value → Type: "Entity ID
   converted from URL path alias"**.
3. To validate an alias that arrives *in* the URL, under *"When the filter value
   IS in the URL or a default is provided"* choose **Specify validation
   criteria → Validator: "Entity ID from URL path alias"**.
4. If your aliases live under a fixed prefix, tick **"Provide a static URL
   segment(s) to prefix aliases?"** and enter the prefix (for example `blog`)
   **without** leading or trailing slashes.
5. Save the view.

The plugin looks the alias up in the current URL language, so it behaves on
multilingual sites, and it caches the resolved value per URL for performance. If
an alias cannot be resolved, the validator fails the argument (typically a 404),
keeping stray URLs out of the view.
