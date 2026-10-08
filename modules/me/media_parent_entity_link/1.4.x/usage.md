<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media - Parent Entity Link adds a "Link to parent entity" checkbox to the image field formatters on media entities, so that when a media item is rendered as part of a referencing entity its image links to that parent entity's page instead of to the file or media page.

---

The module has no settings page of its own. It hooks into the *Manage display* form for **media** entities: `hook_field_formatter_third_party_settings_form()` adds a **"Link to parent entity"** checkbox, but only for a field of type `image` whose formatter is one of the supported ones (`InitialSettingsService::getFormatters()` defaults to `image` and `responsive_image`; other modules can extend the list via `hook_media_parent_entity_link_alter_formatters()`). Ticking it stores a third-party setting `media_parent_entity_link.link_to_parent` on that formatter component inside the media bundle's `entity_view_display`. At render time `hook_media_media_view()` checks the setting and, if the media has a parent, walks `$entity->_referringItem->getParent()->getParent()->getValue()` to the referencing (parent) entity, and sets each image item's `#url` to `$parent->toUrl()` — overriding the formatter's own link setting. It supports both normal field rendering and Layout Builder sections, and registers a `media_parent_entity` cache context (added per parent `bundle-id`) so the output varies correctly by parent. If the media has no parent, or the parent is new/has no URL, the setting has no effect.

---

- Make a referenced media image link to the node (or other entity) that embeds it, instead of to the media page.
- Turn thumbnail images in a card/teaser into links to the parent content.
- Link product gallery media to the product page when the media is shown in a listing.
- Override an image formatter's default "Linked to: Content/File/Nothing" with a link to the actual referencing entity.
- Provide clickable media images inside a Layout Builder section that point at the host entity.
- Apply the behavior on the `image` formatter of a media Image bundle's display.
- Apply the behavior on the `responsive_image` formatter for responsive media images.
- Configure it per view mode (e.g. link to parent in the teaser display but not the full display).
- Add support for a contrib formatter such as Blazy via `hook_media_parent_entity_link_alter_formatters()`.
- Keep media reusable while still linking each rendered instance to its current host.
- Ensure a gallery grid of media images each deep-links to its owning article.
- Make editorial image tiles navigate to the referencing page on click.
- Link hero/banner media to the landing page that references it.
- Present author avatar media that links to the referencing profile entity.
- Deploy the setting via exported `entity_view_display` config (`third_party_settings.media_parent_entity_link.link_to_parent`).
- Toggle the parent-link behavior on or off per environment through config overrides.
- Cache-correctly render the same media differently depending on which parent references it.
- Link media images embedded through an entity reference field back to the container entity.
- Give a media grid the same "click image → open item" UX users expect on referenced content.
- Avoid writing custom preprocess/Twig just to relink referenced media images.
- Use it on multiple media bundles that expose an image field with a supported formatter.
- Link media in a paragraph-based layout to the paragraph's host node (the ultimate parent).
- Provide consistent click-through behavior for media used across many content types.
