# Configuration — add a CSS or JS injector

Everything you do with Asset Injector starts from the same place: the **Asset
Injector** overview page. From there you create individual snippets — one for each
bit of CSS or JavaScript you want to add to your site. Each snippet is a separate
configuration entity, so it can be enabled, disabled, edited, or deleted on its
own, and it exports cleanly with the rest of your site config.

## Open the Asset Injector page

Go to **Configuration → Development → Asset Injector**
(`/admin/config/development/asset-injector`). You will see the two collections —
**CSS Injector** and **JS Injector**:

![The Asset Injector overview page listing CSS Injector and JS Injector](../images/list.png)

- Click **CSS Injector** to work with stylesheets.
- Click **JS Injector** to work with scripts.

Each collection lists the snippets you have already created (empty on a fresh
install) and offers a button to add a new one.

## Add a CSS injector

1. From the overview page, click **CSS Injector**, then use the **Add CSS
   injector** button to open the new-snippet form.
2. **Label** — give the snippet a human-readable name, for example
   `Homepage spacing fix`. Drupal derives a **machine name** from the label; this
   is the identifier used in the exported config file.
3. **Code** — paste your raw CSS into the code field.
4. **Conditions** — decide **where** the CSS loads. The conditions are Drupal's
   standard visibility conditions, so you can scope a snippet to, for example:
   - specific **pages / paths** (enter one path per line, or use a wildcard like
     `/blog/*`);
   - certain **content types**;
   - particular **user roles**.
   Leave the conditions blank to load the snippet on every page.
5. **Media** (CSS only) — if the styles should apply to a particular medium, set
   the media type/query (for example `print` for print-only styles). Otherwise
   leave the default.
6. Click **Save**. The snippet now appears in the CSS Injector list, where you can
   later edit, duplicate, disable, or delete it.

## Add a JS injector

1. From the overview page, click **JS Injector**, then use the **Add JS injector**
   button.
2. **Label** and **Code** work exactly as for CSS — name the snippet and paste
   your JavaScript.
3. **Conditions** — the same visibility conditions apply, so you can restrict the
   script to certain paths, content types, or roles, or leave them blank to load
   it site-wide.
4. **Placement (header / footer)** — choose where the script is attached. Placing
   a script in the **footer** lets the page render first, avoiding render-blocking;
   choose the **header** when the script must run early.
5. **Preprocess** — when enabled, the snippet is eligible for Drupal's asset
   aggregation, so it can be combined and minified with other scripts for better
   performance. Turn it off for a snippet that must stay as its own separate file
   (for example some third-party embeds).
6. **Library dependencies** — if your script relies on another library, declare it
   here (for example `core/jquery`) so Drupal loads that library first.
7. Click **Save**. The snippet appears in the JS Injector list.

## How snippets are loaded

Behind the scenes, Asset Injector compiles your enabled snippets into a dynamic
Drupal library and attaches it to the pages that match each snippet's conditions.
Because it goes through the normal library system, core's aggregation and caching
apply to your custom CSS and JS just like any other asset.

## Export your snippets as config

Because every snippet is a configuration entity (`asset_injector_css` /
`asset_injector_js`), it lives in your site's exportable configuration rather than
in the database as content. Export it along with the rest of your config:

```bash
drush config:export
```

This writes the snippet to a YAML file that you can commit to version control and
deploy to other environments — the same snippet then appears on staging and
production without re-entering it by hand, which also makes it easy to share a
common tweak across a multisite.
