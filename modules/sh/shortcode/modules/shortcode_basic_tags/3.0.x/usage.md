Shortcode Basic Tags is the bundled starter set of ready-to-use shortcode tags (quote, img, highlight, button, dropcap, item, clear, link, block, random) for the Shortcode framework.

---

This submodule of `shortcode` ships a small library of `Plugin\Shortcode` classes so a site can use shortcodes immediately without writing any plugins. Each tag is a `ShortcodeBase` subclass in `src/Plugin/Shortcode/`. Most render through a Twig template registered by the module's `hook_theme()` (`ShortcodeBasicTagsHooks::theme()`): `shortcode_quote`, `shortcode_img`, `shortcode_button`, `shortcode_dropcap`, `shortcode_item`, `shortcode_clear`, `shortcode_link`. The `highlight` and `random` tags build output directly. The `img`, `link`, and `button` tags rely on the parent module's `MediaUrlResolver` service/trait to turn media references and image styles into URLs, and `block` renders a `block_content` entity via the entity view builder. Requires the base `shortcode` module and the `Shortcodes` filter enabled on a text format; individual tags are then toggled and reordered per format.

---

- Enable a curated set of embed tags without writing any custom plugin code.
- Wrap text in a styled quote with `[quote author="Jane" class="right"]...[/quote]`.
- Render an image from a URL with `[img src="/files/x.jpg" alt="..." /]`.
- Render an image from a media entity id with `[img mid="12" imagestyle="medium" /]`.
- Highlight a run of text with `[highlight]...[/highlight]` (adds a `highlight` CSS class).
- Add a drop-cap first letter/run with `[dropcap]...[/dropcap]`.
- Insert a button-styled link with `[button path="/node/1"]Read more[/button]`.
- Insert an aliased link with `[link path="/about"]About us[/link]`, or get just the URL by omitting the text.
- Point a link/button at a media file URL with the `media_file_url="true"` attribute.
- Wrap content in a `div` or `span` with custom classes/id/style via `[item type="span" class="..."]...[/item]`.
- Add a float-clearing element with `[clear /]` or `[clear type="span"]...[/clear]`.
- Embed a custom block content entity inline with `[block id="3" view="full" /]`.
- Generate placeholder text of a set length with `[random length="12" /]`.
- Enable only the tags you want on a given text format and disable the rest.
- Reorder tags per format using each plugin's weight to control token collisions.
- Override any tag's markup by overriding its Twig template (`shortcode-*.html.twig`) in your theme.
- Provide editors a small, memorable vocabulary of embeds instead of raw HTML access.
- Use the tags as copy-paste references when building your own shortcode plugins.
