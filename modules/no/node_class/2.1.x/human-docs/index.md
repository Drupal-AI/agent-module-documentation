# Node class — manual setup guide

**Node class** (`node_class`) adds a single **"CSS class(es)"** text field to
every node on your site, so an editor can type one or more CSS classes and have
them printed onto the rendered node's wrapper element. It is a tiny styling
helper: give one node a `featured` class, another a `two-column` class, and then
target them from your theme's CSS — no new content type, view mode, or template
edit required.

The field is a *base field*, which means it appears on **every** content type
automatically the moment you enable the module — there is nothing to add under
*Manage fields*. On the node add/edit form it shows up as a collapsible **"Node
Class settings"** group in the right-hand *advanced* sidebar (the same area as
Authoring information and URL alias). Whatever the editor types is stored with
the node (and travels with its revisions), then appended to the node's `class`
attribute when the node is rendered — the `<article>` element in most themes.

You can enter several classes at once by separating them with spaces (for
example `featured two-column`). They are stored as one value and printed as
multiple CSS classes in the final HTML. There is no admin settings page, no
permission of its own, and no configuration to export — the value is ordinary
node content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Node class has **no configuration page**. Once enabled it works everywhere at
once: open any node's add or edit form and you'll find the collapsible **"Node
Class settings"** group in the right sidebar, containing the **"CSS class(es)"**
field.

## How to use it

1. Edit any node (for example an Article).
2. In the right-hand sidebar, open the **Node Class settings** group.
3. Type one or more space-separated classes into **CSS class(es)** — for example
   `featured`, or `featured two-column`.
4. Save the node.
5. In your theme's CSS, target the class you typed — for example
   `.featured { … }`. When the node renders, that class appears on the wrapping
   `<article class="node … featured">` element.

Common uses include flagging a promoted article as `featured`, giving a landing
page a `full-width` class to trigger a wide layout, tagging seasonal content
with a `holiday` class, or attaching a JavaScript hook class such as
`js-carousel` so front-end behaviors can find the node.

### Hiding the field on a content type

Because the field is a base field you cannot delete it per content type, but you
can hide the input: on a bundle's **Manage form display** page, move the
**Node class** widget to the *Disabled* region. Any values already stored still
render on the node.
