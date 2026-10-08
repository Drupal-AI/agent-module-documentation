<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hide & reorder node-form vertical tabs

Two independent features, two admin forms under
`/admin/config/user-interface/vertical_tabs_config`, both requiring core
`administer site configuration`. Effects apply only to **node add/edit forms**.

## The known vertical tabs (fixed list)

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

The Metatag tab is deliberately **excluded from reordering** (it forces itself to the top).

## 1. Order — config `vertical_tabs_config.order`

Route `vertical_tabs_config.order` (`.../vertical_tabs_config/order`). Each tab has an integer
weight stored under key `vertical_tabs_config_<tab>`. Shipped defaults:

```yaml
vertical_tabs_config_meta: 1
vertical_tabs_config_options: 2
vertical_tabs_config_menu: 3
vertical_tabs_config_revision_information: 4
vertical_tabs_config_path_settings: 5
vertical_tabs_config_author: 6
vertical_tabs_config_book: 7
vertical_tabs_config_ds_switch_view_mode: 8
```

Lower weight = higher on the form. Read/write:

```bash
drush cget vertical_tabs_config.order vertical_tabs_config_author
drush cset vertical_tabs_config.order vertical_tabs_config_author 1 -y   # move Authoring info to top
```

`hook_form_node_form_alter()` applies these as `$form[<tab>]['#weight']`. Clear cache if the UI
doesn't reflect a change.

## 2. Visibility — DB table `vertical_tabs_config` (NOT config)

Route `vertical_tabs_config.visibility` (the module's `configure` route). The form writes one row
per (content type × tab) into a **custom database table** `vertical_tabs_config`:

| Column | Meaning |
|---|---|
| `content_type` | node type machine name |
| `vertical_tab` | tab machine name from the list above |
| `hidden` | `1` = hide this tab on that type's form, else `0` |
| `roles` | JSON array of role ids the rule applies to; **empty `[]` = all roles** |

On save the form deletes all rows and re-inserts the full set. Hiding logic in
`vertical_tabs_config_form_node_form_alter()`: a tab is hidden when its row `hidden == 1` and
either `roles` is empty (all users) or the current user holds **all** of the listed roles.

Inspect / set directly:

```bash
# which tabs are hidden for the 'article' type
drush sqlq "SELECT vertical_tab, hidden, roles FROM vertical_tabs_config WHERE content_type='article' AND hidden=1;"

# hide the Authoring information tab on 'article' for all roles
drush sqlq "INSERT INTO vertical_tabs_config (vertical_tab, content_type, hidden, roles) VALUES ('author','article',1,'[]');"
```

Because visibility lives in a DB table (created by `hook_schema` in `.install`), it is **not**
captured by config export/import — reproduce it with an update hook or a deploy script.

## Notes

- The config object `vertical_tabs_config.visibility` is declared editable by the form but the
  actual visibility data goes to the DB table; the config object itself stays effectively empty.
- The module has no config schema; there is no `provides_config_schema`.
