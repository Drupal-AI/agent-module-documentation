<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sharerich provides customisable, responsive social-sharing button sets (built on the RRSSB library) that you place as blocks.

---

Button sets are `sharerich` config entities: each stores a list of enabled services (facebook, twitter, email, tumblr, etc.) with per-service HTML `markup` containing `[sharerich:*]` tokens (url, title, summary, twitter_user, fb_app_id...). The Sharerich block loads a chosen set, renders each service's markup with `#allowed_tags` from the admin-configured `allowed_html`, lets modules alter it via `hook_sharerich_buttons_alter()`, then runs `\Drupal::token()->replace()` using node/term/user context from the current route. Default services ship as `.inc` files scanned from the module's `services/` directory. Global settings (Facebook App ID, social usernames, allowed HTML) live at `/admin/config/sharerich/settings`; sets are managed at `/admin/structure/sharerich`. Both routes require the restricted `administer sharerich` permission.

Button markup is admin-authored config, so its raw-HTML rendering is gated by the restricted admin permission. Typical setup: create a set, enable/order services, place the block, and set the site's tokens/usernames.

---

- Create a named button set at `/admin/structure/sharerich`.
- Enable/disable individual services (facebook, twitter, email, tumblr...) in a set.
- Reorder buttons via each service's `weight`.
- Edit a service's HTML markup and its SVG icon.
- Use `[sharerich:url]` / `[sharerich:title]` / `[sharerich:summary]` tokens in markup.
- Set the Facebook App ID and Site URL for the FB dialog share widget.
- Configure the Twitter `via` user and other social usernames in global settings.
- Restrict permitted HTML tags in button markup via `allowed_html`.
- Place a Sharerich block and select which set it renders.
- Choose horizontal or vertical button orientation.
- Make a vertical bar sticky so it floats while scrolling.
- Show contextual share buttons that reflect the current node/term/user.
- Add a new service by dropping an `.inc` file in the module's `services/` dir.
- Alter the rendered buttons programmatically with `hook_sharerich_buttons_alter()`.
- Grant only trusted admins the restricted `administer sharerich` permission.
- Duplicate a set to build variant button bars for different content types.
