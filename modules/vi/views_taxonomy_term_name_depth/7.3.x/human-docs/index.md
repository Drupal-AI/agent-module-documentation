# Views Taxonomy Term Name Depth — manual setup guide

**Views Taxonomy Term Name Depth** (`views_taxonomy_term_name_depth`) adds one
Views contextual filter (argument) that matches content by taxonomy **term name**
instead of the numeric term ID — and can optionally pull in content tagged with
parent or child terms, using a configurable **depth**. It's the tool you reach
for when you want clean, readable URLs like `/articles/news` driving a view,
rather than `/articles/12`.

Where Drupal core's contextual filters key off term IDs, this one accepts a
human-readable term name in the URL. Because the module depends on **Pathauto**,
it resolves incoming names through Pathauto's alias cleaner: a slug like
`new-products` matches the term "New Products", so matching is case- and
separator-insensitive and stays aligned with your Pathauto term aliases. Editors
can even rename terms without breaking URLs that key on the cleaned name.

The **depth** option walks the taxonomy hierarchy. A positive depth also returns
content tagged with descendant terms (filtering "Fruit" at depth 1 also returns
nodes tagged "Apple"); a negative depth walks upward toward ancestors. A
**vocabularies** option restricts which vocabularies are searched — handy when
the same name exists in several — and an **Allow multiple values** option lets a
visitor pass `Apple+Pear` for an OR match. The module also ships a companion
default-argument plugin, "Taxonomy term parent ID from URL" (`taxonomy_tpid`),
that supplies a term's parent ID from the current taxonomy-term or node route.

The module has **no settings form, no permissions, and no Drush commands** — all
configuration lives inside the Views UI, on the contextual filter itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Pathauto is
   required) and enable the module.

## Where it lives in the admin menu

There is no admin settings page. Once the module is enabled, the new filter
appears inside the **Views UI** (`/admin/structure/views`) when you edit any view
whose base table is **Content**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit or create a view whose base is **Content**.
3. Under **Advanced → Contextual filters**, click **Add** and choose **"Has
   taxonomy term NAME (with depth)"** (in the *Content* category).
4. Configure the options and save:
   - **Depth** — `0` (default) matches the exact term only; a positive number
     also matches descendant terms that many levels down; a negative number
     walks up to ancestors.
   - **Vocabularies** — leave empty to search all, or pick specific vocabularies
     to disambiguate identically named terms.
   - **Allow multiple values** — accept `TermA+TermB` in the argument as an OR
     match.
   - Plus the standard core argument options (what to do when the argument is
     missing, validation, and so on).
5. Visitors now supply a **term name** in the URL argument position — for
   example `/my-view/news` — and the view returns matching content, including
   descendants or ancestors according to the depth you set.

Because the filter lives on the node base table, it offers fewer options than
core's term-ID filters and drops the "summary" default-action variants — but in
exchange you get readable, name-based URLs with full depth behavior.
