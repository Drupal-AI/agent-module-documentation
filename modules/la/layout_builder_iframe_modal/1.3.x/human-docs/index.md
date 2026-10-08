# Layout Builder iFrame Modal — manual setup guide

**Layout Builder iFrame Modal** (`layout_builder_iframe_modal`) renders Layout
Builder's block and section edit forms inside a centered iframe dialog styled with
your site's admin theme, instead of core's off-canvas tray rendered in the
front-end theme.

Out of the box, core Layout Builder opens every "Add block", "Configure section",
"Move block" and similar form in the narrow off-canvas tray, using the front-end
theme. That forces themers to re-style complex widgets — tabs, entity
autocomplete, the media library, entity browser — so they work in that cramped
space. This module instead opens the very same form in an iframe whose source is
the form's own route, so it renders in the admin theme, fully isolated from
front-end CSS. Complex block widgets just work, and there is no front-end theming
burden.

When an inner form saves successfully, the module briefly redirects to a small
page that uses `postMessage` to tell the parent window to close the modal, rebuild
the layout, and scroll back to the edited block — so the editing flow feels
seamless. It also adds a "Rebuild" action to the layout and is compatible with
`layout_builder_st` translation routes.

Which routes get this iframe treatment is controlled by one configuration object
with two lists: the built-in Layout Builder routes (all ten are enabled by
default) and an optional list of extra "custom" dialog routes you opt in. A
settings form lets you toggle them, protected by a dedicated permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Layout Builder dependency, and enable it.
2. [Configuration](configuration/index.md) — the settings form, the two route
   lists, and the permission that guards them.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Layout Builder
iFrame Modal** (`/admin/config/content/layout_builder_iframe_modal`), gated by the
*Configure layout builder iframe modal* permission.

## How to use it

Enable the module and, in most cases, you are done — all ten built-in Layout
Builder routes open in the iframe modal by default. Open any Layout Builder layout
and click "Add block" or "Configure section" to see the admin-themed dialog. Use
the [Configuration](configuration/index.md) page only if you want to limit which
routes use the modal or opt an extra route in.
