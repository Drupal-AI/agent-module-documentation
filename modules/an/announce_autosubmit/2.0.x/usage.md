A11y Announce Form Auto-Submit makes an accessible ARIA-live announcement and restores keyboard focus when a Views exposed-filter form auto-submits.

---

When a Views exposed filter is set to auto-submit, changing a value silently refreshes the results — via AJAX or a full page reload — which leaves screen-reader and keyboard users unaware that anything changed and strips focus from the control they just used. This module, via a single `hook_form_views_exposed_form_alter` plus a small JavaScript behavior built on core's `Drupal.announce()` ARIA-live region, detects that the current page's filter parameters changed from the previous state and announces which filter was applied (or that filters were cleared), then returns focus to the triggering field. It ships no configuration, routes, or permissions — enabling the module is enough, and it activates for every auto-submitting exposed filter form. Core-only, supports Drupal 8 through 11.

---

- Announce accessibly when a Views exposed filter auto-submits.
- Improve accessibility of AJAX-refreshed exposed filter results.
- Improve accessibility of full-page-reload exposed filter submits.
- Tell screen-reader users that the result list has updated.
- Announce the specific filter label that was applied.
- Announce a generic "filters changed and applied" message as fallback.
- Announce when all filters are cleared and defaults are restored.
- Restore keyboard focus to the control that triggered the auto-submit.
- Keep keyboard users from losing their place after a filter change.
- Add WCAG-friendly ARIA-live feedback to faceted/filtered listings.
- Make an auto-submitting search/filter page usable without a mouse.
- Enhance accessibility of a Views listing with exposed filters.
- Provide feedback that is spoken but not visually shown (visually-hidden live region).
- Work with both AJAX-enabled and non-AJAX exposed forms.
- Layer accessibility onto existing Views without template changes.
- Enable per-site with a single `drush en` and no configuration.
- Support catalog/product listings that auto-refresh on filter change.
- Support content admin or search pages driven by exposed filters.
- Meet accessibility audit requirements for auto-submitting filters.
- Reuse core's `Drupal.announce()` announcement region instead of custom markup.
