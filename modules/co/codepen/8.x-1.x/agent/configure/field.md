<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding a Codepen field

1. Enable the module (`drush en codepen`).
2. Optionally set site-wide defaults at `/admin/config/media/codepen` (requires `administer codepen`).
3. On a bundle, add a field of type **Codepen Embed** (`codepen`).
4. On *Manage form display*, use the **Codepen** widget — editors paste a CodePen URL; the pen id and user id are derived from it, and default tabs (HTML/CSS/JS/result) can be selected.
5. On *Manage display*, choose a formatter:
   - **Codepen embed** (`codepen_embed`) — renders the live embed. Settings: `codepen_size` (preset sizes or `responsive`) and `codepen_height` (used when size is `custom`). Attaches `codepen/drupal.codepen.css` and, for responsive, `codepen/drupal.codepen.responsive`.
   - **Codepen URL** (`codepen_url`) — renders a plain link to the pen.

## Notes
- The field is multi-value capable; each delta renders its own embed.
- Embeds rely on CodePen's external embed script loaded in the browser.
- A Feeds target is available to map imported values onto the field.
