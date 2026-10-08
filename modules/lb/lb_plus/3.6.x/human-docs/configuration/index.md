# Configuration

Layout Builder + does most of its work **on the layout canvas** rather than on a
settings page — the "configuration" that matters most is granting the right
permissions and knowing where the shared + Suite settings live.

## Permissions

Go to **People → Permissions** (`/admin/people/permissions`) and look for the
two permissions this module adds:

- **Administer Layout Builder + configuration**
  (`administer layout builder + configuration`) — lets a role manage the module's
  configuration. Grant this only to trusted administrators.
- **Promote Layout Builder + blocks** (`promote layout builder + blocks`) — lets
  a role promote selected blocks so they are easier to place from the sidebar.

Note that the module's on-canvas AJAX operations (place, move, duplicate, edit,
add section, and so on) are gated by core's own Layout Builder access — the same
requirement core's Layout Builder routes carry — so authority comes from who may
edit the layout, not from a separate Layout Builder + permission.

## The shared + Suite settings page

Layout Builder +'s configure link points to the **Navigation +** settings form
(route `navigation_plus.settings`), which is shared across the + Suite family
rather than being a form of `lb_plus`'s own. Because Layout Builder + is the
"Edit Mode native" version of Layout Builder for the + Suite, this is where
suite-wide editing behaviour is tuned. If you have installed the + Suite, you
will find this form under the Navigation + configuration provided by that module.

## Section Library and Block Decorator integration

If you enabled the optional submodules (see
[Installation](../installation/index.md)), their behaviour is configured through
the modules they integrate with — **Section Library** and **Layout Builder Block
Decorator** respectively — not through a dedicated Layout Builder + form.
