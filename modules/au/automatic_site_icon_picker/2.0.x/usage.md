Automatic Site Icon Picker adds a "Link (favicon)" field formatter that shows the remote site's favicon next to each link value, fetched automatically from the external Vemetric Favicon API.

---

The module ships one core-link field formatter, `automatic_site_icon_picker_link` (label "Link (favicon)", plugin class `AutomaticSiteIconPickerLinkFormatter`). On render it walks each item of a `link` field, resolves internal/entity URIs to absolute URLs, extracts the host with `parse_url()`, and — if a cached PNG does not already exist under `public://social-media-icons/` — requests a favicon for that host from `https://favicon.vemetric.com/{domain}?format=png&size={16|32|64}`. The downloaded bytes are saved as `{host-with-dashes}-{size}px.png` and rendered through the `automatic_site_icon_picker` theme hook (template `automatic-site-icon-picker.html.twig`) as an `<img>` wrapped in an `<a>` to the link. Per-display settings choose the display mode (icon only / icon + URL / icon + title), icon size (16/32/64 px), and whether the link opens in a new window (`target="_blank"` with `rel="noopener noreferrer"`). It depends only on core `field`, provides no routes/services/permissions/entities, and requires outbound internet access to reach the Vemetric API.

---

- Show a favicon beside every external link stored in a core link field.
- Build a "social media links" list where each row renders the destination site's icon.
- Render a footer or sidebar block of partner/sponsor sites, each with its own favicon.
- Display a directory or resource listing where entries link out to external domains, each iconified.
- Add favicons to a "related sites" or "external references" field on articles.
- Present a link field in "Icon only" mode to produce a compact row of site icons.
- Present links in "Icon and URL" mode so both the favicon and the full URL text are shown.
- Present links in "Icon and Title" mode so the favicon appears with the link's title text.
- Choose 16px icons for dense inline lists, 32px for standard rows, or 64px for prominent cards.
- Force external links to open in a new tab via the formatter's "Open link in new window" option.
- Auto-cache favicons on first view so repeated renders serve the local PNG without new API calls.
- Provide favicons for user-entered link fields without maintaining an icon library manually.
- Iconify a bookmarks/favorites content type built on link fields.
- Add site icons to an aggregated feed of external article URLs.
- Show brand icons next to vendor/marketplace listing links.
- Decorate menu-like content (built from link fields) with per-destination favicons.
- Display icons for links that use internal or entity URIs (they are resolved to absolute URLs first).
- Give editors a zero-configuration way to add favicons: they only enter a URL, the icon is fetched automatically.
- Standardize favicon size across a listing regardless of each source site's native icon dimensions.
- Reuse already-downloaded icons across many nodes that reference the same domain (shared cache file).
- Present a "trusted sites" or "certifications" section where each external link shows its favicon.
- Add visual recognition to long link lists so users can scan by icon rather than reading URLs.
