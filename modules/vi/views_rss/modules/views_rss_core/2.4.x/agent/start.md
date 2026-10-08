<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: Core Elements — agent index

Registers the standard RSS 2.0 `<channel>`/`<item>` elements (title, link, description, guid,
pubDate, enclosure, category, ...) via the parent `views_rss` module's `hook_views_rss_*`
hooks. **Required**: the parent's row plugin (`views_rss_fields`) refuses to save unless this
module is enabled, because an item needs a title or description. No settings page of its own
— its elements appear inside the parent View's style/row option forms.

- **Which core elements exist, where they show up in a View's config, and their preprocessing
  quirks** → [configure/core-elements.md](configure/core-elements.md)

Key fact: its elements live under the `core` namespace and `views_rss_core` module key, e.g.
`style.options.channel.core.views_rss_core.description` (channel) and
`row.options.item.core.views_rss_core.title` (item) in `views.view.<name>` config. See the
parent's [hooks/element-hooks.md](../../../../2.4.x/agent/hooks/element-hooks.md)
for how the underlying `hook_views_rss_*` mechanism works.
