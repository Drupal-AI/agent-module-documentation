Annoying Popup displays one or more configurable, cookie-aware popup overlays to site visitors.

---

Annoying Popup lets administrators define any number of popup overlays as configuration entities and show
them to visitors on chosen paths and languages. Each popup has a rich-text body (a Drupal text-format field),
an optional action button (link, optionally opening in a new window), and a dismiss button. The popup is
rendered client-side from `drupalSettings`; once a visitor dismisses or engages with it, a browser cookie
(`annoying_popup-<id>`) is set with a one-year lifetime so it is not shown again. Visibility is controlled per
popup by request-path rules (with wildcards and show/hide negation) and by language selection. If
`eu_cookie_compliance` is installed, popups only initialize after the visitor has accepted cookies. All
management is behind the `administer annoying popups` permission at
`/admin/config/system/annoying_popup`.

---

- Show a one-time announcement banner/overlay to all visitors.
- Promote a new product, campaign, or feature with a call-to-action button.
- Link visitors to a survey or feedback form via the action button.
- Display a newsletter sign-up prompt with a "Subscribe" action link.
- Show a maintenance or downtime notice on selected pages.
- Present a promotional discount code to first-time visitors.
- Serve a consent / policy-update notice that visitors can dismiss.
- Target the popup to only the front page using `<front>` in the path rules.
- Target the popup to a section using a wildcard path like `/blog/*`.
- Hide a popup on specific paths using the "Hide for the listed pages" negation.
- Show a language-specific popup only to visitors browsing in a given langcode.
- Hide a popup for certain languages using the language negation option.
- Run several independent popups at once, each with its own cookie and rules.
- Open the action link in a new browser tab/window when desired.
- Remember dismissal across visits for a year via the dismissal cookie.
- Delay popup appearance briefly after page load (built-in ~1s reveal).
- Gate popup display on cookie consent when using `eu_cookie_compliance`.
- Export/import popups between environments as configuration.
- Enable or disable a popup without deleting it via the "Enabled" flag.
- Style popups via the module's minimal CSS or your own theme overrides.
- Customize the dismiss button label per popup.
- Provide an "engage" action that both records the cookie and follows the link.
