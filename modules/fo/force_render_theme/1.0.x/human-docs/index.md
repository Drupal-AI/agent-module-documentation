# Force Render Theme — manual setup guide

**Force Render Theme** (`force_render_theme`) lets you **force a specific theme
when an entity is rendered through a view display**. Normally an entity renders
using whatever theme is active — the admin theme in the back office, the default
theme on the front end. With this module you can override that on a per‑view‑mode
basis, so a display always renders with the theme you choose regardless of where
it is shown.

The classic use is making back‑office previews and embeds look the way they will
on the live site: render an entity in the admin area using the front‑end theme so
what an editor sees matches the published result. It's equally handy for
previewing content with a different theme, or for using a specific theme for a
particular view mode such as teaser or full.

There's no central settings page — you set the theme per view display, right on
the **Manage display** page, in a "Theme settings" section this module adds.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You configure it per view
display, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own. You use it from **Structure →
Content types → *(type)* → Manage display → *(view mode)*** (and the equivalent
Manage display page for other entity types).

## How to use it

1. Go to the view‑display configuration you want to control — for example,
   **Structure → Content types → *(type)* → Manage display**, then select the view
   mode (Teaser, Full, etc.).
2. Find the **Theme settings** section that this module adds.
3. Select the **theme** to use when rendering this view display.
4. Save the configuration.

From then on, that view display renders with the theme you selected instead of the
active one.
