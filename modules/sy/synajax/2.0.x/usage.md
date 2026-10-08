<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynAjax requires contact forms to be submitted via AJAX (JavaScript), rejecting direct POSTs as a lightweight spam-control measure.

---

SynAjax (2.0.x, core `^11 || ^12`) targets Drupal's core Contact module. When a contact form already submits
through AJAX, SynAjax's `hook_form_contact_message_form_alter()` appends a validate callback that fails
submission unless the request carries Drupal's `_drupal_ajax` flag — so a bot that POSTs the form directly
(without running JavaScript) is rejected. Coverage is chosen at the settings form (`synajax.config`,
`/admin/config/content/synajax`, permission `administer site configuration`): a per-entity display mode of
`disable`, `all`, or `custom` (a checkbox list of specific contact-form bundles). Settings are stored in the
`synajax.settings` config object. It is in the Spam control package and provides no permissions, services,
plugins, or Drush commands.

Note the usual caveats of JS-requirement spam control: it stops naive scripts that don't execute JavaScript,
but not headless-browser or determined spammers that do; and requiring JS can affect legitimate no-JS clients
(accessibility). Use it as one layer and pair it with CAPTCHA/honeypot/flood control where stronger protection
is needed. It has no access-control role.

---

- Require AJAX-only submission on contact forms.
- Block naive bots that POST contact forms directly.
- Enforce JavaScript to submit a contact message.
- Apply the requirement to all contact form bundles.
- Apply the requirement to a custom subset of contact bundles.
- Disable the requirement per entity type via the settings form.
- Configure at `synajax.config` (`/admin/config/content/synajax`).
- Reject submissions missing the `_drupal_ajax` request flag.
- Add lightweight spam control without external services.
- Reduce contact-form spam volume.
- Layer alongside CAPTCHA or honeypot modules.
- Understand it stops only naive, non-JS bots.
- Understand determined/headless bots can still pass.
- Weigh the no-JS accessibility impact before enabling.
- Manage anti-spam scope from a single admin form.
- Store configuration in `synajax.settings`.
- Operate with no added permissions (uses `administer site configuration`).
- Keep contact forms usable while filtering direct-POST spam.
- Enable only for the contact bundles that receive spam.
- Use as a defense-in-depth measure, not a sole control.
