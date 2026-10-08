# Configuration

The module has two independent screens, both under **Configuration → User
interface → Vertical Tabs Config**
(`/admin/config/user-interface/vertical_tabs_config`), and both requiring the core
*Administer site configuration* permission. Everything here affects **node
add/edit forms only**.

## The tabs you can control

Vertical Tabs Config knows a fixed list of tabs:

| Machine name | Label |
|---|---|
| `meta` | Entity meta information |
| `options` | Promotion options |
| `menu` | Menu settings |
| `revision_information` | Revision information |
| `path_settings` | URL path settings |
| `author` | Authoring information |
| `book` | Book outline |
| `ds_switch_view_mode` | Display settings (Display Suite) |

The **Metatag** tab is intentionally not in this list — it forces itself to the
top and cannot be reordered.

## 1. Hide tabs — the Visibility screen

Open the **Visibility** form. For each content type you'll see a checkbox for each
tab, plus optional role checkboxes:

- **Tick a tab** to hide it on that content type's node form.
- **Leave the role checkboxes empty** to hide the tab for *all* users.
- **Select one or more roles** to hide the tab only for users who have **all** of
  the selected roles — for example, hide *Authoring information* from a "content
  editor" role while administrators still see it.

Click **Save**. The form rewrites its stored rules each time you save.

> **Important:** these visibility rules are stored in a custom database table, so
> they are **not** included in configuration export/import. If you deploy config
> between environments, reproduce the visibility settings with an update hook or a
> deploy script, or re-enter them on each environment.

## 2. Reorder tabs — the Order screen

Open the **Order** form. Each tab has an integer **weight** — a lower weight means
higher on the form. The shipped defaults run 1–8 in the order listed in the table
above (Entity meta information first, Display settings last). Change the weights to
reorder, for example set *Authoring information* to `1` to move it to the top, then
**Save**.

Tab order **is** stored in normal configuration (the `vertical_tabs_config.order`
config object), so it exports/imports with the rest of your config.

## If a change doesn't show

Both features run when the node form is built. If a change doesn't appear right
away, clear the cache (**`drush cr`**) and reload the node add/edit form.
