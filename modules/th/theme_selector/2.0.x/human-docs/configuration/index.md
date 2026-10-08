# Configuration

Theme Selector does nothing until you tell it which themes may be selected and
what query value chooses each one. You do that by creating **Theme Selector**
entities.

## Open the list

1. Log in as a user with permission to administer Theme Selector (an
   administrator by default — the module provides its own permissions, which you
   can grant to other roles at **People → Permissions**).
2. Go to **Configuration → User interface → Theme Selector**, or navigate directly
   to `/admin/config/user-interface/theme-selector`.

You'll see a list of the Theme Selector entities you have created. It starts empty.

## Add a selectable theme

Click **Add** (or the equivalent add-entity button) and fill in:

- **Theme** — pick the theme this entry should switch the page to. Only themes you
  choose here become reachable through the query string; anything you do not add
  stays unavailable, which is what keeps visitors from forcing an arbitrary theme.
- **Suffix** — the value you will put in the query string to trigger this theme.
  For example, if you set the suffix to `dark`, then visiting a page with
  `?theme-selector=dark` renders it with the theme you selected above.

Save the entity. Repeat for each theme you want to expose.

## Try it

With an entry in place, append the query parameter to any page URL — for example
`https://example.com/?theme-selector=dark`. The page should render with the theme
you mapped to that suffix.

## Good to know

- **Keep the list tight.** Add only themes you actually intend people to be able
  to switch to. Reviewing this list is the main thing that keeps theme switching
  safe.
- **Caching.** Because the theme is decided from a query parameter, page cache is
  disabled for requests that carry it. This is expected — plan for it on
  high-traffic pages.
