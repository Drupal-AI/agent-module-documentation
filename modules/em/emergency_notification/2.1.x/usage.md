Emergency Notification displays a single, admin-authored alert banner (a dismissible popup) on every page of a Drupal site, with an optional set of pages excluded by path.

---

The module adds a site-wide emergency/announcement notice that is injected into the top of every page via `hook_page_top()`. An administrator with the "Emergency notification settings" permission configures one notice at Configuration > System > Emergency Notification settings: an enable toggle, a title, a rich-text notice body (a text-format field), a label for the reopen button, an optional set of custom overlay/background/foreground colors, and a newline-separated list of path patterns (with `*` wildcards, matched against both the system path and its alias) on which the notice is suppressed. The front-end JavaScript (`Drupal.behaviors.emergencyNotification`) opens the popup, lets the visitor dismiss it, and remembers the dismissal in cookies keyed to a UUID that changes on every save — so re-saving the form re-shows the notice to everyone who had dismissed the previous version. When custom colors are enabled the module emits a small inline `<style>` block built from the configured color values. Storage is a single config object, `emergency_notification.settings`; the module ships no entities, no external integrations, and no email/SMS/push delivery — it is purely an on-page banner. Requires only Drupal core.

---

- Show a site-wide closure notice (e.g. "Offices closed due to weather") on every page.
- Announce an ongoing incident or outage affecting the organization.
- Post an urgent public-safety or emergency alert to all visitors.
- Display a temporary "reduced service" or "maintenance window" banner.
- Warn visitors of a scheduled downtime before it happens.
- Broadcast an evacuation or facility-safety message on a campus/venue site.
- Publish a weather-related advisory (storm, flood, heat warning).
- Show a health advisory or public-health notice site-wide.
- Post a high-priority policy or hours change (e.g. altered opening hours).
- Provide a persistent, reopenable alert that visitors can minimize but not fully lose (a fixed reopen button stays at the bottom of the page).
- Present a time-sensitive announcement styled in high-contrast colors to draw attention.
- Suppress the notice on admin pages while showing it to the public (default excludes `/admin/*`).
- Exclude specific sections (e.g. `/checkout/*`, `/node/*`) from the alert using wildcard path patterns.
- Re-notify all visitors of an updated alert by re-saving the form (dismissal state resets via the new UUID).
- Match the alert's colors to a site's brand or to a severity level using the overlay/background/foreground color pickers.
- Provide a rich-text notice with links and formatting via the configured text format.
- Run an announcement banner without installing any contributed dependencies.
- Give editors a simple single-form workflow to turn an emergency notice on or off with one checkbox.
- Localize/theme the popup by overriding the `emergency-notification.html.twig` template.
- Serve the alert as an accessible, dismissible popup with a distinct icon.
- Keep a dismissed alert out of the way while remaining one click from being reopened.
