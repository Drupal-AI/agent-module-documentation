# Configuration

Search Exclude has **no settings page of its own**. You use it by creating a core
**Search page** that runs its *Content (Exclude)* plugin, and then choosing which content
types that page should keep out of the index. Enabling the module alone changes nothing.

## Create the search page

1. Log in as an administrator and go to **Configuration → Search and metadata → Search
   pages** (`/admin/config/search/pages`).
2. Click **Add search page**.
3. For the search type, choose **Content (Exclude)** — the plugin this module provides.
4. Give the page a **Label** (e.g. "Site search"), a **machine name**, and a **path**
   (the part after `/search/`, e.g. `node-exclude`).
5. In the **Exclude content types** checkbox group, tick every content type you want kept
   out of the index — for example a "Landing page" or "Component" type nobody searches for.
6. **Save** the page.

## Make it the site default (and turn off core Content search)

Creating the page is not enough on its own, because core still ships its own **Content**
search page. To make your new page the one people actually use:

1. Back on **Search pages**, set your new **Content (Exclude)** page as the **Default
   search page** (there is a control for this on the screen).
2. **Disable** the default **Content** search page so results only come from your
   exclusion-aware page.

## Re-index after changing the list

The excluded types are only kept out as new content is indexed — excluding a type does not
retroactively remove rows that are already in the index. After you create the page or
change the list of excluded types, re-index:

- Use **Re-index site** on the Search pages screen, or run `drush search:index`.

Each search plugin keeps its own index, so a brand-new *Content (Exclude)* page starts
from an empty index and fills up on the next cron run (or when you re-index).

## Good to know

- The excluded types also disappear from the advanced search form's "Only of the type(s)"
  options, so users cannot try to filter by a type that is not indexed.
- Editing or commenting on an *excluded* type never triggers a pointless re-index — the
  module only reacts to changes on the types you kept in.
- You can run two search pages side by side: one full index and one narrowed, at different
  paths.
- Leaving the *Exclude content types* list empty makes the page behave exactly like core's
  normal Content search.
