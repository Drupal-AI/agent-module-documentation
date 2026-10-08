<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yunke captcha adds multiple configurable CAPTCHA types to forms.

---

**yunke captcha** protects forms against malicious submissions with several CAPTCHA types (including an image/text CAPTCHA generated server-side with GD). CAPTCHAs are managed as `yunke_captcha` config entities with add/edit/delete/enable/disable admin routes gated by the `yunke_captcha settings` permission (plus entity-access and CSRF tokens on state changes). Public endpoints `/yunke_captcha/{formID}/{pageID}` (refresh) and `/yunke_captcha/image_captcha/{formID}/{pageID}` (image) are gated by `access content` because anonymous form-fillers must fetch the challenge image; they render the session-bound generated CAPTCHA, not arbitrary files. A `yunke_captcha exemption` permission bypasses challenges for trusted users.

Use it to add lightweight self-hosted CAPTCHAs without a third-party service.

---

- Add self-hosted CAPTCHAs to forms.
- Offer multiple CAPTCHA types.
- Generate image/text CAPTCHAs with GD.
- Manage CAPTCHAs as config entities.
- Add/edit/delete CAPTCHA configurations.
- Enable or disable a form's CAPTCHA.
- Serve the CAPTCHA image to anonymous users.
- Refresh the CAPTCHA challenge via a route.
- Bind challenges to the session.
- Exempt trusted users from CAPTCHAs.
- Gate admin routes behind 'yunke_captcha settings'.
- Protect routes with entity access + CSRF.
- Block malicious/automated submissions.
- Avoid third-party CAPTCHA services.
- Configure globally at yunke_captcha.admin.
- Bundle a TTF font for image rendering.
- Provide per-form CAPTCHA settings.
- Reduce form spam without external calls.