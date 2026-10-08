<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lawwwing (project `lawwwinginsert`; module machine name `lawwwing`) injects the Lawwwing cookie-consent widget script into the `<head>` of your pages.

---

You enter a Lawwwing script ID at `/admin/config/lawwwing` (permission `administer lawwwing settings`); the module's `Hooks::insertScript()` (`#[Hook('page_attachments')]`) then attaches a `<script src="https://cdn.lawwwing.com/widgets/current/{script_id}/cookie-widget.min.js" data-lwid="{script_id}">` tag to `html_head`. It does nothing when no script ID is set. Two settings refine where the script loads: `active_in_admin` (whether to include it on admin routes — off by default via an `AdminContext` check) and `allowed_roles` (only inject for users holding one of the selected roles). The result is cached with the `config:lawwwing.settings` cache tag.

The single admin route is permission-gated (`restrict access: true`) and the module makes no server-side external calls — the consent widget is a client-side script from Lawwwing's CDN. Operationally the main considerations are standard for a third-party embed: the CDN domain must be allowed by your CSP, and the role filter means anonymous visitors only get the banner if the "anonymous" role is selected in `allowed_roles`.

---
- Insert the Lawwwing cookie-consent banner site-wide.
- Configure your Lawwwing script ID in the admin UI.
- Show the consent widget only to specific roles.
- Include or exclude the widget on admin pages.
- Comply with GDPR/cookie-consent requirements via Lawwwing.
- Keep the widget off admin routes by default.
- Restrict who can change Lawwwing settings.
- Load the widget from Lawwwing's CDN without custom theming code.
- Add the CDN domain to your Content-Security-Policy.
- Enable the banner for anonymous visitors by selecting that role.
- Disable injection quickly by clearing the script ID.
- Cache-tag the attachment on the Lawwwing config.
- Roll out consent management on a Drupal 10/11/12 site.
- Target the widget to logged-in users only.
- Test the script insertion with the bundled functional tests.
- Centralise consent-script management instead of hard-coding it in a theme.
- Update the Lawwwing ID without touching templates.
