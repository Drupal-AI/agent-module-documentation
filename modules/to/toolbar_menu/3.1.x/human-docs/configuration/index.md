# Configuration

You configure Toolbar Menu by creating one "element" per menu you want to appear
in the toolbar. Each element is exportable configuration, so it deploys with the
rest of your site.

## Open the admin screen

1. Log in as a user with the **Administer toolbar menu** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Toolbar Menu**
   (`/admin/config/user-interface/toolbar-menu/elements`).
3. Click **Add** to create a new element.

## Add a menu to the toolbar, field by field

The add/edit form has these fields:

- **Label** — the element's name. By default this is what the toolbar tab shows.
- **ID** — the machine name, derived from the label.
- **Menu** — a select list of your enabled menus. Pick the menu whose links
  should appear in this tab's tray (for example your Main navigation, or a custom
  "Editor tools" menu built under Structure → Menus).
- **Display the menu label in toolbar instead of this entity label** — when
  ticked, the tab shows the *menu's* own label rather than the element label,
  saving you from maintaining a duplicate name. (This is the `rewrite_label`
  option.)

There is also a **weight** on each element that controls the order of the tabs
among the other toolbar items.

Save, then clear the cache (`drush cr`) if the tab doesn't appear immediately —
element saves rebuild the toolbar.

## Controlling who sees each tab (permissions)

Toolbar Menu defines one administration permission plus one generated permission
per element. Set them at **People → Permissions**
(`/admin/people/permissions`):

- **Administer toolbar menu** (`administer toolbar menu`) — gates the whole
  Toolbar Menu admin UI (adding, editing, deleting elements). Grant to trusted,
  site-builder roles.
- **View `<label>` element in the toolbar** (`view <id> in toolbar`) — generated
  automatically for every element you create. A tab is only rendered for a user
  who has *its* permission, so this is how you show a given menu tab only to
  certain roles.

For example, to reveal an element with the machine name `my_tab` to a role:

```bash
drush role:perm:add editor 'view my_tab in toolbar'
```

This per-element gating is what lets you build role-specific toolbars — a
developer-only debugging menu, a store-manager Commerce menu, and so on — from
the same site.

## Deploying elements

Because each toolbar tab is a `toolbar_menu_element` configuration entity, you
can export it with `drush config:export` and ship it across environments, or
include it in a config recipe to standardise editor navigation across several
sites. Enabling or disabling an element's config controls whether the tab appears
in a given environment.
