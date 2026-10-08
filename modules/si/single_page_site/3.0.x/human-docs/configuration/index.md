# Configuration

The configuration is short, but one part — telling the module where your menu sits in
the page — is theme-specific and worth testing.

## Open the settings form

1. Log in as a user with the **Administer single page site** permission.
2. Go to **Configuration → System → Single Page Site**
   (`/admin/config/system/single-page-site`).

## Choose the menu

- **Menu** — pick the menu you want to turn into a single page. The module renders the
  content behind that menu's links onto one page, in the menu's order.

## Point the module at your theme's menu wrapper

- **Menu wrapper class or id** — the CSS class or id of the menu wrapper in your theme,
  so the link-rewriting can find the menu to rewrite. This is **theme-specific**: a
  value such as `#block-themename-main-menu` depends on your theme's block id, so check
  it against your actual markup rather than assuming.

## Control which menu items are included

- **Menu item class(es)** — the class you want the single-page navigation to apply to.
  Only menu links carrying this class are overridden with an anchor and rendered on the
  page. Leave this blank to include *all* menu items. This is how you keep an item on a
  separate page — for example a contact form you do not want folded into the one-pager.
  After setting a class here, go to **Structure → Menus → [your menu]** and add that
  class to the menu links that should appear on the single page.
- **Hide an item from the menu but still render it** — give a menu link the class
  `hide` to render its content on the single page without the item showing up in the
  menu itself.
- **Section titles** — by default each section uses the menu item's title as its
  heading; you can instead use the menu link's *name* attribute as the section title.

If you have the **Link Attributes** module, it integrates here to help you set those
per-item classes cleanly.

## View the result

Once configured, visit **`/single-page-site`** to see your one-pager. Remember the
page is access-controlled by the **View single page site** permission, so grant that
to the roles that should be able to see it.
