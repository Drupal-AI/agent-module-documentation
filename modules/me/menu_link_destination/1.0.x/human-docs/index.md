# Menu Link Destination — manual setup guide

**Menu Link Destination** (`menu_link_destination`) lets you flag individual menu
links so they automatically carry a `destination` query parameter. When a visitor
clicks a flagged link, Drupal knows where to send them back to afterward — the
destination points either to the `destination` value already on the current page's
URL, or, when there isn't one, to the current page itself.

The problem it solves is the "return here after you're done" pattern. Some
links — a login link, an edit link, an action that ends in a redirect — feel
smoother when they bring the user back to where they started. Rather than hard‑coding
that behavior, this module attaches the destination dynamically at render time, so
the same menu link does the right thing from whatever page it appears on. It applies
a `url` cache context to the affected links so caching stays correct.

There's no central settings page. You flag links in two ways: menu links defined in
code (YAML) get a `destination: true` property, and links created through the **Menu
Link Content** UI get a simple checkbox on their add/edit form. The destination
value comes from core's own `redirect.destination`, which rejects external URLs, so
the module adds no open‑redirect risk beyond core's guarded behavior. It has no
module dependencies of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module. You flag individual links, described
in "How to use it" below.

## How to use it

**For content menu links (created in the UI):**

1. Go to **Structure → Menus** (`/admin/structure/menu`), open a menu, and add or
   edit a link.
2. Tick the new **Add a destination query parameter** checkbox.
3. Save. That link now appends a `destination` parameter automatically wherever it
   is rendered.

**For menu links defined in code (YAML):**

Add a `destination: true` property to the link definition in your module's
`*.links.menu.yml` file:

```yaml
my_menu.link:
  title: 'My link'
  route_name: 'some.route'
  menu_name: menu
  destination: true
```

The link will then receive the same destination behavior as a UI‑flagged one.
