<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# yasm_blocks — block plugins

Enable with `drush en yasm_blocks` (pulls in `yasm` + core `block`). Place the blocks at
`/admin/structure/block`; they appear under the **YASM** category.

## Shared base — `Plugin\Block\YasmBlock` (abstract)

Injects `yasm.builder`. Provides:

- **`blockForm()` / `blockSubmit()`** — three settings stored in block config:
  - `block_style`: `item_list` (default) | `cards` | `counters`.
  - `with_icons` (bool, default TRUE) — prefix rows with FontAwesome icons.
  - `attach_fontawesome` (bool, default FALSE) — load FontAwesome from CDN (only shown when
    `with_icons` is on); use when the theme does not already bundle FontAwesome.
- **`buildBlockItem($label, int $count, $picto, $list)`** — one `yasm_card` or `yasm_item` render
  element.
- **`renderCards($cards, $with_icons, $cache_tags, $cache_contexts, $block_css_class)`** — wraps the
  cards: for `cards`/`counters` styles uses `buildBlockColumns()` (`yasm_columns` theme + `yasm/global`
  library; counters also attach class `yasm-counters` and library `yasm_blocks/counters`); otherwise
  a core `item_list`. Sets a 24h (`86400`) max-age and the given cache tags/contexts, and attaches
  `yasm/fontawesome` when icons + `attach_fontawesome` are on.

Labels are `$this->t()` literals and counts are ints, so nothing user-supplied enters the markup.

## `yasm_block_site` — `SiteBlock`

Injects `module_handler` + `yasm.entities_statistics`. `getSiteCards()` counts published
(`status = 1`) nodes, comments, users, and files, plus groups (unconditioned) when each module is
enabled. Cache tags `node_list, user_list, file_list, media_list`; context `languages`. CSS class
`yasm-block-site`.

## `yasm_block_user` — `UserBlock`

Injects `current_user` + `module_handler` + `yasm.entities_statistics`. `getUserCards()` counts the
**current user's** published nodes, comments and files (`['uid' => currentUser->id(), 'status' => 1]`).
Cache tags `node_list, file_list, comment_list`; contexts `languages, user` (so each viewer sees their
own numbers). CSS class `yasm-block-user`.

## `yasm_block_group` — `GroupBlock`

Injects `current_route_match`, `current_user`, `entity_type.manager`, `module_handler`, `yasm.builder`,
`yasm.groups_statistics`. Returns empty when Group is not installed.

- **Group source**: the block form adds a required multiselect `groups` whose options are
  `- Group from route -` (sentinel `GROUP_FROM_ROUTE = '_route_'`) plus the groups the current user
  belongs to (`GroupVersionHelper::getUserGroups`). When the sentinel is selected, `build()` resolves
  the `group` parameter from the current route (`getGroupFromRoute()`); otherwise it loads the selected
  group entities.
- **Cards**: `getGroupCards()` sums `countContents`, `countMembers`, and (module-gated) `countComments`,
  `countFiles`, `countWebformSubmissions` across the resolved groups via `sumForGroups()`.
- Cache tags `group_list, node_list, comment_list, file_list`; context adds `route.group` when using
  the route group. CSS class `yasm-block-group`.

## Notes

- Blocks inherit Drupal's default block access (visible where placed) — the site and group blocks
  surface aggregate counts, so use block visibility rules to scope them to the intended audience.
- Counts come straight from the parent's services; there is no query logic (and no SQL) in this
  submodule.
