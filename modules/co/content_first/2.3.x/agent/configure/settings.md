# Configure Content First

Settings form: `admin/config/content/content-first` (route `content_first.config`, form
`ContentFirstConfigForm`, permission `administer content_first`). Config object
**`content_first.settings`** (schema `content_first.settings`).

## Settings keys (defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `entities.node.enabled` | `true` | Whether nodes get the Content First tab. |
| `entities.node.bundles` | `[]` | Allowed node bundles (`[]` = all). Enforced by `ContentFirstEntityAccessCheck`. |
| `entities.menu.enabled` | `true` | Whether menus get the Content First tab. |
| `entities.menu.bundles` | `[]` | Allowed menus (`[]` = all). |
| `allowed_metatags` | `[title, description, abstract]` | Which metatags become front matter (needs Metatag module). |
| `markdown_attributes` | `true` | Prepend YAML front matter to Markdown output. |
| `ignored_selectors` | `[nav.pager, ul.contextual-links]` | CSS selectors removed from rendered HTML before conversion (`symfony/css-selector`). |
| `entity_properties` | `[id, type, bundle, status, langcode, created, changed]` | Entity properties included in front matter. |
| `entity_extra_fields` | `[]` | Extra field machine names included in front matter. |
| `include_menu_link` | `false` | Include menu-link data in front matter. |

## Behaviour notes

- **Access:** the node tab requires `view content_first content` + core `node.view` access + the
  entity/bundle being enabled here. Disabling `entities.node.enabled`, or listing bundles that
  exclude a node's type, returns 403 for that node (cache tag `config:content_first.settings`).
- **Front matter** is built from `entity_properties`, `entity_extra_fields`, and — when Metatag is
  installed — `allowed_metatags` (resolved by `content_first.metatag_resolver`). Toggled off
  entirely by `markdown_attributes = false`.
- **`ignored_selectors`** is a newline list of CSS selectors; matching elements are stripped from
  the rendered HTML before Markdown/clean conversion (`HtmlSelectorRemover`).

## Set config with Drush

```bash
ddev drush cset content_first.settings markdown_attributes 1 -y
ddev drush cset content_first.settings 'entities.node.bundles.0' article -y
```
