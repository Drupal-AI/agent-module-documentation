<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Contact Form (`bp_contact`) — agent index

Submodule of **bootstrap_paragraphs** 5.0.x.

> **⚠ NOT DRUPAL 11 COMPATIBLE.** `bp_contact.info.yml` declares
> `core_version_requirement: ^8 || ^9 || ^10`, and it depends on the contrib module
> **`contact_formatter`**, which does not ship with `bootstrap_paragraphs`. On a D11 site
> `drush en bp_contact` fails with
> *"Unable to install modules: module 'bp_contact' is missing its dependency module
> contact_formatter."* These docs are read from the shipped source, not from a running
> install. On D11 use `bp_webform`, or recreate the bundle by hand (see the configure doc).

Ships **one Paragraph bundle** (`bp_contact`, label "Contact Form") + 3 fields. **No PHP
classes, no services, no plugins, no permissions, no Drush, no config schema, no Twig
template, no CSS, `configure: null`.** `bp_contact.module` implements only `hook_help()`.

- **Bundle id, its 3 fields, the `contact_formatter` view-display wiring, and how to
  recreate it on D11** → [configure/contact-bundle.md](configure/contact-bundle.md)

Key facts:

- Config lives in **`config/install/`** (a hard install requirement), not `config/optional/`
  like every sibling bundle.
- **Own storage:** `bp_contact` — `entity_reference` → core's **`contact_form`** config
  entity, cardinality 1, `handler: 'default:contact_form'`, `target_bundles: null`.
- **Shared with the parent module:** `bp_background`, `bp_width`.
- The view display renders `bp_contact` with the **`contact_field_formatter`** formatter from
  `contact_formatter` — that is the only reason that module is required.
