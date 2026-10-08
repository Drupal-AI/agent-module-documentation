<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# social_media — block / render API

The share links are produced entirely by the block plugin
`Drupal\social_media\Plugin\Block\SocialSharingBlock` (id `social_sharing_block`).
There is no service or public function API — to render links, place the block (or the
`social_media` field); to customize the output, use the events in
[../hooks/events.md](../hooks/events.md).

## What `build()` does (pipeline)

1. Loads `social_media.settings:social_media` (the per-network config array).
2. Dispatches `social_media.pre_execute` (a `SocialMediaEvent` carrying the config
   array) — subscribers may mutate the array.
3. Sorts networks by `weight` ascending.
4. For each network with `enable == 1` and non-empty `api_url`:
   - runs `\Drupal::token()->replace($api_url)` (so `[current-page:*]` resolves),
   - wraps the result in a `Drupal\Core\Template\Attribute` under the network's
     `api_event` key (`href` or `onclick`),
   - parses `attributes` (pipe pairs) into per-attribute `Attribute` objects,
   - parses `drupalSettings` (pipe pairs) into `drupalSettings.social_media`,
   - resolves the icon: bundled `icons/<network>.svg` when `default_img`, else `img`,
   - for `email` with `enable_forward`, rewrites `mailto:` → `/social-media-forward`.
5. Dispatches `social_media.pre_render` (elements array) — subscribers may mutate it.
6. Returns a render array `#theme => 'social_media_links'` with `#elements` and the
   attached `library` / `drupalSettings`.

## Theme + template

`hook_theme()` registers `social_media_links` with one variable, `elements`. Template:
`templates/social-media-links.html.twig`. Override it in a theme to change markup.
The base CSS library is `social_media/basic`; per-network libraries (e.g.
`social_media/facebook`) are attached when a network sets `library`.

## Cache metadata

`getCacheContexts()` adds `url.path`; `getCacheTags()` adds
`social_media:<current-path>` and `config:social_media.settings`. So output varies per
page and is invalidated when the settings change.

## Mail

`social_media_mail()` implements `hook_mail()` for key `forward_email` (used by the
Email item's forward form, `Drupal\social_media\Form\ForwardEmailForm` at
`/social-media-forward`).
