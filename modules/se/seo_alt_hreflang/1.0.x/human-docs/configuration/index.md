# Configuration

All this module does is store a per-language mapping of alternative `hreflang`
codes, so its one settings form is where all the work happens.

## Open the settings form

1. Log in as a user with the **Administer Alternative Hreflang configuration**
   (`administer seo alt hreflang configuration`) permission. This permission is
   marked as restricted access, so grant it only to trusted roles.
2. Go to **Configuration → Regional and language → Languages → Alternative
   Hreflang settings**, or navigate directly to
   `/admin/config/regional/language/seo-alt-hreflang`.

## The form, language by language

The form lists **every language installed on your site**, each with a single text
field:

- **Alternative hreflang code** — enter the code you want emitted in the
  `hreflang` attribute for that language. For example, put `en-GB` next to your
  English language while leaving the URL langcode as `en`, or enter a
  `zh-Hans` / `zh-Hant` distinction that a plain Drupal langcode cannot express.
- **Leave a field blank to change nothing.** Blank or whitespace-only entries are
  filtered out, and the module only overrides a language's `hreflang` when you
  supply a code that actually differs from the registered one. You do not have to
  fill in every language — only the ones you want to adjust.

## Save

Save the form. The mapping takes effect on the emitted markup right away: the
alternate-language `<link>` tags in the page head and the language-switcher link
attributes will carry your custom codes, while URL prefixes, routing, and
canonical URLs remain untouched. Values are HTML-escaped when written, and the
rewriting is skipped on 403 and 404 responses. Confirm the result by viewing the
source of a translated page.
