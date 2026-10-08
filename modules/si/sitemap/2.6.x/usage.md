Sitemap builds a single human-readable page (default `/sitemap`) that gives visitors an overview of a site's notable content — menus, taxonomy vocabularies, the front page, RSS feeds and more — assembled from pluggable, configurable sections.

---

Unlike XML Sitemap (which produces machine-readable `sitemap.xml` for search engines), this module renders an HTML overview page for human visitors, useful for lightly-organized, content-heavy sites. What appears on the page is composed from **Sitemap plugins**: the module ships a Frontpage plugin (a link plus optional site RSS feed), a Menu plugin (derived per menu), and a Vocabulary plugin (derived per taxonomy vocabulary, with node counts and optional RSS feeds and depth limits). Site builders enable and order these sections and set per-plugin options at Admin → Configuration → Search and metadata → Sitemap, along with the page title, path, an optional intro message, and whether to include the module's CSS. Two blocks are provided — a Sitemap block and a Syndicate (feed-icon) block — so the overview or feed links can also be placed in regions. A route subscriber lets the sitemap live at a configurable path. Output is fully themeable through a set of Twig templates and theme hooks, and developers can alter taxonomy listings with `hook_sitemap_vocabulary_alter()` / `hook_sitemap_vocabulary_VID_alter()`, or add entirely new section types by writing a Sitemap plugin. Access is controlled by dedicated permissions, including restricted ones for revealing disabled menu links or unpublished terms. Submodules add Book outline (`sitemap_book`) and meta-tag (`sitemap_metatag`) support.

---

- Publish a human-readable `/sitemap` overview page for visitors.
- List every menu (main, footer, custom) as an expandable tree.
- Show all taxonomy vocabularies with their terms on one page.
- Display node counts next to taxonomy terms.
- Add RSS feed links for vocabularies or the front page.
- Provide a "syndicate" feed icon block for the site's main feed.
- Place a sitemap overview in a sidebar via the Sitemap block.
- Change the sitemap's path from `/sitemap` to a custom URL.
- Set a custom page title and introductory message.
- Reorder sitemap sections by weight.
- Limit the depth of taxonomy trees shown.
- Enable or disable the module's default CSS styling.
- Show book outlines on the sitemap (with sitemap_book).
- Add meta tags to the sitemap page (with sitemap_metatag).
- Reveal disabled menu links to trusted roles (restricted permission).
- Reveal unpublished taxonomy terms to trusted roles (restricted permission).
- Add a front-page RSS link (restricted permission).
- Give visitors a single navigable index of the whole site.
- Alter or filter taxonomy terms before display via hooks.
- Add a custom sitemap section (e.g. recent content) via a Sitemap plugin.
- Override sitemap Twig templates to match a theme.
- Provide theme suggestions per sitemap item / menu.
- Help SEO indirectly by surfacing internal links on one page.
- Offer an accessibility-friendly text overview of site structure.
- Restrict who can view the sitemap with the 'access sitemap' permission.
