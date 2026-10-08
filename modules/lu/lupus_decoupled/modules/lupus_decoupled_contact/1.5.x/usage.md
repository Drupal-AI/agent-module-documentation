<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Contact exposes Drupal's core contact forms to the front end.

---

Core's contact module covers the common case — a site contact form, and personal contact forms between users — with flood control and a recipient configuration that lives in Drupal. A decoupled site still needs that form, and rebuilding it in the front end means rebuilding the flood control and moving the recipient list into front-end configuration where the people who own it cannot reach it.

This submodule renders contact forms as custom elements so the front end presents them and Drupal sends the mail. Recipients stay configurable in Drupal, flood control still applies, and mail goes through whatever mail system the site already uses.

The thing to verify at launch is that mail actually sends from the decoupled setup — a contact form that silently fails is the classic launch defect, and it is invisible from the front end because the submission looks successful. Send a test through the real path, and check whether the site has anything monitoring mail delivery.

---

- Expose a site contact form to the front end.
- Let visitors contact a site from Nuxt.
- Keep recipient configuration in Drupal.
- Preserve core's contact flood control.
- Send contact mail through the site's mail system.
- Support personal contact forms.
- Style the contact form in the front end.
- Handle validation errors from Drupal.
- Verify mail actually sends before launch.
- Monitor contact form delivery.
- Avoid reimplementing a contact endpoint.
- Restrict who may be contacted.
- Protect the form against spam.
- Debug a submission that produced no email.
- Keep contact configuration with the site owners.