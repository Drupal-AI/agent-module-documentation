Mobile Native Share adds a configurable "Share" button to entity displays that invokes the device's native share sheet through the browser Web Share API, with clipboard/prompt fallbacks.

---

The module renders a single `<button class="mn-share-button">` carrying `data-url`, `data-title`, and `data-description` attributes. Its JavaScript behavior (`js/share-button.js`) calls `navigator.share()` when the browser supports the Web Share API; otherwise it copies the URL with `navigator.clipboard.writeText()` or falls back to a `prompt()` dialog. The button appears as an extra display component on content entity bundles you enable at `/admin/config/search/mobile-native-share`, and the per-bundle share Title and Description accept tokens. The button URL is the entity's canonical absolute URL (or the current request URI when no entity is available). A rendering service, `mobile_native_share.renderer`, lets developers emit the button programmatically for blocks, controllers, or custom routes, and the default entity-type list (`comment`, `node`, `taxonomy_term`) can be extended via `hook_mobile_native_share_entity_types_alter()`. Display mode (icon+text / icon only / text only), button style (default / fixed corner), and a custom icon URL are configured globally. Theme suggestions per entity type and bundle allow template overrides of `templates/mobile-native-share.html.twig`.

---

- Add a native "Share" button to article nodes so mobile visitors can share via the OS share sheet.
- Enable sharing on taxonomy term pages to promote category/landing pages.
- Add a share button to individual comments in a discussion thread.
- Extend sharing to Paragraphs by adding `paragraph` in `hook_mobile_native_share_entity_types_alter()`.
- Extend sharing to any custom content entity type via the same alter hook.
- Show an icon-only round share button on card layouts (Display mode: Icon only).
- Show a text-only "Share" link where an icon would clash with the design (Display mode: Text only).
- Pin a fixed share button to the bottom-right corner of every page (Button style: Fixed).
- Use a brand-specific share glyph by supplying a Custom icon URL (PNG/JPG/GIF/SVG).
- Set a per-bundle share Title such as `[node:title] | [site:name]` using tokens.
- Set a per-bundle share Description from a summary field via tokens, e.g. `[node:summary]`.
- Render the share button inside a custom block by calling `mobile_native_share.renderer->render($entity)`.
- Render a page-context share button (current title + URL) in a controller with `->render()` and no entity.
- Provide graceful degradation: desktop browsers without Web Share silently copy the link to the clipboard.
- Give an accessible share control: icon-only mode adds an `aria-label="Share"`.
- Override the button markup for one entity type via the `mobile_native_share__node` theme suggestion.
- Override the button markup for a single bundle via the `mobile_native_share__node__article` suggestion.
- Position the share component precisely on Manage display by dragging the "Native share button" row.
- Keep sharing consistent across mobile and legacy desktop without third-party social-network scripts.
- Avoid loading external social-widget JavaScript/trackers by relying on the browser's own share UI.
- Localize the button label and fallback messages through Drupal's translation system.
- Restrict who can change share configuration with the "Administer Mobile Native Share" permission.
