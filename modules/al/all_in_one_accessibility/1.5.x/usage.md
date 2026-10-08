<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
All in One Accessibility embeds the Skynet Technologies "All in One Accessibility" third-party JavaScript widget on every page, adding an accessibility toolbar (screen reader, contrast, text zoom, profiles, etc.) aimed at ADA/WCAG compliance.

---

The module is a thin integration around a hosted external widget. Its settings form
(`/admin/config/development/all-in-one-accessibility/ada_compliance`, route
`all_in_one_accessibility.admin.allinoneaccessiblity`, permission
`all_in_one_accessibility_settings`) writes a single config object
`all_in_one_accessibility.userid.settings` holding the licence token (`userid`) and widget
appearance options — `colorcode`, `position` (default `bottom_right`), `widget_size`
(`regularsize`), `aioa_icon_type` (`aioa-icon-type-1`), `aioa_icon_size`, custom size/position
flags and values, `statement_link`, and `nofreeversion`. On every page it uses
`hook_library_info_build()` + `hook_page_attachments()` to attach an external script
(`https://www.skynettechnologies.com/accessibility/js/all-in-one-accessibility-js-widget-minify.js`)
with the token, colour and position encoded in the URL query, rendered with the DOM id
`aioa-adawidget`. The actual accessibility features (140+ languages, screen reader, voice
navigation, profiles…) are provided by the **remote** widget, not by this module; a licence
token from Skynet Technologies is required for the full/paid version, and the module's install
hook registers the site's domain with the vendor's API. Because the functional surface is the
hosted widget, everything you configure locally lives in that one config object. No config
schema, plugins, or Drush commands are provided.

---

- Add an accessibility toolbar/widget to a Drupal site for ADA/WCAG 2.1/Section 508 posture.
- Show a floating accessibility button in a chosen corner (`position`, e.g. `bottom_right`).
- Set the widget's brand colour via `colorcode`.
- Enter a Skynet Technologies licence token (`userid`) to activate the paid widget.
- Choose the widget button size (`widget_size`, e.g. `regularsize`/`oversize`).
- Pick an icon style (`aioa_icon_type`) and icon size (`aioa_icon_size`).
- Use a custom pixel position for the button (`is_widget_custom_position` + left/right/top/bottom).
- Link to an accessibility statement page (`statement_link`).
- Provide screen-reader, contrast, and text-zoom controls to visitors via the hosted widget.
- Offer multi-language accessibility profiles without building them yourself.
- Toggle between the free and licensed widget behaviour (`nofreeversion`).
- Register the site domain with the vendor on install for widget provisioning.
- Give a marketing/compliance team a no-code accessibility overlay.
- Position the widget to avoid clashing with an existing chat button.
- Apply consistent accessibility branding across a multisite via exported config.
- Quickly add a visible accessibility affordance for an audit or legal requirement.
- Restrict who can add/remove the widget with the `all_in_one_accessibility_settings` permission.
- Change the widget appearance globally from one settings page.
- Embed the widget site-wide (all pages) via page attachments, no block placement needed.
- Swap the licence token when moving from trial to paid.
