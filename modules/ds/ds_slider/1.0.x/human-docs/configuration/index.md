# Configuration

DS Slider is set up from a single admin settings form, after which you decide
where the slider appears (as a block, at the `/ds-slider` page, or both).

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to the **DS Slider settings** form (route `ds_slider.settings`). The
   quickest way there is the module's **Configure** link on the **Extend** page
   (`/admin/modules`); it is also reachable from the admin configuration menu.

## Configure the slider

On the settings form you set up the slider's content and behaviour — the slides
it shows and how it responds across screen sizes. Configure the options to suit
your use case (for example a homepage hero carousel or a promotional banner),
then **Save**. Settings are stored through Drupal's configuration system and are
exportable with the rest of your site configuration.

## Choose where the slider appears

You have two display options, and you can use both:

- **As a block.** Go to **Structure → Block layout**
  (`/admin/structure/block`), place the **DS Slider** block in the region you
  want, and optionally set **visibility conditions** so it only shows on
  particular pages. You can place the block in more than one region.
- **As a page.** Link visitors to `/ds-slider`. This page is gated by the core
  **access content** permission, so it is visible to anonymous visitors — use it
  only for public content.

## Permissions

The module declares its own permission(s) in addition to the core **access
content** gate on the page. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant slider management to the appropriate
roles.

## A note on the display page's access

Because `/ds-slider` is anonymous‑readable, do not use the slider to present
access‑restricted content. For anything sensitive, rely on the block with
appropriate visibility/role conditions instead.
