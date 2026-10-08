<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings — categories

## Config object

```yaml
# type_tray.settings
categories:                 # sequence of machine_name: Label, order matters
  tt_editorial: Editorial
  tt_marketing: Marketing
fallback_label: Uncategorized   # label of the '_none' group (config/install default)
text_format: plain_text         # filter format used for extended descriptions
```

`config/install/type_tray.settings.yml` only ships `fallback_label: Uncategorized`, so on a
fresh install **`categories` does not exist yet** — the settings form requires you to enter
at least one.

Schema (`config/schema/type_tray.schema.yml`) declares `type_tray.settings` as a
`config_object` with `categories` (sequence of strings), `fallback_label` and `text_format`.

## Settings form

| | |
|---|---|
| Route | `type_tray.settings.form` (the module's `configure` route) |
| Path | `/admin/config/content/type-tray/settings` |
| Menu | *Configuration → Content authoring → Type Tray Settings* |
| Permission | `administer type tray` (`restrict access: TRUE`) |
| Class | `Drupal\type_tray\Form\TypeTraySettingsForm` |

Fields:

- **Categories** (required textarea) — one `key|label` per line. A line with no `|` is
  treated as a label and the key is derived with `Html::cleanCssIdentifier()`.
  Parsing/serialising live in the public statics
  `TypeTraySettingsForm::extractCategoriesFromString()` /
  `::buildStringFromCategories()`.
- **Fallback category** (required textfield) — label for uncategorised types, run through
  `Xss::filter()`.
- **Extended description format** (required select) — any enabled filter format.

**Validation:** removing a category that is still referenced by a content type's
`type_category` fails with *"The following categories are in use and cannot be removed:
%categories."* Reassign the types first.

On save the form invalidates the `config:node_type_list` cache tag.

## Set it from the command line

```bash
drush cget type_tray.settings
drush php:eval '
  \Drupal::configFactory()->getEditable("type_tray.settings")
    ->set("categories", ["tt_editorial" => "Editorial", "tt_marketing" => "Marketing"])
    ->set("fallback_label", "Other content")
    ->set("text_format", "basic_html")
    ->save();'
```

`drush cset` can set the scalars directly:

```bash
drush cset type_tray.settings fallback_label 'Other content' -y
drush cset type_tray.settings categories.tt_editorial 'Editorial' -y
```

## Group ordering

Groups render in **exactly the order the categories appear in config**, with `_none`
(uncategorised) always forced last and a synthetic `type_tray__favorites` group first when
the current user has favourites. Reorder the lines on the form to reorder the page.

## Permission

```bash
drush role:perm:add site_admin 'administer type tray'
```

Only the settings form is gated; the tray page itself is core's `node.add_page` and keeps
core's access rules (per-type `create` access).
