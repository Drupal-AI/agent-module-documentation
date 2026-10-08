<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, tokens & the popup library

## Templates
One Twig template per plugin in `templates/` (`social-share-link-<network>.html.twig`), registered by
`social_share_theme()` which iterates the plugin manager and merges each plugin's `getTemplateInfo()`.
Every context defined by a plugin is exposed as a template variable of the same name, plus
`attributes` (a `Drupal\Core\Template\Attribute`) and `render_context`.

Each template builds a `url_params` map from the context values, encodes it, and outputs a single
`<a href="…">` link:
- Facebook → `https://www.facebook.com/dialog/feed?{{ url_params|url_encode }}`
- Twitter/X → `https://twitter.com/intent/tweet/?{{ url_params|url_encode }}`
- LinkedIn → `https://www.linkedin.com/shareArticle?…` (resolves `<current>` via
  `url('<current>')|render|striptags` before encoding)
- Pinterest → `https://www.pinterest.com/pin/create/button/?…`
- WhatsApp → `whatsapp://send?text=<message> <url>` (url-encoded together)
- Mail → `mailto:?subject=…&body=…`
- Print / PDF → the shared `url` with `print_url_query_parameter` / `pdf_url_query_parameter`
  appended (`?` or `%26` depending on whether the URL already has a query string)

Popup-based providers (facebook, twitter, linkedin, pinterest) call
`{{ attach_library('social_share/popup') }}`, add class `js-social-share-popup`, set `target=_blank`
and `data-popup-width`/`data-popup-height` attributes; mail/print/pdf/whatsapp do not attach the
library. Each link also gets a per-network class (e.g. `social-share-facebook`) for styling.

### Template suggestions
`build()` appends a `$template_suffix` to the theme hook so themes can target context:
- Formatter: `__<entity_type>__<field_name>__<view_mode>`
- Block: `__block__<machine-name-suggestion>`
Override by copying the base template to your theme and adding the suffix to the filename.

## Token replacement (Typed Data)
Context values are not plain strings at render time: `SocialShareLinkConfigurationTrait::prepareLinkBuild()`
runs each scalar value through the Typed Data placeholder resolver against the host entity, so config
can contain placeholders like:
- `{{ node.title.value }}`
- `{{ media.field_description.processed|striptags }}`
- `{{ node.field_teaser_media.entity.field_image.entity|entity_url }}`
The entity is keyed by its entity-type id (e.g. `node`, `media`). `['clear' => TRUE]` empties
unresolved placeholders. Resolver metadata bubbles into the render array.

## The `<current>` URL
Contexts `url` and `twitter_url` support the literal value `<current>`. The preprocess function
`social_share_preprocess_template_urls()` (registered by most plugins' `getTemplateInfo()`) replaces
`<current>` with `\Drupal::request()->getUri()` (the full current absolute URL incl. GET params) and
adds the `url.path` cache context. LinkedIn resolves `<current>` inside its own template instead.

## Popup library (`social_share/popup`, `js/popup.js`)
`Drupal.behaviors.socialSharePopup` binds click on `.js-social-share-popup`, prevents default and
opens `anchor.href` via `window.open` in a centered popup sized from the `data-popup-width` /
`data-popup-height` attributes (defaults 500×300). Dependency: `core/drupal`. No external/third-party
scripts are loaded (privacy-friendly).
