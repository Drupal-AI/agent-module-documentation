Ridiculously Responsive Social Share Buttons (RRSSB) adds responsive social share (and follow) buttons to a Drupal site, configured as reusable "button sets" and placed via a block, a Views field, or per content type.

---

RRSSB is built around a **`rrssb_button_set` config entity** (config prefix `rrssb.button_set`, one
`default` set ships on install). Each set chooses which social buttons appear (email, facebook,
twitter, linkedin, pinterest and more), whether they are **share** or **follow** buttons
(`follow: 0|1`), per-button `username`/`weight`/`enabled` values, an `appearance` block (size,
shrink, regrow, rows, alignment) and a `prefix` label. Button sets are managed at
`/admin/config/content/rrssb` (route `entity.rrssb_button_set.collection`, gated by the module's
`administer rrssb` permission). A set is rendered by the helper `rrssb_get_buttons()`, exposed three
ways: the **`rrssb_block`** block plugin, the **`rrssb_buttons`** Views field, and a **per node type**
third-party setting (`node.type.*` → `third_party_settings.rrssb.button_set`) added to the content
type form so every node of that type gets buttons automatically. The actual icons/CSS/JS come from
the external **`rrssb/rrssb-plus`** Composer library (installed as a dependency). Button URLs support
`[rrssb:*]` tokens (url, title, image, username) filled from the current page/node. Modules can add
or alter buttons with `hook_rrssb_buttons()` / `hook_rrssb_buttons_alter()`, and a Drush command
`rrssb:gen-css` regenerates the per-button CSS in the library. There is no field type — buttons are
render output, not stored data.

---

- Add a "Share this" block with Facebook, X/Twitter, LinkedIn, Pinterest and email buttons to article pages.
- Create multiple button sets (e.g. a minimal email+facebook set and a full set) and place different ones per region.
- Show responsive share buttons that collapse to icons on narrow screens without breaking layout.
- Automatically render share buttons on every node of a content type via its third-party `button_set` setting.
- Add a social-share column/field to a Views listing with the `rrssb_buttons` Views field.
- Configure "follow" buttons (link to your profiles) instead of share buttons (`follow: 1` + usernames).
- Set per-button usernames (e.g. your Twitter handle) so follow links point at your accounts.
- Reorder buttons within a set using per-button `weight`.
- Enable or disable individual buttons in a set without deleting them.
- Add a text prefix like "Share:" before the button row (`prefix`).
- Right-align the button row or tune its size/rows via the `appearance` settings.
- Use `[rrssb:url]` / `[rrssb:title]` / `[rrssb:image]` tokens so share URLs use the current page's metadata.
- Add a brand-new social network button from a custom module with `hook_rrssb_buttons()`.
- Point the email button at a newsletter signup by altering it with `hook_rrssb_buttons_alter()`.
- Regenerate the per-button CSS in the RRSSB+ library after changing buttons (`drush rrssb:gen-css`).
- Deploy button sets between environments as exported `rrssb.button_set.*` config.
- Restrict who can manage button sets with the `administer rrssb` permission.
- Provide a consistent share widget across blog, news and product pages using one shared set.
- Place a share block only on full node view via block visibility conditions.
- Add Pinterest sharing that uses the node's main image via the image token.
- Give editors a per-content-type default share set they don't have to place manually.
- Show follow buttons in the site footer linking to all official social accounts.
- Keep icons crisp and responsive using the bundled RRSSB+ SVG library.
- Offer a share widget that needs no third-party script beyond the self-hosted RRSSB+ assets.
