ShareThis adds social-sharing buttons (Facebook, X/Twitter, LinkedIn, email, Pinterest, etc.) to your Drupal content, either rendered directly on nodes or placed anywhere as a block, driven from the third-party ShareThis widget service.

---

A single settings form at `/admin/config/services/sharethis` (route
`sharethis.configuration_form`, permission `administer sharethis`) controls everything and
stores it in the `sharethis.settings` config object (defaults shipped in `config/install`). The
key `location` decides how buttons appear: `content` renders them as an extra display field on
enabled node types (via `hook_entity_extra_field_info()` + `hook_node_view()`), `links` renders
them per enabled view mode (`sharethisnodes.<bundle>.<view_mode>`), or you can ignore node
rendering and place the **Sharethis** block (`sharethis_block`) or **Sharethis Widget** block
(`sharethis_widget_block`, which shares a specific path/URL) wherever you want. `node_types`
selects which content types get buttons, and further keys choose the button family
(`button_option`), which services (`service_option`), the widget style (`widget_option`), and
behaviours like on-hover menus, URL shortening and Twitter handle/recommends. The
`sharethis.manager` service assembles the options (`getOptions()`) and renders the button spans
(`renderSpans()`), attaching the external ShareThis JS libraries. A Views field plugin
(`sharethis_node`) lets you add the buttons as a column in a view, and `hook_sharethis_render_alter()`
lets other modules rewrite the button attributes/options before output. Because the buttons rely
on ShareThis's hosted `sharethis.com` scripts, offline/local grading of this module is best done
against its configuration and rendered markup rather than live sharing behaviour.

---

- Add Facebook / X / LinkedIn / email share buttons to article and page nodes.
- Choose exactly which services appear in the share bar (`service_option`).
- Show share buttons only on specific content types via `node_types`.
- Render buttons inline in node content (`location: content`).
- Render buttons per view mode, e.g. only on the teaser (`location: links`).
- Place a Sharethis block in a sidebar or footer region instead of on the node.
- Place a Sharethis Widget block that shares a fixed/custom URL.
- Add a share-buttons column to a View with the `sharethis_node` Views field.
- Pick a button family / style (`button_option`, `widget_option`).
- Enable on-hover expanded sharing menus (`option_onhover`).
- Enable URL shortening for shared links (`option_shorten`).
- Set a Twitter handle appended to tweets (`twitter_handle`).
- Add a Twitter "recommends" account (`twitter_recommends`).
- Add a suffix/hashtags to tweets (`twitter_suffix`).
- Open shares in a new window / count from zero (`option_neworzero`).
- Control the vertical position/weight of the buttons on the node (`weight`).
- Add Pinterest sharing to content pages.
- Provide share buttons on a custom content type's full display only.
- Rewrite button attributes (e.g. `st_username`) with `hook_sharethis_render_alter()`.
- Override the Twitter handle at render time from another module.
- Keep sharing config in exported config for consistent deployment.
- Gate the sharing configuration behind the `administer sharethis` permission.
- Late-load the ShareThis script for performance (`late_load`).
- Offer social sharing on a marketing/blog site without hand-coding share links.
