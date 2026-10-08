# Configuration

Advanced Shortcodes has no settings form of its own. You "configure" it by turning
on the **Shortcode filter** in a text format and choosing which shortcodes that
format is allowed to use.

## Enable the shortcode filter on a text format

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the text format you want the shortcodes to work in
   (for example *Full HTML*).
4. In the **Enabled filters** list, tick the **Shortcode** filter (provided by the
   Shortcode module).
5. A settings section for the filter appears, listing the individual shortcodes.
   **Tick the specific shortcodes you want to allow** in this format — alerts,
   column, row, accordion(s), icon, jumbotron, progress, hr.
6. Check the **filter order** so the Shortcode filter runs in a sensible position
   relative to other filters, and keep the **Limit allowed HTML tags** filter in
   place on any format used by non-trusted users.
7. Click **Save configuration**.

Authors using that text format can now type the shortcodes into their content.

## Which format to enable it on

The advanced shortcodes produce rich Bootstrap markup, so treat them like any other
rich-markup filter: enable them on the formats your editors use and manage which
roles have access to those formats. As with core's *Full HTML*, keep rich formats
assigned to the editor/administrator roles that need them, and keep core's **Limit
allowed HTML tags** filter in place on the everyday formats that lower-trust or
anonymous users can reach. This is the standard Drupal text-format model — nothing
specific to configure in this module beyond ticking the shortcodes you want.

## What it does not need

There is no admin page, no permission, and no service to configure beyond the text
format filter above. The module attaches its Bootstrap CSS/JS automatically on the
front end and skips admin pages. If your theme already ships Bootstrap and you do
not want the module's copy, you can override that at the theme level.
