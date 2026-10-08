# Configuration — choosing what appears on the sitemap

The **Settings** page is where you shape the sitemap page: give it a title and an
optional introductory message, decide which URL it lives at, and — most
importantly — tick which **sections** appear on it. Each section (the front page,
a menu, a taxonomy vocabulary, a book outline, an RSS link) is added by enabling
its checkbox.

Remember that this builds a **human-readable** overview page. It does not affect
the machine-readable `sitemap.xml` used by search engines — that is a separate
module (see the [introduction](../index.md)).

## Open the Settings page

1. Log in as an administrator.
2. Go to **Configuration → Search and metadata → Sitemap**
   (`/admin/config/search/sitemap`).
3. Make sure you are on the **Settings** tab (it is the default).

![The Sitemap settings page](../images/settings.png)

## Set the page title and path

1. **Page title** — the heading shown at the top of the sitemap page. It defaults
   to *Sitemap*. Type whatever you want visitors to see, for example *Site
   overview* or *Browse the site*.
2. **Path** — the relative URL the page is served at. Leave it as `sitemap` to use
   the default `/sitemap`, or type a different path (for example `site-index`) to
   serve the page at `/site-index` instead.

## Add an introductory message

The **Sitemap message** box lets you write a short paragraph that appears **above**
the sitemap sections — a good place for a sentence explaining what the page is or
pointing visitors at your search box.

1. Type your message into the **Sitemap message** field.
2. Use the **Text format** selector beneath it to choose how the text is processed.
   *Plain text* (the default) turns line breaks into paragraphs and auto-links
   URLs but allows no HTML; pick a richer format if you need links or markup.

Leave the message blank if you don't want any intro text.

## Choose which sections to include

Scroll down to **Enabled plugins**. This is the heart of the configuration: each
checkbox adds one section to the sitemap page. Tick the ones you want and leave the
rest unchecked. Depending on what is installed on your site you may see:

- **Site front page** — adds a link to your home page at the top of the sitemap.
  If you have granted the restricted *front page RSS link* permission, this section
  can also show a link to the site's main RSS feed.
- **One entry per menu** — for example *Main navigation* or *Footer*. Each ticked
  menu is rendered on the page as an expandable tree of its links, so visitors can
  see your navigation laid out in full.
- **One entry per taxonomy vocabulary** — for example *Tags* or, in the screenshot
  above, *Classification* and *Font Designer*. Ticking a vocabulary lists all of
  its terms on the sitemap. Vocabulary sections offer extra per-section options,
  such as showing the **number of items (node count)** next to each term, limiting
  the **depth** of the term tree that is displayed, and adding an **RSS feed** link
  per term.
- **Book outlines** — available when the **Sitemap book** submodule is enabled;
  lists your book navigation on the page.
- **RSS / feed links** — surface feed links for the front page or for individual
  vocabularies, so visitors can subscribe.

Each checkbox has a short description under it explaining what that section adds.
You can enable as many or as few as you like.

## Save and view the result

1. Click **Save configuration** at the bottom of the form.
2. Open the sitemap page — click the **View** tab at the top of the settings page,
   or browse directly to `/sitemap` (or the custom path you set).

You should see your page title, your intro message (if you added one), and a
section for each item you ticked — menus as trees, vocabularies as term lists, and
so on. Adjust the checkboxes and save again any time you want to add or remove a
section.

> **Reminder:** visitors can only reach this page if their role has the **"View
> published Sitemap page"** (`access sitemap`) permission — see
> [Installation](../installation/index.md) for how to grant it.
