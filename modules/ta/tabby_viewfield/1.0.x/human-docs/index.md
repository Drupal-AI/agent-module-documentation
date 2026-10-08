# Tabby Viewfield — manual setup guide

**Tabby Viewfield** (`tabby_viewfield`) adds a field formatter that renders a
**Viewfield** as a set of tabs. A Viewfield is a field that embeds Views inside an
entity; when it has more than one item, Tabby Viewfield lets you display each
embedded view in its own tab — a tidy way to present several related views in one
compact, tabbed interface without any custom templating.

For each tab you can set a **title** and an array of **behaviours** to attach, all
from the formatter's settings on the entity's *Manage display* tab. The actual tab
rendering is done by the **Tabby** (`tabby`) module, which this module depends on,
so make sure Tabby (and its JS library) is installed too.

This is a content-display feature: it changes how a Viewfield is presented and has
no access-control role of its own — the views inside still respect their own
access. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Tabby) and
   enable the module.

## How to use it

There is no central settings page — you configure it per field:

1. Make sure the entity has a **Viewfield** (a field of type *viewfield*).
2. Go to that entity's **Manage display** tab.
3. For the Viewfield, choose the **Tabby viewfield** format.
4. Open the format's settings and set each tab's **title** and any **behaviours**
   that should be attached.

With multiple views in the field, each will now appear under its own tab.
