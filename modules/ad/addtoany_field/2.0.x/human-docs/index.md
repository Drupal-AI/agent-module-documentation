# AddToAny Field — manual setup guide

**AddToAny Field** (`addtoany_field`) lets you attach
[AddToAny](https://www.drupal.org/project/addtoany) share buttons to content on a
**per-item** basis by providing them as a **field**. Where the main AddToAny module
typically places one site-wide share block or attaches buttons to a whole content
type, this module gives you a field type you can add to any fieldable entity — so
each node (or other entity) carries its own share links, controlled through the
normal Field UI.

It provides a field type together with its widget and formatter, and it reuses
AddToAny's own service configuration for which networks appear. It depends on the
AddToAny base module plus core's Node and Link modules, and works on Drupal 9.4 and
10.

There is no central settings page — you add and configure the field on a content
type using the standard **Manage fields**, **Manage form display**, and **Manage
display** screens. It is a front-end sharing widget with no access-control role of
its own.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no settings page of its own; you work entirely through the Field UI:

1. Go to the content type (or other entity) you want to add sharing to — for
   example **Structure → Content types → [your type] → Manage fields**.
2. Click **Add field** and choose the **AddToAny** field type. Give it a label and
   save.
3. On **Manage form display**, configure the field's widget so editors can control
   its share links per item.
4. On **Manage display**, choose the AddToAny formatter and set which services
   appear (drawing on AddToAny's own configuration), then position it where you
   want the buttons to render.

When you view that content, the share buttons appear wherever you placed the field
in the display. This complements the site-wide AddToAny block rather than replacing
it.
