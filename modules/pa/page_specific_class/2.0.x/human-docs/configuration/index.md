# Configuration

All of Page Specific Class lives in **one settings form** with a single text area.
Each line you enter maps a page (by path) to the CSS class or classes that should
be added to that page's `<body>` tag.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Page Specific Class**, or navigate
   directly to `/admin/config/page-class/settings`.

## The syntax: one `path|class` rule per line

The form is a single text area. Enter **one mapping per line**, in the form:

```
/<path>|<class>
/<path>|<class1 class2 class3>
```

The rules the module follows:

- **The path must start with `/`.** The form validates this and rejects a line
  whose path has no leading slash.
- **The path comes first, then a pipe (`|`), then the class(es).** Everything
  after the pipe is treated as the class list.
- **Multiple classes on one page?** Separate them with spaces — every one of them
  is added to the body tag.
- **One rule per line.** Add as many lines as you need.
- Each class you enter is cleaned up into a valid CSS identifier before it is
  applied, so odd characters are normalised for you.

## Special targets

As well as ordinary paths, a few special targets let you aim at the front page,
every page, or a whole section at once:

| Line you enter | What it does |
|----------------|--------------|
| `/node/1\|special-offer` | Adds `special-offer` on `/node/1` (alias‑aware — a friendly URL for that node matches too). |
| `/pricing\|pricing dark compact` | Adds three classes — `pricing`, `dark`, and `compact` — on `/pricing`. |
| `/<front>\|home-page` | Adds `home-page` on the site's front page, whatever path that happens to be. |
| `/*\|has-js-enhancements` | Adds `has-js-enhancements` on **every** page of the site. |
| `/content/article*\|article-theme` | Wildcard: adds `article-theme` on any path that **starts with** `/content/article`. |

Matching resolves both the path you entered and the page a visitor is on through
Drupal's path‑alias system, so you can enter either the alias or the internal path
and it will still match. A wildcard rule (`…*`) matches whenever the current page's
path begins with the text before the `*`.

## A worked example

To give one landing page a special class, tag every article, and add a site‑wide
JavaScript hook, you would enter:

```
/summer-sale|landing-page campaign
/content/article*|article-theme
/*|has-js
```

## Save

Click **Save configuration**. The changes take effect immediately — visit one of
the mapped pages and inspect its `<body class="…">`; your configured class(es)
appear alongside the classes Drupal adds itself. To remove a page's special class
later, delete its line and save the form again.
