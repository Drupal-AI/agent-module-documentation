<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Childfocus (notfound.org) turns a site's 404 page into a missing-child appeal from the notfound.org initiative (Child Focus), by shipping a block that embeds the notfound.org widget in an iframe and a block-visibility condition that limits it to page-not-found responses.

---

The notfound.org project, run by the Belgian organisation Child Focus, is built on a simple observation: every website has a 404 page that nobody designs and visitors occasionally hit, and that otherwise-dead space can instead carry an appeal for a missing child. This module packages that for Drupal 11. It provides a block plugin (`childfocus_notfound`) whose `build()` renders an `<iframe>` pointing at `https://notfound-static.fwebservices.be/<locale>/404?key=<key>`, where `<key>` is your notfound.org embed key and `<locale>` is derived from the site's interface language (`en`/`fr`/`nl` map to `en-BE`/`fr-BE`/`nl-BE`, otherwise a configured fallback language is used, since notfound.org only serves Dutch, French and English). A companion block-visibility condition ("Show in page not found") returns true only when the current request is a 404, so the same block can be placed once and shown only on error pages. A settings form at `/admin/config/childfocus_notfound` (permission `administer site configuration`) holds the key and the fallback language in the `childfocus_notfound.settings` config object. On install the module auto-creates the block in the `content` region of the default theme with the 404 visibility condition already enabled, so it works immediately after you paste in a key. Its only dependency is core `block`; the widget content itself is loaded by the visitor's browser from notfound.org, not fetched by the Drupal server.

---

- Show a missing-child appeal on the 404 page.
- Support the notfound.org / Child Focus initiative from a Drupal site.
- Use otherwise-empty "page not found" space for a public cause.
- Embed the notfound.org widget without writing any custom code.
- Restrict the appeal to 404 responses using the supplied visibility condition.
- Paste a notfound.org embed key into the admin settings form.
- Set a fallback language (Dutch, French or English) for non-supported site languages.
- Serve region/language-appropriate cases via the `en-BE`/`fr-BE`/`nl-BE` locales.
- Rely on the auto-placed block so the feature works right after install.
- Move or restyle the appeal by editing an ordinary block in Block layout.
- Show the block site-wide by leaving the "page not found" checkbox off.
- Align a public-sector or corporate site with a Belgian CSR campaign.
- Replace a blank not-found page with something purposeful.
- Configure display entirely from the admin UI, no theme edits.
- Hide the block label so only the widget shows.
- Keep the appeal cached per interface language.
- Add social value to an error page at no cost.
- Match the behaviour of other participating sites (e.g. police/government portals).
- Provide a Drupal 11-native replacement for the older Drupal 9 block approach.
- Set the key and language via drush/config for automated deployments.
