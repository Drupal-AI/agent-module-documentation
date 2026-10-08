<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cancel Button adds a Cancel button to entity add/edit forms and sends the user to a sensible place when they click it — the form's own redirect, the `destination` URL parameter, the HTTP referer, the entity's canonical page, or a per-content-type fallback you configure.

---

Editors filling in an entity form often need a way out that isn't "save". Cancel Button injects a Cancel button next to Save and resolves where it should go using a clear precedence: (1) any redirect the form set internally via `FormState::setRedirect()`, (2) the `?destination=` parameter on the URL, (3) the HTTP referer, (4) the entity's canonical view page if it exists, and finally (5) a fallback path you configure per content type on the settings page for the case where the entity does not yet exist (a fresh add form).

The module is administered at `/admin/config/content/cancel-button` behind the `administer cancel button configuration` permission, where the per-bundle fallback destinations are set. The redirect target itself rides on Drupal core's normal redirect handling — the `destination` parameter is sanitised by core to internal paths — so the button does not introduce an open-redirect of its own.

For content teams and any site with heavy entity-form editing, it is a small UX improvement that removes the "how do I get out of this form" friction. The setup task is choosing, per content type, where Cancel should land when there is no better signal.

---

- Add a Cancel button to node edit forms.
- Add a Cancel button to entity add forms.
- Send Cancel to the entity's view page.
- Honor a `?destination=` parameter on Cancel.
- Fall back to the HTTP referer on Cancel.
- Configure a per-content-type cancel destination.
- Give editors a clear way out of a form.
- Cancel back to the content admin listing.
- Respect a form's own redirect on Cancel.
- Handle Cancel on a not-yet-created entity.
- Reduce accidental saves by offering Cancel.
- Add Cancel to a custom entity form.
- Standardize form navigation for editors.
- Set a fallback path for article cancels.
- Set a different fallback for page cancels.
- Improve the content editing experience.
- Gate cancel-button config behind a permission.
- Avoid custom form_alter code for a cancel link.
- Provide consistent cancel behavior site-wide.
- Cancel to the front page when nothing else applies.