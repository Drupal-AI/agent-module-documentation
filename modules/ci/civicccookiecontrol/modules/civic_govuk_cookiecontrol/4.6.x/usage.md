Civic GovUK Cookie Control is a submodule of Civic Cookie Control that renders the consent experience in
the GOV.UK / DWP Design System cookie-consent pattern, for public-facing UK government (DWP) services.
Instead of Civic's default floating widget it provides two blocks — a cookie banner and a cookie-details
panel — plus a small settings form to customise and translate the pattern's fixed button and message text.

---

Use it when a site must follow the DWP/GOV.UK cookie pattern rather than Civic's standard widget styling.
The parent Civic Cookie Control module still does the real work — API key, cookie categories, privacy
statement node — and this submodule reuses that configuration, adding GOV.UK-styled presentation. Place
the "GovUk CookieControl Banner" block at the top of the theme and the "GovUk CookieControl Details" block
on the cookie-policy page; the details block lists each cookie category with an accept/reject toggle. It
depends on the `language` and `config_translation` modules and preloads its button/message strings into
locale storage so they can be translated per language. All configuration is behind the parent's
`administer civiccookiecontrol` permission; the submodule adds no permission of its own.

---

- Present cookie consent in the official GOV.UK / DWP cookie-consent pattern.
- Add a GOV.UK-styled cookie banner to the top of a government service site.
- Provide a cookie-details / preferences panel on the cookie-policy page.
- Let visitors change per-category consent from the details block.
- Reuse the parent module's cookie categories automatically in the GOV.UK UI.
- Pin the banner to the top of the page (block `fixed_top` setting).
- Customise the "accept/reject" confirmation messages.
- Customise the "change your cookie settings" link text and surrounding prefix/suffix.
- Customise the "Save and continue" / "Optional cookie settings" labels.
- Translate all GOV.UK pattern strings per language via config translation.
- Localise the banner using the parent's alternative-language entities.
- Link the banner to a Drupal privacy-policy node defined in Civic Cookie Control.
- Build a DWP-compliant service (e.g. Pensions Ombudsman-style) consent flow.
- Keep GDPR consent gating (onAccept/onRevoke) from the parent while restyling the UI.
- Show a compliant banner + policy page pairing rather than a single floating widget.
