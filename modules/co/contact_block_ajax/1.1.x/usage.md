<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Block AJAX provides blocks that load Contact forms via AJAX (lazy loading).

---

Contact Block AJAX **provides blocks that load Contact forms with AJAX** — placing a core Contact form in a
block that loads lazily via AJAX, improving initial page-load performance. It depends on core Block and Contact,
provides its own permissions.

Use it to lazy-load contact forms in blocks. It is a content-display/performance feature; the contact form follows
core Contact's access/spam handling and it has no access-control role beyond its permission. Place the AJAX contact
block.

---

- Defer a contact form until it scrolls into view (Intersection Observer) to cut initial page weight.
- Place one or more Contact Block AJAX blocks, each bound to a chosen contact form and form-display mode.
- Submit the form via AJAX (no full page reload); errors re-render the form in place.
- Support both site-wide and personal (`/user/*`) contact forms, with access checked per form on load.
- Optionally rate-limit the AJAX load endpoint by client IP via the Flood API (Configuration → People →
  Form load rate limit; default 30 loads / 5 minutes, disabled out of the box).
- Integrate with anti-spam modules (CAPTCHA, reCAPTCHA, Honeypot) and, with limitations, the
  contact_ajax module.
- Override the `contact-block-ajax.html.twig` template or tune `drupalSettings.contactBlockAjax`
  (threshold, rootMargin) to customise loading behaviour.
