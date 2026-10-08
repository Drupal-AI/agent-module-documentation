<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach mechanism, theme hook, and template

How the per-node Like button reaches the page and how the widget markup is rendered. File:
`fblikebutton.module` + `templates/fblikebutton.html.twig`.

## 1. Extra display field registration

`fblikebutton_entity_extra_field_info()` reads `fblikebutton.settings:node_types` and, for each enabled
bundle, registers an extra `display` field on `node`:

```
$extra['node'][$bundle]['display']['fblikebutton'] = [
  'label' => t('Facebook Like Button'),
  'description' => t('Displays a Facebook Like button.'),
  'visible' => FALSE,
];
```

Because `visible => FALSE`, the component is registered but hidden by default — an admin must place it on the
content type's **Manage display** screen (per view mode) for it to render. Changing `node_types` requires the
`entity_field_info` cache tag to be cleared; the settings form and `hook_install()` both do this via
`Cache::invalidateTags(['entity_field_info'])`.

## 2. Render on node view

`fblikebutton_node_view(array &$build, EntityInterface $node, EntityViewDisplayInterface $display, $view_mode)`:

- `$show` is true only when the node's type is present in `node_types` **and** the current user has permission
  `access fblikebutton`.
- If `$show && $display->getComponent('fblikebutton')` (component actually placed in this view mode), it adds:

```
$build['fblikebutton'] = [
  '#theme' => 'fblikebutton',
  '#url' => fblikebutton_get_node_url($node->id()),
  '#cache' => ['tags' => ['config:fblikebutton.settings']],
];
```

`fblikebutton_get_node_url($node_id)` returns the node's **absolute canonical URL**
(`generateFromRoute('entity.node.canonical', ['node' => $node_id], ['absolute' => TRUE])`) — always
server-generated from the node id, never from request input.

## 3. Theme hook + default variables

`fblikebutton_theme()` registers theme hook `fblikebutton` with `template => 'fblikebutton'` and default
`variables` from `fblikebutton_conf()`, which reads `fblikebutton.settings` (layout, action, colorscheme,
size, language, width) and sets `url` to the current route's absolute URL as a fallback default. Per-node
view and the block override the relevant variables (`#url`, and the block also `#layout/#size/#action/…`).

## 4. Template `templates/fblikebutton.html.twig`

- Injects Facebook's JS SDK: a `<script>` that loads
  `//connect.facebook.net/{{ language }}/sdk.js#xfbml=1&version=v21.0` into a `#fb-root` container.
- Emits the widget:
  `<div class="fb-like" data-href="{{ url }}" data-width="{{ width }}" data-colorscheme="{{ colorscheme }}"
  data-layout="{{ layout }}" data-action="{{ action }}" data-size="{{ size }}" data-share="true"></div>`.

All values are printed with standard Twig `{{ }}` (auto-escaped); there is no `|raw`. Override by copying the
template into your theme, or by implementing `MYTHEME_preprocess_fblikebutton()`.

## Operate

1. Enable the target content types + appearance at the settings form
   ([../config/settings.md](../config/settings.md)).
2. Grant `access fblikebutton` to the roles that should see the button.
3. On each content type's **Manage display**, move *Facebook Like Button* out of *Disabled* for the view
   modes where it should appear (full page by default; enable on teaser too if wanted).
4. Note: Facebook must be able to fetch the target URL, so the button may not render on a non-public site.
