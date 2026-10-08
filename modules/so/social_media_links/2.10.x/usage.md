Social Media Links Block provides a configurable Drupal block that renders a row of icon links to your profiles on social networks (Facebook, X/Twitter, Instagram, LinkedIn, YouTube and dozens more), using a selectable icon set.

---

The module ships a `social_media_links_block` block plugin that you place like any other block and configure entirely from the block form. You add one entry per network, entering just the handle/URL portion — each **Platform** plugin supplies the URL prefix/suffix so `mycompany` becomes the correct profile URL. Around 50 platforms are bundled (Facebook, X, Instagram, LinkedIn, YouTube, TikTok, GitHub, GitLab, Mastodon, Telegram, WhatsApp, RSS, email, and many more), and the list is extensible: platforms are annotation-based plugins under `Plugin/SocialMediaLinks/Platform`. Icon rendering is likewise pluggable through **Iconset** plugins — bundled sets include Font Awesome, Elegant Themes, Nouveller and IcoMoon — and an `IconsetFinderService` locates downloaded icon libraries in the libraries directory. The block form lets you set appearance options such as the icon set, icon size/style, orientation (horizontal/vertical), link attributes (target, rel), and per-link ordering. A Twig extension provides a safe-link filter for rendering. Because it is a standard block it can be placed per region, per theme, and restricted with the usual block visibility conditions. A companion submodule, **Social Media Links Field**, offers the same capability as a field type so editors can store social profiles on any entity. It targets Drupal 9.5, 10 and 11.

---

- Add a footer block with icon links to all your social profiles.
- Show Facebook, X, Instagram and LinkedIn icons in the header.
- Link to a YouTube channel and a TikTok profile from a sidebar.
- Render a mailto/email icon alongside social icons.
- Add an RSS feed icon to the social bar.
- Enter just a username and let the platform build the full URL.
- Switch the whole set between Font Awesome and another icon set.
- Choose icon size/style (e.g. Font Awesome 2x/3x) in the block form.
- Display icons horizontally in a footer or vertically in a sidebar.
- Open social links in a new tab via link target attributes.
- Add `rel="nofollow"` or `noopener` to outbound social links.
- Reorder the icons to control which network shows first.
- Place different social blocks per theme (e.g. admin vs front-end).
- Restrict the block to certain pages with block visibility conditions.
- Link to less common networks like Mastodon, Xing, or VKontakte.
- Add a WhatsApp or Telegram contact link.
- Link to a GitHub or GitLab profile from a developer site.
- Add a Patreon or Amazon link for creator/commerce sites.
- Use a downloaded custom icon library located automatically by the finder.
- Define a brand-new platform (network) via a Platform plugin.
- Add a custom icon set via an Iconset plugin.
- Store per-entity social profiles using the field submodule.
- Show an author's social links on their profile page (field).
- Keep social links out of theme templates and manage them as config.
- Provide a consistent social bar across a multisite via exported block config.
