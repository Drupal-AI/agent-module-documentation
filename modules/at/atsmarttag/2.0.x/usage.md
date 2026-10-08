<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AT Internet SmartTag injects the AT Internet (now Piano Analytics) SmartTag JavaScript tracker into your site's public pages and configures how page views are labelled and how clicks are tracked.

---

The SmartTag library itself can be loaded two ways, selected in configuration: from a remote **URL** (loaded as an external header script) or from an uploaded managed **file** (served locally with aggregation). On every non-admin page `hook_page_attachments()` attaches the tracker plus a `drupalSettings.atsmarttag` payload built from `atsmarttag.settings`: the AT Internet `site` id, collect domains (standard + SSL), secure flag, cookie handling (disable cookie, cookie domain, CNIL exemption), and download/mailto/outbound link tracking options with a large default tracked-extension list. The page name sent to analytics comes from either the current path alias or the resolved page title, and — when enabled — up to three page "chapters" are derived from the breadcrumb trail. Other modules can adjust the payload via the `hook_atsmarttag_settings_alter()` alter hook.

The module adds a single admin settings form at `/admin/config/system/atsmarttag/settings`, gated by its own `administer atsmarttag` permission. It has no anonymous mutating endpoints; the only client-facing effect is the analytics script and settings it emits. Because tracking behaviour (cookies, CNIL exemption) has privacy implications, review the cookie and consent settings for your jurisdiction.

---

- Add AT Internet / Piano Analytics tracking to all public pages.
- Load the SmartTag library from a remote URL.
- Load the SmartTag library from a locally uploaded managed file.
- Set the AT Internet site id used for collection.
- Configure the standard and SSL collection domains.
- Enable secure (HTTPS) collection.
- Disable analytics cookies for privacy compliance.
- Set a custom cookie domain.
- Mark the tag as CNIL-exempt where applicable.
- Use the path alias as the reported page name.
- Use the resolved page title as the reported page name.
- Derive up to three page chapters from the breadcrumb trail.
- Track file downloads by extension.
- Customise the tracked download file-extension list.
- Track mailto link clicks.
- Track outbound link clicks.
- Exclude admin routes from tracking automatically.
- Alter the emitted payload via `hook_atsmarttag_settings_alter()`.
- Restrict configuration to the `administer atsmarttag` permission.
- Attach an extra named library alongside the tracker.