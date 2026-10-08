<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EZ Likes — configuration

Settings form: `/admin/config/content/ez-likes` (permission `administer ez likes`). Config object `ez_likes.settings`:

- `enabled_content_types` — array of node bundles that show the button (empty = all, unless overridden by include list).
- `included_pages` — newline path patterns that force the button (bypasses the content-type check).
- `excluded_pages` — newline path patterns that always suppress the button (wins over everything).
- `button_color` — hex colour, default `#006bb6`.

The button is added in `ez_likes_node_view()` only for `view_mode === 'full'`. Toggling calls `POST /ez-likes/toggle/{nid}?token=<csrf>` where the token is `\Drupal::csrfToken()->get('ez-likes-' . $nid)`; an invalid token returns 403, an unpublished/missing node returns 404. Response JSON: `{liked: bool, count: int}`.

Report permission `access ez likes report` (restricted) gates `/admin/reports/ez-likes`, the CSV `/export`, and the `/likers/{nid}` drill-down.
