<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sharerich provides configurable, responsive social-sharing button sets (using the RRSSB class names) that you place on your site as blocks. It ships no third-party JavaScript library and no jQuery — buttons lay out with flexbox and wrap onto another row when they run out of space.

---

Button sets are `sharerich` config entities: each stores a list of enabled services (email, facebook, tumblr, twitter/X, and more) with per-service HTML `markup` containing `[sharerich:*]` tokens (url, title, summary, description, plus settings-backed tokens such as `twitter_user` and `fb_app_id`). The **Sharerich** block loads a chosen set, builds each service's markup as a `#markup` element filtered against the admin-configured `allowed_html` tag list, lets modules adjust it via `hook_sharerich_buttons_alter()`, then runs `\Drupal::token()->replace()` using the node, term or user of the current route. Page tokens are URL-encoded, and settings-backed tokens are HTML-escaped. Fifteen services ship as `.inc` files in the module's `services/` directory (email, facebook, github, hackernews, instagram, linkedin, pinterest, pocket, print, reddit, tumblr, twitter, vk, whatsapp, youtube); only email, facebook, tumblr and twitter are enabled by default. Global settings (Facebook App ID, social usernames, allowed HTML) live at `/admin/config/sharerich/settings`; sets are managed at `/admin/structure/sharerich`. Every admin route requires the restricted `administer sharerich` permission, so only trusted administrators edit button markup.

The `print` and `whatsapp` buttons rely on the `javascript:` and `whatsapp:` protocols, which Drupal's filters strip; the module puts those protocols back on the client in `js/sharerich.js`, per-link, so the two buttons work without changing the site's protocol filtering. Those two buttons therefore need JavaScript — with it disabled the rest still work. Installing the module places one Sharerich block in the content region of the default theme, showing the default set. Typical setup: create a set, enable and order services, place the block, and fill in the site's tokens/usernames.

---

- Create a named button set at `/admin/structure/sharerich`.
- Enable or disable individual services (email, facebook, tumblr, twitter/X...) in a set.
- Reorder buttons by each service's `weight` (drag-and-drop in the set form).
- Edit a service's HTML markup and its inline SVG icon.
- Reset an edited service back to its shipped default markup with the Reset button.
- Use `[sharerich:url]` / `[sharerich:title]` / `[sharerich:summary]` / `[sharerich:description]` tokens in markup.
- Add your own custom button by dropping a new `.inc` file in the module's `services/` directory.
- Set the Facebook App ID and site URL for the Facebook feed-dialog share widget.
- Configure the Twitter/X `via` user and YouTube/GitHub/Instagram usernames in global settings.
- Restrict the HTML tags permitted in button markup via the `allowed_html` setting.
- Place a Sharerich block and choose which set it renders.
- Choose horizontal or vertical button orientation for a placed block.
- Make a vertical bar sticky so it floats and follows visitors as they scroll.
- Show contextual share buttons that reflect the current node, taxonomy term or user page.
- Duplicate a set to build variant button bars for different content types or regions.
- Include a WhatsApp share button that opens the chat share sheet on mobile.
- Include a Print button that triggers the browser print dialog.
- Grant the restricted `administer sharerich` permission only to trusted admin roles.
- Alter the rendered buttons programmatically with `hook_sharerich_buttons_alter()`.
- Rely on the automatically placed default block, or move it to another region.
- Run the site's share buttons with no bundled JS library or jQuery dependency.
