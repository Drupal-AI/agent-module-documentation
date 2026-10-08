<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Field in Text if None injects the rendered image from an image field into a long-text field (e.g. the body) at display time, but only when the text does not already contain an image.
---
Via `hook_entity_view()`, the module inspects a configured entity type/bundle (currently hard-coded for `node`/`article` mapping `field_image` into `body` in the `full` view mode). It renders the processed body text, scans the first few paragraphs for an existing `<img>`, and if none is found computes a placement location (before/after/within the first N paragraphs based on text length and paragraph positions). It then renders the image field, applies an alignment class, and splices the image markup into the text at that location; it can also remove the original standalone image display.

The insertion operates on the entity's own field content and the text is emitted through Drupal's `processed_text` pipeline (so the field's text format still filters output). Configuration is currently a `@TODO` — the mapping is defined inline in the `.module` file rather than via a settings UI. There are no routes, permissions, or services. Depends on core `field`, `filter`, `image`, and `text`.
---
- Show the article image inline in the body when the body has no image.
- Avoid duplicate images when an editor already embedded one in the body.
- Place a fallback image before a long undifferentiated text blob.
- Insert the image after a short intro when there are few paragraphs.
- Position the image within the first few paragraphs of the body.
- Apply alignment classes (left/right/center) to the inserted image.
- Remove the standalone image field display once inlined.
- Improve article layout without editor intervention.
- Keep image placement consistent across articles.
- Render the image through the configured view mode.
- Respect the body field's text format on output.
- Handle bodies with no paragraph tags gracefully.
- Provide a default image position for imported content.
- Reduce manual image embedding work for editors.
- Fall back to before/after placement when paragraph detection fails.
- Detect existing `<img>` tags to skip insertion.
- Target a specific entity type/bundle/view mode.
- Use for magazine-style article displays.
- Combine an image field with rich body text automatically.
- Customize placement thresholds (paragraph count, short length) in code.
