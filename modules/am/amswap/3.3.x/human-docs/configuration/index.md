# Configuration

Admin Menu Swap is configured entirely through **role‑menu pairs** on its settings
form.

## Open the settings form

1. Log in as a user with the **Administer amswap** permission.
2. Go to **Admin Menu Swap** at `/admin/config/amswap`.

## Prepare a menu first

Admin Menu Swap only changes *which* menu is shown as the administration tray — it
does not create menu links. So first build the menu you want a role to see, at
**Structure → Menus** (`/admin/structure/menus`), adding the links that role
should have. You can also point a pair at an existing menu (such as `admin` or
`main`).

## Build a role-menu pair

Each pair answers "for this role, show this menu":

1. In **Role‑Menu Pair 1**, choose the **Menu to display** — the menu whose tree
   should replace the administration ("Manage") tray.
2. Choose the **role** the pair applies to. When a user with that role opens the
   toolbar, they see the chosen menu instead of the default admin menu.
3. *(Optional)* Under **and when these roles are not assigned**, tick any
   **ignored roles**. If the user *also* has one of these roles, this pair is
   skipped — for example, tick *Administrator* so admins keep the full menu even
   though they also hold the Editor role.
4. Use **Add another role‑menu pair** to map more roles (several roles can point at
   the same simplified menu), and **Remove** to delete a pair.
5. Click **Save configuration**.

Validation rejects duplicate role+menu pairs, and a pair missing either a role or a
menu is dropped with a warning.

## How the swap behaves

- **Multiple matching pairs** — if more than one pair matches the current user's
  roles, each matching menu tree is merged.
- **No matching pair** — the user sees the normal default administration menu.
- **Removing a pair** — instantly restores the default admin menu for that role.
- **Caching** — the administration tray is cache‑tagged to this module's config, so
  saving the form invalidates it. If you are testing changes by hand and don't see
  them, run `drush cr`.

## Reading and deploying the config

All pairs live in one config object, `amswap.amswapconfig`, which you can export
for deployment across environments. Inspect it with:

```bash
drush cget amswap.amswapconfig role_menu_pairs
```

To restore the default (no swaps) everywhere, remove all pairs and save (this sets
`role_menu_pairs` to empty).
