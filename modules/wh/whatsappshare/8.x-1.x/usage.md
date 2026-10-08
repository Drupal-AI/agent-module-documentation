<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Whatsappshare adds a configurable WhatsApp share button to the site.

---

**Whatsappshare** attaches a WhatsApp share button/link to pages via `hook_preprocess_html`, passing the current page URL and admin-configured button text/size/sharing-text/location to a JS library through `drupalSettings`. Settings live at `/admin/config/whatsappshare` behind the core `access administration pages` permission. All rendered values are admin-configured and passed as JSON (drupalSettings), so there is no untrusted-input rendering.

Use it to let visitors share the current page to WhatsApp on desktop or mobile.

---

- Add a WhatsApp share button to pages.
- Let visitors share the current page URL to WhatsApp.
- Configure button text and size.
- Configure the pre-filled sharing text.
- Choose the button's screen location.
- Attach the button site-wide via page attachments.
- Pass settings to JS via drupalSettings.
- Support desktop and mobile WhatsApp sharing.
- Configure at /admin/config/whatsappshare.
- Gate settings behind 'access administration pages'.
- Encourage social sharing of content.
- Share the current request URI.
- Style the button via a bundled library.
- Avoid third-party sharing scripts.
- Show a floating share link.
- Increase content reach on WhatsApp.
- Set sharing text per site.
- Enable one-click WhatsApp sharing.