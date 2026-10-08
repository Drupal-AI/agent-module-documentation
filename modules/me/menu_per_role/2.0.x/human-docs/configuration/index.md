# Configuration

Menu Per Role has two layers: **global settings** that decide which fields appear
and where, and the **per-link role fields** that actually restrict a link.

## Global settings

Go to **Configuration → System → Menu Per Role**
(`/admin/config/system/menu_per_role`), which requires the **Administer Menu Per
Role settings** permission. Settings are stored in the `menu_per_role.settings`
config object and export with `drush config:export`.

- **Which checkbox sets to show** (`hide_show`, default **both**) — choose whether
  menu-link edit forms show both role fieldsets, only the "Hide from" set, or only
  the "Show to" set.
  - **Warning:** switching this to hide a set of checkboxes does **not** clear any
    selections already made — hidden selections still take effect, they just
    become invisible on the form. Clear them before hiding the field if you don't
    want them to apply.
- **Show role fields on links pointing to content** (`hide_on_content`, default
  **Never**) — whether the role fields appear on links that point to nodes. The
  options are Always, "only if no node-access modules are enabled," or Never. The
  idea behind the default is that node access modules are usually the better tool
  for content links, so the fields are hidden there to steer you toward them.
- **Administrator bypass** (a details section with two checkboxes):
  - **Bypass in the front-end context** (`admin_bypass_access_front`, default
    **off**) — when on, users with an administrator role ignore Menu Per Role
    restrictions on front-end menus.
  - **Bypass in the admin context** (`admin_bypass_access_admin`, default **on**) —
    when on, administrator-role users ignore restrictions on admin menus, so they
    always see every admin link.

You can also set these from the command line, e.g.
`drush config:set menu_per_role.settings hide_show 2 -y`.

## The per-link role fields

This is where you actually restrict a link. Edit a content menu link (in the menu
admin UI or in a node's menu settings). Subject to the global settings above **and**
your holding the **Assign menu role visibility** permission, you'll see:

- **Roles able to see the menu link** (the "show" field) — if you tick any roles
  here, the link is hidden from everyone **except** users who have at least one of
  those roles.
- **Roles not able to see the menu link** (the "hide" field) — if you tick any
  roles here, the link is hidden from anyone who has any of those roles.

The rules:

- Leave both empty → the link keeps its normal visibility; the module adds no
  restriction.
- "Show" roles set → only accounts with one of those roles see the link.
- "Hide" roles set → accounts with any of those roles don't see the link.

Remember these fields only affect what shows in the **menu tree**. They do **not**
protect the link's target route, and they only apply to content menu links —
links defined by modules (Views, `*.links.menu.yml`) can't be managed here.

## Save

Save the settings form and each menu link as you edit it. Menu visibility updates
according to the current user's roles.
