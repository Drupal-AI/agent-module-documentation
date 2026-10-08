Civic GovUK Cookie Control renders a GOV.UK Design System styled cookie-consent banner block for public-facing UK government / DWP services, reusing the parent Civic Cookie Control module's configuration.

---

This submodule of `civiccookiecontrol` provides an alternative front end to the standard hosted Civic widget: instead of Civic's JavaScript overlay, it exposes Drupal blocks (`govuk_cookiecontrol_banner_block` and a details block) that render GOV.UK-classed markup from Twig templates. Banner text is pulled from the parent module's `civiccookiecontrol.settings` (title, intro, statement description, accept/reject labels, privacy-policy node link) and from the submodule's own `civic_govuk_cookiecontrol.settings` (accepted/rejected messages, change-cookie-settings link text, hide button). For non-English languages it reads the matching `altlanguage` config entity and the Drupal locale string store, so it requires the `language` and `config_translation` modules. Configure it at `/admin/config/system/cookiecontrol/govuk` and place the banner block in a region.

---

- Show a GOV.UK Design System compliant cookie banner on a DWP or other UK public-sector Drupal site.
- Provide a standards-aligned alternative to the default Civic Cookie Control overlay.
- Reuse the parent module's title, intro and privacy-statement configuration for the banner.
- Link the banner to a privacy-policy node chosen in the parent module's settings.
- Customise "You have accepted/rejected cookies" confirmation messages.
- Customise the "change your cookie settings" prefix, link text and suffix.
- Set the accept and reject button labels (from parent config) shown on the banner.
- Add a "Hide" button label to dismiss the confirmation message.
- Render translated banner text per language via alternative-language entities and locale strings.
- Place the banner block at a fixed position on top of the page via the block's "Fixed position (top)" option.
- Provide a `<noscript>` fallback banner that posts to `/set-cookie-message` when JavaScript is off.
- Offer a separate cookie-settings details block for a dedicated preferences page.
- Keep public-sector services consistent with GOV.UK typography and button styling.
- Manage the banner as a standard Drupal block (visibility, region, theme).
- Support English default text plus config_translation-managed translations for other languages.
