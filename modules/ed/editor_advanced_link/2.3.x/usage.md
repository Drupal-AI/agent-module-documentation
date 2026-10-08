Editor Advanced Link extends the CKEditor link dialog so content editors can set extra `<a>` attributes — title, CSS classes, id, ARIA label, `rel`, and "open in new window" (`target="_blank"`) — directly when creating or editing a link.

---

By default Drupal's CKEditor link dialog only lets editors enter a URL and (optionally) link text. This module adds a configurable set of advanced attributes to that dialog so authors can enrich links without dropping into source-editing mode. It ships as a CKEditor 5 plugin ("Advanced links") that you enable per text format, plus a form alter that adds the same fields to the classic/editor link dialog and to compatible dialogs such as Linkit's. Which fields appear is controlled two ways: the plugin's own "Enabled attributes" settings (checkboxes for ARIA label, Title, CSS classes, ID, "Open in new window", and Link relationship) and the text format's "Limit allowed HTML tags" filter — an attribute only shows if it is allowed on the `<a>` tag. Enabling "Open in new window" registers a manual link decorator that writes `target="_blank"`. The module stores no content of its own and defines no admin route; all configuration lives inside each text format's CKEditor 5 settings. It has no dependencies beyond core's Editor module and provides a config schema so settings are validatable and exportable. Recommended companions include Editor File, Linkit, and CKEditor Entity Link for richer link-building experiences.

---

- Let editors add a `title` tooltip to links from the CKEditor dialog.
- Add a `target="_blank"` "open in new window/tab" checkbox to links.
- Add `rel="nofollow"` to outbound or user-generated links for SEO.
- Add `rel="noopener noreferrer"` on links that open in new tabs for security.
- Apply CSS classes to links so they render as buttons or styled call-to-actions.
- Give a link an `id` so it can be targeted by a URL fragment anchor.
- Set an `aria-label` on links for assistive-technology users.
- Improve accessibility of icon-only or ambiguous "read more" links.
- Enable only the attributes editors are allowed to touch, per text format.
- Restrict advanced attributes by tightening the "allowed HTML tags" filter.
- Provide button-style links in body content without custom code.
- Let marketers add tracking/utility classes to campaign links.
- Add JS-gallery `rel` attributes (e.g. lightbox groupings) to image links.
- Configure different link capabilities for different text formats (Basic vs Full HTML).
- Add advanced attributes to Linkit's autocomplete link dialog.
- Add advanced attributes to the Editor File upload link dialog.
- Migrate CKEditor 4 "Advanced Link" configuration to CKEditor 5 automatically.
- Export a text format's advanced-link settings as deployable configuration.
- Prevent editors from adding attributes not permitted by the format's filter.
- Set an accessible label distinct from the visible link text.
- Add anchor targets within long articles for in-page navigation.
- Standardize link styling across a site via shared CSS classes.
- Encourage WCAG-compliant new-window links via built-in guidance text.
- Let editors mark sponsored links with `rel="sponsored"`.
- Keep authors out of source view by exposing attributes in the UI.
