# Menu Animate — manual setup guide

**Menu Animate** (`menu_animate`) brings the cross-browser CSS animations from
the popular [Animate.css](https://animate.style/) library to Drupal menus. It
lets you attach a polished, configurable animation — fade, slide, and the rest of
the Animate.css catalogue — to a menu link, so dropdowns and menu transitions get
a bit of motion without you writing any custom CSS or JavaScript.

The problem it solves is small but real: adding tasteful animation to navigation
usually means hand-writing CSS keyframes and wiring them into your theme. Menu
Animate does that for you by exposing an animation choice right on the menu link
edit form, backed by Animate.css.

This is a **theming enhancement** — it carries no content or access role of its
own. Its only dependency is core's **Menu UI** module (`menu_ui`), and it works
on Drupal 8.8 through 11.

Menu Animate does not need a global settings page; the animation is chosen
**per menu link**, described under "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — Menu Animate has no site-wide
settings form. You pick an animation on each menu link, as described below.

## Where it lives in the admin menu

Menu Animate adds its controls to the standard menu system at **Structure →
Menus** (`/admin/structure/menu`). Edit any menu link and you will find the
**Menu Animate** options on that link's configuration form.

## How to use it

1. Go to **Structure → Menus** and choose the menu you want to animate.
2. Click **Edit** on a menu link (or add a new one).
3. In the link's configuration form, find the **Menu Animate** section and pick
   the Animate.css animation you want for that item.
4. Save the menu link.
5. View the front end and trigger the menu (for example, hover to open a
   dropdown) to see the animation.

Repeat per link for each item you want to animate. Because the effects come from
Animate.css, the available choices are the standard Animate.css animation names.
