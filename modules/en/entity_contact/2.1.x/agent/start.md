<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Contact (entity_contact) — agent index
**Fieldable contact forms + stored, handler-processed submissions.**

- **Version:** 2.1.x
- **Core:** ^10.1 || ^11
- **Depends:** drupal:text
- **Configure:** `entity.entity_contact_form.collection` (/admin/content/entity-contact)
- **Entities:** `entity_contact_form` (config), `entity_contact_message` (content, fieldable)
- **Key services:** `plugin.manager.entity_contact.submission_handler`; `entity_contact_email.mailer` (submodule)
- **Key permissions:** `access entity contact form` (public submit), `administer entity contact forms`, `view/administer entity contact form submissions`, `administer entity contact form settings`
- **Submodules:** entity_contact_email, entity_contact_route, entity_contact_export(_xlsx), entity_contact_search_api

**Security:** public submission route is gated by a dedicated `access entity contact form` permission (not `access content`); flood limit/interval throttles submissions; e-mail recipients are admin-configured static addresses or explicitly-chosen message fields validated with EmailValidator, and subject/body go through the core mail manager — no arbitrary open-relay or obvious header-injection path. Admin/submission routes are permission-gated.

See [configure/forms.md](configure/forms.md).
