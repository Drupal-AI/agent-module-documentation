# Views Taxonomy Term Name Into ID — manual setup guide

**Views Taxonomy Term Name Into ID** (`views_taxonomy_term_name_into_id`) lets a
View accept a human-readable taxonomy **term name** in the URL and quietly convert
it to that term's numeric **ID** before the query runs. That means you can serve a
friendly URL like `/blog/jazz` instead of `/blog/12`, while the View still uses the
fast, index-based "Has taxonomy term ID" filter under the hood.

It does this by adding one Views **contextual filter (argument) validator** called
**"Taxonomy term name as ID"**. When you configure a term-ID contextual filter to
"Specify validation criteria" and pick this validator, an argument such as `jazz`
is looked up by name; if a matching term is found (and the visitor is allowed to see
it), the argument is swapped for the term's ID. You get clean, SEO-friendly,
editor-friendly URLs without giving up query performance — and without exposing
numeric IDs to your visitors.

There is nothing to configure outside of a View: no settings form, no admin page,
no permissions. You wire it up entirely inside the Views UI. It works on Drupal 8
through 11 and depends on core's **Views** and **Taxonomy** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds **no page of its own**. Its only footprint is a new **Validator**
choice — *Taxonomy term name as ID* — that appears when you edit a taxonomy-term-ID
contextual filter inside any View.

## How to use it

1. Edit a View that has a **taxonomy term ID** contextual filter — usually
   **"Has taxonomy term ID"**. Add it under **Advanced → Contextual filters** if it
   is not there yet.
2. Open that contextual filter and tick **Specify validation criteria**.
3. In the **Validator** drop-down, choose **Taxonomy term name as ID**.
4. Optionally set:
   - **Filter to vocabulary** — restrict the name lookup to one or more
     vocabularies. Strongly recommended if the same term name could appear in more
     than one vocabulary, because the lookup assumes names are unique and only the
     first match is used.
   - **Transform dashes in URL to spaces** — so `new-york` matches the term
     "new york".
   - **Access checking** — only resolve terms the current user is allowed to view.
   - **Action to take if the value does not validate** — e.g. *Hide view / Page not
     found* — which applies when no term matches the name.
5. Save. A page display at, say, `/blog/%` now accepts a term *name* in that URL
   segment, and the validator converts it to the term ID before the query runs.
