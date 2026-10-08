# Configuration

Link Icons is configured in two places: the **per‑field formatter options** on
Manage display (how a given link field's icons look), and the site‑wide **Link
icon services** page (which hostnames map to which icons).

## Per‑field formatter options

1. Go to **Structure → Content types → *(your type)* → Manage display** for an
   entity that has a link field.
2. In the **Format** column for the link field, choose **Service icon (with
   options)** and save.
3. Click the **settings gear** next to the formatter to reveal its options.

The options control how each recognised link is rendered — for example whether to
show the link **label** alongside the icon or the icon alone, the **icon size**,
and the other Font Awesome display features the module exposes. The options are
intended to be self‑explanatory; each is documented on the module's help page at
**Administration → Help → Link Icons formatter** (`/admin/help/link_icons`).
Adjust them, then click **Update** and **Save** on the Manage display form.

## Site‑wide brand services

The mapping from a hostname to an icon (plus its colour and CSS class) lives in
configuration entities that you manage centrally:

1. Go to **Configuration → Search and metadata → Link icon services**
   (`/admin/config/search/link_icon_services`).
2. Here you can **add**, **modify**, or **remove** service definitions. Each
   service ties a hostname (for example `mastodon.social`) to the Font Awesome
   icon to display, a colour, an HTML class, and related settings. The meaning of
   every field is explained on the help page (`/admin/help/link_icons`).

Enabling the **Link Icons Brands** submodule populates this list with a large set
of common brands, so in most cases you only visit this page to add a service the
module does not ship, or to override the icon or styling of one it does. A navy
generic globe icon is used for any URL whose hostname is not in this list.

Access to this page is controlled by the **Administer link icon services**
permission, which you grant at **People → Permissions**.

## Styling the icons further

Because the icons are rendered as Font Awesome text characters, you can style
them with CSS in your theme as you would any other text — size, colour, spacing —
beyond the options offered on the formatter and services pages.
