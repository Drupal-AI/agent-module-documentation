# Creating a URL alias pattern

A **pattern** is the template Pathauto uses to build an alias for a given kind of
content. You write it once — for example `blog/[node:title]` — and every matching
entity gets an alias from it automatically when it is saved. Patterns are the heart
of Pathauto; this page walks through adding one.

## Open the Patterns tab

1. Go to **Configuration → Search and metadata → URL aliases**
   (`/admin/config/search/path`).
2. Click the **Patterns** tab (`/admin/config/search/path/patterns`).

This page lists every pattern already on the site and lets you edit and reorder
them. Click **+ Add Pathauto pattern** to create a new one.

![The Patterns tab with the Add Pathauto pattern button](../images/patterns.png)

## Fill in the pattern form

The add form has a few fields:

1. **Pattern type** — choose the kind of entity this pattern applies to, such as
   **Content** (nodes), **Taxonomy term**, or **User**. The list is populated from
   the [entity types you enabled](../configuration/index.md) on the Settings tab.
   Selecting a type reveals the rest of the form.

2. **Path pattern** — the template itself, written with **Token** placeholders.
   For example:
   - `blog/[node:title]` — every node gets `/blog/<its-title>`.
   - `[node:content-type]/[node:title]` — group by content type.
   - `topics/[term:name]` — clean paths for taxonomy terms.
   - `members/[user:account-name]` — user profile aliases.

   Use the **Browse available tokens** link on the form to see every placeholder
   valid for the chosen type. Pathauto cleans the resolved value using your
   [global settings](../configuration/index.md) — lowercasing, replacing spaces
   with the separator, and so on.

3. **Conditions** (selection criteria) — optionally restrict the pattern so it only
   applies in certain cases, for example only to a specific content type or only in
   a particular language. If you leave conditions empty, the pattern applies to
   every entity of the chosen type. When several patterns target the same type,
   Pathauto tries them in order and uses the first one whose conditions pass, so
   put more specific patterns above more general ones.

4. **Label** — a human-readable name so you can recognise the pattern in the list.

Click **Save** to store the pattern.

## What happens next

From now on, saving a matching entity generates its alias automatically. The new
pattern only affects content saved *after* it exists — to give aliases to content
that already exists, run a [bulk generate](../bulk-generate/index.md). If you later
edit the pattern, existing aliases are not rewritten until you regenerate them the
same way.
