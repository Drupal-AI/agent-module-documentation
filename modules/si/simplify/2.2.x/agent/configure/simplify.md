# Configure Simplify

## Settings form

- **Route:** `simplify.admin` → `/admin/config/user-interface/simplify` (confirmed against
  `simplify.routing.yml`; `configure` in `simplify.info.yml` = `simplify.admin`).
- **Permission:** `administer simplify`.
- **Config object:** `simplify.global` (schema `simplify.global`, a `config_object`).

The form is a set of checkboxes grouped by entity type. Each group's checked keys are saved as
an array to the matching `simplify_<type>_global` key. A section only appears if the relevant
module is enabled (e.g. Users needs `user`, Comments needs `comment`, ECK needs `eck`).

## `simplify.global` keys

| Key | Type | Hidden from |
|---|---|---|
| `simplify_admin` | boolean | If `true`, also hide fields from User 1 / admin-role users |
| `simplify_nodes_global` | array of strings | all node add/edit forms |
| `simplify_users_global` | array of strings | user account **and** registration forms |
| `simplify_comments_global` | array of strings | all comment forms |
| `simplify_taxonomies_global` | array of strings | all taxonomy term forms |
| `simplify_blocks_global` | array of strings | custom block add/edit **and** block-place forms |
| `simplify_media_global` | array of strings | all media add/edit forms |
| `simplify_menu_links_global` | array of strings | menu-link content forms |
| `simplify_profiles_global` | array of strings | profile forms |
| `simplify_eck_global` | array of strings | ECK entity forms |

Defaults (from `config/install/simplify.global.yml`): `simplify_admin: false` and every
`*_global` key an empty array.

## Element keys you can put in each array

These come from `simplify_get_fields()`. Core keys are always available; the rest appear only
when their module is enabled.

- **nodes:** `author` (Authoring information), `format` (Text format selection), `options`
  (Promotion options), `revision_information`, `meta` (Status metadata); plus `book`, `comment`,
  `menu`, `path` (URL path settings), `content_translation`, and third-party `domain`,
  `metatags`, `node_noindex`, `url_redirects`, `simple_sitemap`, `xmlsitemap`, `print`.
- **users:** `format`, `status` (Status blocked/active), `timezone` (Locale settings); plus
  `contact`, `overlay_control`, `content_translation`, `comment`, `domain`, `metatags`,
  `url_redirects`, `xmlsitemap`.
- **comments:** `format`.
- **taxonomy** (key `simplify_taxonomies_global`): `format`, `relations`,
  `revision_information`; plus `path` (URL alias), `content_translation`, `comment`,
  `metatags`, `url_redirects`, `xmlsitemap`.
- **menu_links:** `menu_parent` (Parent link), `menu_link_description` (Description),
  `menu_link_display_settings` (Display settings).
- **blocks:** `format`, `revision_information`.
- **media:** `name`, `format`, `revision_information`, `author`; plus `path` (URL alias).
- **eck / profiles:** `format`.

Note: `path` is hidden via `#access = FALSE` (removed from render); most other keys are hidden
by adding the `visually-hidden` CSS class (still in the DOM and submitted).

## Per-bundle overrides (no global setting needed)

Beyond the global form, each bundle's own edit form gains a "Simplify" section (visible to users
with `administer simplify`). Checking boxes there saves to a separate config object:

| Bundle form | Config object | Key |
|---|---|---|
| Content type edit | `simplify.content_type.<type>` | `simplify_nodes` |
| Comment type edit | `simplify.comment_type.<type>` | `simplify_comments` |
| Vocabulary edit | `simplify.vocabulary.<vid>` | `simplify_taxonomies` |
| Block type edit | `simplify.block_type.<type>` | `simplify_blocks` |

At form-alter time the effective hidden set is `global ∪ per-bundle`. Globally-hidden elements
show as checked-and-disabled on the bundle form.

## Set it with drush (config API)

```bash
# Hide Authoring info + Promotion options + Revision info on ALL node forms:
drush php:eval '\Drupal::configFactory()->getEditable("simplify.global")
  ->set("simplify_nodes_global", ["author","options","revision_information"])->save();'

# Read current global settings:
drush config:get simplify.global

# Per-content-type override (hide URL path settings only on "article"):
drush php:eval '\Drupal::configFactory()->getEditable("simplify.content_type.article")
  ->set("simplify_nodes", ["path"])->save();'
```

Changes take effect immediately (rebuild caches with `drush cr` if a form is already rendered).
