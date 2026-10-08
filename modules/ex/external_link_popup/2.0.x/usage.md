<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Link Pop-up shows a confirmation dialog when a visitor clicks a link that leaves your site, with configurable text, buttons and per-domain targeting.

---

The module lets you define one or more pop-up configurations (an `external_link_popup` config entity) and attaches them to the page so that clicking an external link opens a jQuery UI dialog (`core/drupal.dialog`) asking the user whether to continue. Each pop-up has a **Show close icon** toggle, a **Title**, a formatted **Body**, **Yes/No** button labels, a **Domains** field (newline-separated top-level domains the pop-up applies to; `domain.com` also matches `*.domain.com`, and `*` matches everything) and an **Open in new tab by default** flag. Pop-ups are checked in **weight order and the first matching domain wins**, so a `*` pop-up placed above others suppresses them. Global settings (`external_link_popup.settings`) hold a **Trusted domains (whitelist)** list that suppresses pop-ups entirely, a **Show on administration pages** toggle, and a default dialog **width**. It ships a permission `administer external link popup`, a settings form at `/admin/config/content/external_link_popup/settings`, and a pop-up collection/CRUD UI at `/admin/config/content/external_link_popup`. On the front end `hook_page_attachments()` passes the enabled pop-ups and settings to `drupalSettings.external_link_popup` and loads the `external_link_popup/dialog` library; a link can be excluded with the CSS class `external-link-popup-disabled`, or forced to a specific pop-up (even for local links) with the `data-external-link-popup-id="<machine name>"` attribute. The JS emits `externalLinkPopup:yes|no|notFound|skipped` events.

---

- Show a "You are now leaving this site" confirmation before visitors follow outbound links.
- Add a legal/compliance interstitial for regulated industries (finance, health, government).
- Warn users that a third-party site is not controlled by your organization.
- Open external links in a new tab after the user confirms.
- Whitelist trusted partner domains so no pop-up appears for them.
- Define different pop-ups with different wording for different external domains.
- Target a pop-up to a specific domain (and its subdomains) via the Domains field.
- Use a catch-all `*` pop-up for every external link on the site.
- Suppress the pop-up on a specific link by adding the `external-link-popup-disabled` class.
- Force a particular pop-up on a chosen link with `data-external-link-popup-id`.
- Apply a pop-up to an internal link too, using the forced-id attribute.
- Order overlapping pop-ups by weight so the most specific one wins.
- Customize the Yes/No button text (e.g. "Continue" / "Stay here").
- Provide a formatted body with rich text via the text-format Body field.
- Show or hide the dialog's close (X) icon per pop-up.
- Control the default dialog width for responsive layouts.
- Allow or prevent pop-ups from appearing on admin pages.
- Restrict who can manage pop-ups with the "administer external link popup" permission.
- Hook into `externalLinkPopup:yes` / `:no` JS events for analytics on exit intent.
- Track skipped (whitelisted) vs shown pop-ups via the `externalLinkPopup:skipped` event.
- Temporarily disable a pop-up without deleting it using the status toggle.
- Style dialogs per pop-up with the `external-link-popup-id-<machine name>` wrapper class.
