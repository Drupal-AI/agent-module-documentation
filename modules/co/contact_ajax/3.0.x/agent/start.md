<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Ajax (contact_ajax) — agent index

AJAX-ifies Drupal core Contact forms. Version 3.x targets `core_version_requirement: ^11 || ^12`. Pure procedural module: it works entirely through form alters and third-party settings on the `contact.form.*` config entity — no routes, services, permissions, plugins, install hooks, or drush commands of its own.

- Machine name: `contact_ajax`; package: Contact; license: GPL-2.0-or-later.
- Dependency: `drupal:contact` (core). No composer requirements. Optional integration: Views (`views/views.ajax` library + scroll-to when the module is present). Suggested: contact_storage, honeypot.
- Provides config schema: `contact.form.*.third_party.contact_ajax` (`config/schema/contact_ajax.schema.yml`).

## What it provides (all in `contact_ajax.module`)

- `contact_ajax_form_contact_form_form_alter()` — adds the "Contact ajax" fieldset to the contact-form edit form (`admin/structure/contact`) and registers the entity builder.
- `contact_ajax_contact_form_form_builder()` — entity builder that saves the third-party settings onto the `ContactForm` entity.
- `contact_ajax_form_contact_message_form_alter()` — on the front-end message form, when AJAX is enabled, wraps the form and attaches an `#ajax` submit callback.
- `contact_ajax_contact_site_form_ajax_callback()` — the `#ajax` callback; returns an `AjaxResponse` with the configured post-submit content.
- Constants: `CONTACT_AJAX_LOAD_DEFAULT_MESSAGE` (1), `CONTACT_AJAX_LOAD_FROM_URI` (2), `CONTACT_AJAX_LOAD_FROM_MESSAGE` (3), `CONTACT_AJAX_LOAD_CLEAN_FORM` (4), `CONTACT_AJAX_PREFIX` (`contact_ajax_`).

## Solution docs

- [Configuration & AJAX behavior](config/settings.md) — third-party settings, confirmation types, wrapper/render-selector options, and the callback flow.
