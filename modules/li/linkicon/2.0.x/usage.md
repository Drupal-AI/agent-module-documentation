<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Icon is an icon-agnostic field formatter for core's Link field that turns each link into an iconized link by building a CSS icon class from the link's title, using a predefined `key|value` list of allowed titles.

---

The module does not define a field type; it works on the core `link` field. It adds a `linkicon` field formatter (id `linkicon`, extending core's `LinkFormatter`) plus a "Predefined" title option on the link field's own settings. When the link field's title is set to *Predefined*, the widget shows a select list built from `key|value[|tooltip]` lines the site builder enters, where the key becomes the icon class suffix (e.g. `facebook` → `<prefix>-facebook`). The formatter then renders each link with an icon element whose class is `linkicon_prefix` + the chosen key (default prefix `icon`), and offers many display options: prefix/wrapper/icon/label classes, tooltip, hide-text, vertical layout, size, color/style presets, position, `rel="nofollow"`, open-in-new-window, a tokenized global title, and optional bundled CSS. A single global settings form (`linkicon.settings`, route `linkicon.settings` at `/admin/config/user-interface/linkicon`, permission `administer linkicon`) only stores one thing: a `font` path (or comma-separated paths) to a custom icon-font CSS file to load. The module is icon-library agnostic — it emits classes only, so it pairs with FontAwesome, Fontello, or any icon font you already load. Configuration is a two-step flow: set *Predefined title* + allowed values on the field (Manage fields), then choose the *Link icon* formatter and its options on Manage display.

---

- Render a person's social links as icons (Facebook, X, LinkedIn) driven by a controlled list of allowed titles.
- Let community members add their own social links without breaking the theme, by restricting titles to a predefined set.
- Build a team-member profile where editors pick from allowed link types and each gets the right icon.
- Add iconized call-to-action links such as "View website", "Buy now", "Demo" using a link field.
- Attach a FontAwesome icon to each link purely by choosing its predefined title (no per-link class entry).
- Reuse an existing icon font (Fontello, custom SVG font) by pointing the module at its CSS file.
- Display link text as a pure-CSS tooltip while showing only the icon.
- Visually hide link text for screen readers while presenting an icon-only link.
- Stack icon above text (vertical layout) for a compact icon menu.
- Add `rel="nofollow"` and open-in-new-window on outbound iconized links.
- Apply a consistent icon prefix class (e.g. `fa`, `icon`, `bi`) across all links in a field.
- Add extra wrapper/icon/label CSS classes for theming without a template override.
- Use a tokenized global title (e.g. `[node:title]`) to override each link's displayed text.
- Present a set of supported social links per node via Views blocks filtered by author.
- Build a sitewide social bar by storing links on the admin user and rendering via Views.
- Trim long link text to a maximum length in the formatter.
- Apply built-in square/rounded/color style presets, or disable the module CSS to style it yourself.
- Load an additional icon-font stylesheet only where the formatter is used, via the module's library integration.
- Standardise which links editors may add on a content type by controlling the allowed `key|value` titles.
- Add tooltips that clarify where an icon link goes for accessibility.
- Show the URL as plain text or URL-only in specific displays, inheriting core Link formatter options.
- Localise/tokenize tooltips and titles for multilingual icon links.
- Create a "Follow us" block with icon links maintained from a single link field.
- Migrate hard-coded themed social markup to a configurable, editor-managed link field.
- Change the icon size or position relative to the text per display mode.
