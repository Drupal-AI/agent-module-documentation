# Configure title exclusion

Form: `\Drupal\exclude_node_title\Form\AdminSettingsForm` (id `exclude_node_title_admin_settings`).
Route `exclude_node_title.settings` at `/admin/config/content/exclude-node-title`
(under `system.admin_config_content`), gated by `administer exclude node title`.
All settings live in the config object **`exclude_node_title.settings`**.

## Form controls

| Control | Config key | Values / meaning |
|---|---|---|
| Remove node title from search pages | `search` | bool. Strips node titles from core Search results/index. Checkbox disabled unless the `search` module is enabled. |
| Type of rendering | `type` | `remove` (default) empties the title text, or `hidden` adds a `visually-hidden` class keeping the markup. |
| Exclude title by content type → per bundle | `content_types.<bundle>` | `none` (default), `all`, or `user`. |
| View modes (per bundle) | `content_type_modes.<bundle>` | array of enabled view mode machine names. |

For each node bundle the form renders a **select** (`content_type_value` → `content_types.<bundle>`)
and a **checkboxes** set (`content_type_modes` → `content_type_modes.<bundle>`). View-mode options are
all of `node`'s view modes plus a synthetic `nodeform` ("Node form") mode. The checkboxes are hidden
via `#states` when the mode select is `none`.

Exclude modes:
- **none** — never hide the title for this bundle.
- **all** — hide the title for every node of this bundle in the checked view modes.
- **user** — hide nothing by default, but add an "Exclude title from display" checkbox to the node
  edit form (see permissions); per-node choices are stored in State, not config.

## Config object shape (`config/install/exclude_node_title.settings.yml`)

```yaml
search: false
type: remove
translation_sync: true   # deprecated, unused
content_types:           # bundle => none|all|user
  article: all
content_type_modes:      # bundle => [view mode machine names]
  article: [full, teaser]
nid_list: []             # legacy; per-node list now stored in State
```

Schema: `config/schema/exclude_node_title.schema.yml` (`config_object`). Settings export/deploy with
`drush config:export`, e.g. `drush cset exclude_node_title.settings type hidden`. On save the form
clears all cache bins. When a content type is deleted the module clears its `content_types.*` and
`content_type_modes.*` keys automatically.

## Per-node exclude list (State, not config)

The `user` mode's per-node choices are kept in Drupal **State** under
`exclude_node_title_nid_list` (an array of node ids). The `exclude_node_title.manager` service
(interface `ExcludeNodeTitleManagerInterface`, autowired) manages it:
`isTitleExcluded($node, $view_mode)`, `isNodeExcluded($nid)`, `addNodeToList($node)`,
`removeNodeFromList($node)`, `getBundleExcludeMode($bundle)`, `getExcludedViewModes($bundle)`.

