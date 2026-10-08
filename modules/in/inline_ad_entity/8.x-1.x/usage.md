<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a text-field formatter that injects an Advertising Entity ad display between paragraphs of formatted text.

The module extends the [Advertising Entity](https://www.drupal.org/project/ad_entity) module so publishers can place in-article ads without manually editing body copy. It registers the `inline_ad_entity` field formatter for `text`, `text_long`, and `text_with_summary` fields. The formatter parses the field HTML with the Masterminds HTML5 parser, splits it on `<p>` boundaries, groups paragraphs by a configurable "ad frequency" (default every 3 paragraphs), and renders a chosen `ad_display` entity between the groups (never after the very last chunk). Ad selection uses the `ad_display` entity storage and view builder from ad_entity.

To use it, install ad_entity and configure at least one ad display, then on the field's "Manage display" set the format to "Content with Inline Ads" and pick the ad frequency and ad display. There is no admin route of its own; all settings live in the field formatter (schema `field.formatter.settings.inline_ad_entity`: `ad_frequency` integer, `ad_display` string). The rendered ad markup comes from ad_entity, so ad safety/policy is governed there; this module only positions ads. No custom permissions or endpoints are added.
---
Field formatter that weaves ad_entity ads between paragraphs of a text field.
---
- Insert an in-article ad after every 3rd paragraph of a body field.
- Change ad frequency to insert ads more or less often.
- Choose which ad_entity display renders inline.
- Monetize long-form articles without editing the body HTML.
- Apply inline ads only in a specific view mode (e.g. full node).
- Keep teaser view modes ad-free by not enabling the formatter there.
- Use different ad displays per content type via display settings.
- Add ads to `text_with_summary`, `text_long`, or `text` fields.
- Avoid a trailing ad after the final paragraph automatically.
- Configure the formatter on the field "Manage display" page.
- Combine with ad_entity targeting/context for responsive ads.
- Provide house ads inline when no paid campaign is active.
- Roll out inline ads site-wide by enabling the formatter per field.
- A/B different frequencies by cloning a view mode.
- Preview inline ad placement by viewing a node.
- Disable inline ads by switching the field format back to default.
- Reference the formatter settings schema when exporting config.
- Set `ad_frequency` in exported field.formatter config in code.
- Ensure at least one `ad_display` exists before selecting it.
- Position sponsored content between article sections.