# Configure — global settings, block, routes, permission

## Global settings form

- Route `tagclouds.admin_page` at `/admin/config/content/tagclouds`
  (form `TagcloudsAdminPage extends ConfigFormBase`, form id `tagclouds_settings`).
- Requires permission **`administer tagclouds settings`** (the only permission the module defines).
- Config object: **`tagclouds.settings`** (`getEditableConfigNames()`).

### Keys (config `tagclouds.settings`, defaults from config/install)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `sort_order` | string | `title,asc` | `title,asc` \| `title,desc` \| `count,asc` \| `count,desc` \| `random,none` |
| `display_type` | string | `style` | `style` (sized tags) or `count` (show usage count) |
| `display_node_link` | bool | `false` | Link a term straight to its node when only one item uses it |
| `display_more_link` | bool | `true` | Show a "more tags" link when tags are truncated |
| `page_amount` | string | `'60'` | Tags per page (`'0'` = all) |
| `levels` | int | `6` | Number of size levels (→ CSS classes `level1`…`levelN`) |
| `language_separation` | int | `0` | Separate tags per language (only shown when site is multilingual) |
| `language_separation_radios` | int | `0` | Companion radio setting for language separation |

### Set via Drush

```bash
drush cset tagclouds.settings levels 12 -y
drush cset tagclouds.settings sort_order 'count,desc' -y
drush cset tagclouds.settings display_type count -y
```

Or in code: `\Drupal::configFactory()->getEditable('tagclouds.settings')->set('levels', 12)->save();`

## The block

`tagclouds_block` (`TagcloudsTermsBlock`) is **derived per vocabulary** (deriver
`Plugin/Derivative/TagcloudsTermsBlock`, admin label "Tags in {vocab}"). Per-block settings:

- `tags` — number of tags to show (`0` = all).
- `vocabulary` — the vocabulary **machine name** (default `tags`).
- `sort_order` — `default` (use global) or any of the global sort options.

The block renders nothing if the vocabulary machine name doesn't resolve to a vocabulary.

## Dynamic routes

| Route | Path | Permission |
|---|---|---|
| `tagclouds.admin_page` | `/admin/config/content/tagclouds` | `administer tagclouds settings` |
| `tagclouds.page_chunk` | `/tagclouds` | `access content` |
| `tagclouds.list_vocabularies` | `/tagclouds/list/{tagclouds_vocabularies_str}` | `access content` |
| `tagclouds.chunk_vocabularies` | `/tagclouds/chunk/{tagclouds_vocabularies_str}` | `access content` |

`{tagclouds_vocabularies_str}` is a vocabulary machine name (multiple may be combined; see
`CsvToArrayTrait`). `list` shows term lists with descriptions; `chunk` shows the cloud.
