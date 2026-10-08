# Configuration

Domain Menus is configured on one settings form, plus two permissions that
control who may edit which menus.

## Open the settings form

1. Log in as a user with the Domain module's **Administer domains**
   (`administer domains`) permission — an administrator by default.
2. Go to **Configuration → Domain → Domain Menus**, or navigate directly to
   `/admin/config/domain/domain_menus`.

## Menu names

The central field is a list of menu **names**, one per line — short labels like
`main`, `alt`, or `footer`. These are *names*, not machine ids: the module builds
the actual per-domain menu id for you as `dm<domainId>-<name>` (for example
`dm1-main`). Each name must be alphanumeric and fewer than 10 characters.

## Bulk create and delete

Two operation checkboxes let you act on all the names at once:

- **Create menus** — tick this and save, and the module creates one menu per name
  per domain, assigning each to its domain automatically.
- **Delete menus** — tick this and save, and the auto-created domain menus for
  those names are removed.

These are one-time actions, not saved settings — they run when you submit the
form. The same create/delete also happens automatically when you add or delete a
domain, so new domains get their menus and removed domains have theirs cleaned up.

## Display and behavior options

- **Filter node-link autocomplete by domain** — on by default. When adding
  internal node links to a domain menu, the autocomplete only suggests nodes
  available on that domain.
- **Hide auto-created menus from the menu list** — off by default. Turn it on to
  keep the auto-generated domain menus out of the standard
  `/admin/structure/menu` list and reduce clutter.
- **Hide from the Admin Toolbar** — off by default. Turn it on to also hide those
  menus from the Admin Toolbar's menu dropdown.
- **Content types with domain menus available** — choose the content types whose
  node forms may use domain menus as an available menu parent.
- **Default parent menu name** — optionally pick one of your menu names to use as
  the default parent for new menu links added on node forms. Must be one of the
  names you listed (or left empty).

Click **Save configuration** to store your choices (and to run any create/delete
operation you ticked).

## Marking an existing menu as a domain menu

You do not have to use bulk-create. Any menu becomes a domain menu once it is
assigned to one or more domains. A user with core's **Administer menus** permission
can do this on the menu add/edit form using the **Domain(s)** checkboxes.

## The two editing permissions

Beyond core's **Administer menus** (which can edit *any* menu), the module adds two
domain-scoped permissions you grant on **People → Permissions**:

- **Edit assigned domain menus** (`edit assigned domain menus`) — lets a user edit
  the menus (and their links) of the domains they are assigned to.
- **Edit active domain menus** (`edit active domain menus`) — the same, but further
  limited to menus belonging to the **currently active domain**.

Both rely on Domain Access to determine which domains a user is assigned to, so
enable the `domain_access` submodule for them to take effect. Users with either
permission (or Administer menus) see the menus they may edit at **Structure →
Domain menus** (`/admin/structure/domain-menus`).

## Rendering a domain menu

To show the active domain's version of a menu on the front end, place the
**domain menu block** provided by the module (or the Superfish block from the
`domain_menus_superfish` submodule) in a region via **Structure → Block layout**.
The module also provides `menu__domain_menu` template suggestions so you can style
domain menus distinctly in your theme.
