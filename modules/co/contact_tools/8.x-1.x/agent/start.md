<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Tools — agent index

info.yml name **"Contact Tools"** (`contact_tools`), version **8.x-1.4**, core `^9 || ^10 || ^11`.
Depends only on core `contact`. A developer toolkit (no admin UI, no settings page, no permissions
of its own) for rendering and embedding **core Contact forms**, with on-demand **AJAX** support so a
contact form can load and submit inside a modal without a full page reload.

The forms rendered are ordinary core `contact_form` config entities producing `contact_message`
entities; Contact Tools adds the AJAX plumbing, a service, Twig functions, a text filter, and alter
hooks around them. It does not add its own access layer — the AJAX render route is gated by core
`contact_form.view` entity access.

## What it ships

- **PHP service `contact_tools`** — render a form (AJAX or not) and build modal links →
  [reference/service.md](reference/service.md)
- **AJAX render route + submit handler** — `/contact-tools/{contact_form}` and the shared AJAX
  submit callback → [reference/service.md](reference/service.md)
- **Twig functions** — `contact_form`, `contact_form_ajax`, `contact_modal`, `contact_modal_ajax` →
  [reference/twig-and-filter.md](reference/twig-and-filter.md)
- **Text filter `contact_tools_modal_link`** — upgrades `href="/contact-tools/…"` links to modal
  AJAX links → [reference/twig-and-filter.md](reference/twig-and-filter.md)
- **Alter hooks** — modal link options + AJAX response → [reference/hooks.md](reference/hooks.md)

## Key facts

- Service id `contact_tools`, class `src/Service/ContactTools.php`, constructor args
  `entity_type.manager`, `entity.form_builder`, `module_handler`.
- Route `contact_tools.contact_form_ajax.page` path `/contact-tools/{contact_form}`, controller
  `ContactToolsPageController::contactPageAjax`, requirement `_entity_access: 'contact_form.view'`
  (per-form access is enforced; `{contact_form}` is upcast to the config entity).
- AJAX is switched on by putting `['contact_tools' => ['is_ajax' => TRUE]]` into the form state;
  `hook_form_contact_message_form_alter()` then attaches an `#ajax` callback to the submit button.
- The shared submit callback `contact_tools_ajax_submit_handler()` rebuilds the form and returns an
  `AjaxResponse` that focuses and `ReplaceCommand`-replaces the form wrapper (a processed class
  `<form_id>-contact-tools-processed`), plus a `status_messages` element for errors/status.
- No config schema, no permissions, no Drush commands, no submodules, no block plugins, no libraries
  of its own (it attaches core `core/drupal.dialog.ajax`).
- `hook_robotstxt()` disallows `/contact-tools` for crawlers; `hook_help()` renders README.md.

See also the upstream author docs in the module's `docs/` (readthedocs source).
