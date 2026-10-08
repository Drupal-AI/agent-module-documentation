# Configuration — the settings form

All of External Links' behavior is controlled from one form. There are no patterns
to create or entities to configure — you simply choose which decorations to apply
and, if you want, narrow down which links they apply to. The settings are stored in
the `extlink.settings` config object, so the whole configuration is exportable
between environments.

## Open the settings form

1. Go to **Configuration → User interface → External Links**
   (`/admin/config/user-interface/extlink`).
2. You land on the **Settings** tab.

![The External Links settings page](../images/settings.png)

Work down the form and enable the options you want, then click **Save
configuration** at the bottom. The sections below describe the key options in the
order you meet them.

## Where the module runs

At the top of the form:

- **Disable on admin routes** — when ticked, External Links stops processing links
  on admin pages (anything under `/admin`). Leave it off to decorate links
  everywhere; tick it if you only care about the public-facing site and want to
  keep the back end untouched.
- **Load exclusions and inclusions externally** — normally the module's settings
  are embedded in each page. Tick this to serve them from a separate cacheable
  JavaScript file instead. If you have a large number of include/exclude patterns,
  this reduces the amount of markup added to every page and helps page caching.

A note on the form reminds you that the `ext` CSS class is automatically added to
all external links, so you can target them from your theme's CSS regardless of the
icon settings.

## Place an icon on external, mailto, and tel links

The next group turns the icons on and off:

1. **Place an icon next to external links** — when ticked (the default), a small
   "external link" icon is added to every off-site link so readers can see they are
   leaving your site.
2. **external link label** — the assistive-technology text announced for that icon.
   The default is `(link is external)`. Change it to reword what screen-reader
   users hear.
3. **Place an icon next to mailto links** — adds an envelope icon to every
   `mailto:` email link. Its **mailto: label** field (default `(link sends email)`)
   sets the screen-reader text.
4. **Place an icon next to tel: links** — adds a phone icon to every `tel:`
   telephone link. Its **tel: Label** field (default `(link is a phone number)`)
   sets the screen-reader text.
5. **Place an icon next to image links** — off by default. Tick it to treat an
   image wrapped in a link as an external link and decorate it too.

Further down, two options change *which* icons are used instead of the bundled
images:

- **Use Font Awesome icons instead of images** — adds Font Awesome classes and an
  `<i>` tag rather than the bundled PNG icons. As the form warns, this only works if
  Font Awesome is already loaded on your site.
- If the optional **UI Icons** module is installed, you can instead choose icons
  from a UI Icons icon pack for the external, mailto, and tel links.

## Open external links in a new window

Turn on the new-window option to make external links open in a fresh browser tab:

1. Tick **Open external links in a new window** (its config key is
   `extlink_target`; off by default). External links then get
   `target="_blank"`, and the module also adds `rel="noopener"`/`rel="noreferrer"`
   so the new page cannot tamper with the page it came from or read the referring
   URL.
2. To keep visitors informed, the module can append a short **"(opens in a new
   window)"** notice to the link. The notice is on by default; you can edit its
   wording in the accompanying text field.

There are also "do not override" options that tell the module to leave a link's
existing `target`, `title`, or `rel` attribute alone if the markup already sets
one, rather than replacing it.

## Show a confirmation pop-up before leaving

External Links can warn visitors before their browser follows an off-site link:

1. Tick the **confirmation pop-up** option (config key `extlink_alert`; off by
   default).
2. Edit the accompanying **alert text** to set the message shown in the pop-up —
   the default is a warning that the visitor is about to leave your site. When
   enabled, clicking any external link shows this message and asks the visitor to
   confirm before continuing.

## Control search-engine and referrer attributes

Two options adjust the `rel` attribute on external links:

- **Add `rel="nofollow"`** — off by default. Tick it to tell search engines not to
  pass ranking credit to the linked page.
- **Add `rel="noreferrer"`** — on by default. This stops the browser from sending
  your page's URL to the destination site. You can supply a regular expression in
  the **exclude noreferrer** field to skip `noreferrer` for links whose URL matches
  that pattern.

## Choose which links are processed (include / exclude)

By default every off-site link is decorated. You can narrow that down two ways:

- **By URL pattern (regular expression):**
  - An **include** pattern restricts processing to links whose URL matches it — for
    example, only decorate links to a single partner domain.
  - An **exclude** pattern skips links whose URL matches it — for example, leave
    your own tracking domain undecorated.
- **By CSS selector:**
  - An **exclude** selector skips links inside matching elements (for example,
    ignore any link inside `.no-extlink`).
  - An **include** selector restricts processing to links inside matching elements.
  - An **explicit** selector forces the matched links to be treated as external
    even if they would not otherwise qualify.

You can also add extra CSS classes to every external, mailto, or tel link (separate
fields per link type) to give your theme additional styling hooks.

## Subdomains and whitelisted (allowed) domains

By default the module treats **subdomains of your site as internal**, so a link to
`blog.example.com` from `www.example.com` is not marked as external. Untick the
subdomains option if you would rather treat subdomains as external.

The **allowed domains** (whitelist) field lets you list additional domains that
should always be treated as **internal**, so links to them are never decorated as
external — useful for partner or sister sites that you do not consider "off-site".

## Save

Click **Save configuration** at the bottom of the form. Because the decorations are
applied in the visitor's browser, your changes take effect on the next page load
(you may need to clear caches for the updated settings to be served). Remember that
the icons and warnings only appear for visitors who have JavaScript enabled.
