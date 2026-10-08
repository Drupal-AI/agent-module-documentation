<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Share (social_share) — agent index

Contextually configurable social-share buttons. Ships a `social_share_link` plugin type plus a
field type, a field formatter and a block. Share parameters accept Typed Data placeholder tokens
resolved against the surrounding entity; the literal `<current>` resolves to the current page URL.
Each provider renders through an overridable Twig template and share URLs are plain query strings —
no external network SDK JavaScript is loaded. Version 8.x-2.0-beta9 (`core_version_requirement:
^8 || ^9 || ^10 || ^11`).

- **Requires:** `typed_data` (Typed Data) — provides the placeholder resolver.
- **Provides no** custom routes, permissions, config entities, drush commands, or config schema.

## Provided plugins / plugin type
Plugin type `social_share_link` (manager `social_share.link_manager`,
`Drupal\social_share\SocialShareLinkManager`, annotation
`Drupal\social_share\Annotation\SocialShareLink`, interface `SocialShareLinkInterface`). Default
plugins in `src/Plugin/SocialShareLink/`:
`social_share_facebook`, `social_share_twitter`, `social_share_linkedin`, `social_share_pinterest`,
`social_share_whatsapp`, `social_share_mail`, `link_print`, `link_pdf`.

## Field / formatter / block
- Field type `social_share_link` (`SocialShareLinkItem`) — single varchar(255) `value` = a plugin ID;
  `options_buttons` widget, implements `OptionsProviderInterface`.
- Formatter `social_share_link` (`SocialShareLinkFormatter`) — renders selected providers with
  configured context values.
- Block `social_share_links` (`SocialShareBlock`) — optional `entity:node` context, "Allowed plugins"
  restrict/order list.

## Services / hooks
- `social_share.link_manager` (see above).
- `social_share_theme()` registers one theme hook per plugin.
- `social_share_field_widget_info_alter()` allows `options_buttons` on the field type.
- `social_share_preprocess_template_urls()` replaces `<current>` in `url`/`twitter_url` with the
  current request URI (adds `url.path` cache context).
- Library `social_share/popup` (`js/popup.js`) opens `.js-social-share-popup` links in a popup.

## Solution docs
- [Plugin type & default share links](plugins/share-links.md)
- [Field, formatter & block operation](fields/field-formatter-block.md)
- [Templates, tokens & the popup library](theming/templates-and-tokens.md)
