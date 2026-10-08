# Configuration

Every option lives on one settings page. Enabling the module here is what
actually switches on menu-based breadcrumbs — until you do, Menu Breadcrumb
leaves the existing (path-based) breadcrumb in place.

## Open the settings page

1. Go to **Configuration → User interface → Menu Breadcrumb**
   (`/admin/config/user-interface/menu-breadcrumb`).

The page opens with a short explanation at the top: Menu Breadcrumb generates the
trail from the **first match in the selected menus** — first looking for the
current page on a menu, then checking whether the page belongs to a taxonomy term
on that menu (whose breadcrumb it then inherits). If it finds neither a menu path
nor a taxonomy path, it generates nothing and leaves the field free for another
breadcrumb builder (such as the default path-based one) to fill.

![The Menu Breadcrumb settings page](../images/settings.png)

## The options, one by one

Work down the form and tick the checkboxes that match how you want the trail
built. Each option has help text directly beneath it on the page.

1. **Enable the Menu Breadcrumb module** — the master switch. Turn this on to use
   the menu the page belongs to (or the taxonomy term it is a member of) for the
   breadcrumb. If it is left unchecked, no breadcrumbs are generated or cached by
   this module and **every other option below is ignored**. Tick this first.

2. **Disable for admin pages** — when checked, the module does **not** build
   menu-based breadcrumbs on administration pages, leaving Drupal's own admin
   breadcrumbs alone. This is on by default and is usually the right choice.

3. **Append current page to breadcrumb** — when checked, and the current page is
   itself on a menu, that page is included as the final crumb in the trail. Leave
   it off if you want the breadcrumb to stop at the parent and not repeat the page
   you are already on.

4. **Show current page as link** — controls how that final current-page crumb is
   rendered. Check it to make the current page a clickable link; leave it
   unchecked (the default) to show it as plain text. This only matters when
   *Append current page to breadcrumb* is on.

5. **Stop on the first matching** — when checked, the trail ends as soon as the
   first matching menu item is found, rather than continuing to walk further up.

6. **Attach taxonomy member page to breadcrumb** — this covers the case where the
   current page is a member of a taxonomy term whose menu link has "Taxonomy
   Attachment" selected. The page then "attaches" to that term's menu-based
   breadcrumb and inherits it (the term's menu title shows as a link regardless of
   the current-page options above). Check this option to also show the current
   ("attached") page title as the final crumb.

7. **Remove "Home" link** — the module always checks whether the first crumb is
   the site's front page. Normally it *replaces* a node- or view-based front-page
   link (for example `/node/1`) with a link to the site home. Check this option to
   **delete** that front-page crumb entirely instead of replacing it.

8. **Add "Home" link** — check this to guarantee the trail begins with a link to
   the `<front>` page, adding one if the menu trail does not already start there.
   This ensures every page's breadcrumb starts at the site home. If both *Add* and
   *Remove* "Home" are set, *Remove* takes precedence when displaying the front
   page and its menu children.

9. **Home title** — a set of radio buttons choosing how that leading Home crumb is
   labelled. Pick **Use "Home" as title** for the literal word *Home*, or the
   option that **uses the site name** from the site's configuration (when that is
   not set, a translated value for "Home" is used).

## Choosing which menus are checked, and in what order

Below the options above, the form lists the site's menus so you can control which
ones Menu Breadcrumb consults and the order it tries them in. For each menu you
can:

- **Enable** it — only enabled menus are considered when building a trail.
- Set a **weight** — menus are tried in weight order, **lowest first**. Give the
  menu that should win (typically *Main navigation*) the lowest weight so it is
  checked before the others.
- Turn on **Taxonomy Attachment** — allow that menu's links to act as the anchor
  for the taxonomy-membership trail described in option 6 above.
- Set **language handling** — how the menu is treated on multilingual sites.

The module walks the enabled menus in weight order until it finds a trail
(respecting *Stop on the first matching*). This ordering is what decides which
menu supplies the breadcrumb when a page appears in more than one.

## Save

Click **Save configuration** at the bottom. Your settings are stored as
exportable configuration and take effect immediately — visit a page that sits in
one of your enabled menus and confirm the breadcrumb now follows the menu
hierarchy.
