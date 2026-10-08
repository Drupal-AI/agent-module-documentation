# Configuration

Info Banner is configured from its settings form (the `info_banner.settings`
route), reached under **Configuration**. Editing banners requires the permission
the module provides for administering banners, so grant that only to trusted
roles. This page walks through the options you will find there.

## The banner message

Enter the banner text in the rich-text field. Because it uses Drupal's normal text
formats, you can add links and basic formatting — pick a text format your editors
are allowed to use.

## Display style — where the banner appears

Choose how the banner is rendered:

- **Top of the page** — the banner is pinned across the top of the site.
- **In a specific element** — the banner is injected into a DOM element you name
  by its **ID**, so it appears exactly where your theme provides a slot for it.
  You supply the target element's ID.
- **Popup** — the banner appears as a modal popup over the page.

## Scheduling

Set an optional **start date** and **end date** so the banner activates and
expires automatically. This is ideal for maintenance windows and time-limited
promotions — you can configure it in advance and forget about it. Leave the dates
empty for a banner that shows until you turn it off.

## Dismissal

Enable the optional **close button** to let visitors dismiss the banner. When they
do, the choice is remembered with a cookie so the banner does not reappear on
every page. Leave it off for messages a visitor should always see (for example a
legal disclaimer).

## Path visibility

Use the **path conditions** to control which pages show the banner. Wildcards are
supported, so you can target whole sections of the site (for example a path
pattern ending in `*`) rather than listing individual pages. Leave the rules broad
for a truly site-wide notice, or narrow them for a page-specific message.

## Caching note

Info Banner is designed to be **Varnish-compatible**, so these settings continue
to work correctly behind edge caching — you do not need to disable caching to make
a banner appear.

## Save

Save the form, then reload the front end to confirm the banner shows in the right
place, on the right paths, and (if scheduled) within its active window. If you
need several banners at once, enable the **Info Banner Blocks** submodule and
create each one as a block under **Structure → Block layout**.
