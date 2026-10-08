# Entity Overlay — manual setup guide

**Entity Overlay** (`entity_overlay`) displays a referenced content entity as a
**modal overlay** instead of sending the visitor off to a full page. Showing a
detail view — a product, a team member, a related article — in an overlay keeps the
user in context: they open the overlay, read the content, and close it without ever
leaving the page they were on.

It works as a **field formatter for entity reference fields**, and it offers two
styles. The **Label overlay** renders the referenced entity's title as a link that
opens the overlay, and the **Rendered entity overlay** renders the entity in a view
mode you choose (such as *teaser*) and opens the full rendered content in the
overlay. You pick the view mode used inside the overlay as part of the formatter's
settings.

Under the hood the overlay is a **jQuery UI dialog**, which comes from Drupal core,
so there's nothing extra to install for the popup itself; styling can be customized
by overriding the dialog stylesheet from your theme (see "How to use it"). Entity
Overlay runs on Drupal 10.1 and 11 and has no module dependencies.

The overlaid entity renders with its **normal access checks**, so the overlay does
not bypass access — an entity a user isn't allowed to view won't render in the
overlay either. Still, it's worth confirming that the overlay's loading respects
access and behaves correctly with your entity's view modes. Note that the module is
**not** covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — you set it up per field on
**Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

Entity Overlay adds no menu item. You use it from a bundle's display settings under
**Structure → Content types (or any entity type) → *(bundle)* → Manage display**.

## How to use it

1. Add (or find) an **entity reference** field on a content type or other fieldable
   entity.
2. Go to that bundle's **Manage display**, find the reference field, and set its
   **Format** to either **Label overlay** or **Rendered entity overlay**.
3. Configure the formatter — for the rendered option, choose the **view mode**
   (for example *teaser*) used to render the entity inside the overlay.
4. Save the display. The reference now opens the referenced entity in a modal
   overlay instead of navigating away.

> **Styling the overlay:** the overlay uses core's jQuery UI dialog. To restyle it,
> add a `css/overrides/dialog.css` in your custom theme and declare a
> `libraries-override` for `core/jquery.ui.dialog` in your theme's `.info.yml`.
