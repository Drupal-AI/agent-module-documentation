<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Media Platforms puts a site's own social profile links into a configurable block — the row of icons in a footer pointing at the organisation's Facebook, LinkedIn and YouTube pages. The link set lives in one settings form, not on the block, so a single placed block renders whatever is configured.

---

This is the outbound kind of social module, and the distinction matters: it links **out to the organisation's own profiles**, it does not add share buttons for the visitor's use. That difference is largely a privacy one — share widgets load third-party scripts that track visitors on sight and therefore need consent, whereas profile links are ordinary anchors that load nothing and need none. The design decision that sets this module apart from `social_media_links` is that the network configuration lives in a **standalone settings form** (`/admin/config/services/social-media-platforms`), not inside the block instance; you place one block (`social_media_platform_block`, category "Social Media Platforms") and it reflects whatever the form holds. That is what makes it pair cleanly with Domain's `domain_config`: override the config per domain/language, keep one block. The form gives three display choices — icon source (`none` / `image` / `font`), show-label on/off, open-in-new-tab on/off — plus a drag-orderable table of platforms where each row carries a label, a URL, font classes (for icon-font libraries such as FontAwesome, since 1.1), and a weight; platforms with an empty URL are simply skipped at render. Version **1.1.0** on core `^10.2 || ^11`, depending only on core `block`, behind the `administer social media platforms` permission — not marked `restrict access`, defensible since its holder can only set outbound URLs, though those URLs are validated to http/https/ftp/feed schemes (no `javascript:`) and appear on every page carrying the block. The real limitation to weigh: the **platform list is fixed** to the seven the author shipped (Facebook, YouTube, LinkedIn, X, Instagram, Pinterest, TikTok) — the form edits those rows but offers no way to add a new network, and bundled PNG icons exist only for those seven.

---

- Add social profile links to a footer.
- Link to the organisation's LinkedIn page.
- Show social icons in a header region.
- Update a profile URL without a code deploy.
- Standardise social icons across a site.
- Replace a hand-coded template block of pasted HTML.
- Add a YouTube channel link.
- Place social links in a sidebar.
- Keep social URLs in exportable configuration.
- Add links without loading third-party tracking scripts.
- Avoid a cookie-consent requirement for social presence.
- Show only the platforms actually in use (empty URLs are skipped).
- Let a marketer edit profile links from an admin form.
- Add an Instagram or TikTok profile link.
- Render social links with FontAwesome / Bootstrap Icons font classes.
- Control the display order of the icons by weight.
- Show icons only, labels only, or icons plus labels.
- Open social links in a new tab.
- Place one block that serves multiple domains via domain_config.
- Configure different social URLs per domain and language.
- Keep footer branding consistent across a multilingual site.
- Swap in custom icon images via a theme preprocess hook.
