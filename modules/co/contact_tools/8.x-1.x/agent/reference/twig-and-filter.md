<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig functions and text filter

## Twig functions (`src/Twig/Extension/Extensions.php`)

Registered by the `contact_tools.twig_extension` service; each delegates to the `contact_tools`
service.

- `contact_form(contact_form_id = 'default_form', form_state_additions = {})` → `getForm()` — embeds
  a plain contact form.
- `contact_form_ajax(contact_form_id = 'default_form', form_state_additions = {})` → `getFormAjax()`
  — embeds an AJAX-enabled contact form.
- `contact_modal(link_title, contact_form, link_options = {})` → `createModalLink()` — a link that
  opens the form in a modal (form loaded from the canonical route, no AJAX submit).
- `contact_modal_ajax(link_title, contact_form, link_options = {})` → `createModalLinkAjax()` — a
  link that opens the form in a modal loaded from the AJAX route, with AJAX submit.

Example:

```twig
{{ contact_form_ajax('feedback') }}
{{ contact_modal_ajax('Contact us'|t, 'feedback') }}
```

## Text filter `contact_tools_modal_link` (`src/Plugin/Filter/ModalLinkFilter.php`)

Type `TYPE_TRANSFORM_REVERSIBLE`. Enable it on a text format; it post-processes authored HTML and
upgrades any `<a>` whose `href` contains `/contact-tools/` into a modal AJAX link:

- attaches `core/drupal.dialog.ajax`;
- adds `use-ajax` to the class list if absent;
- sets `data-dialog-type=modal` if not already set;
- fills `data-dialog-options` (defaults `{width:'auto', dialogClass:'contact-tools-modal'}`, or
  fills missing `width`/`dialogClass` on an existing options object), after running
  `hook_contact_tools_modal_link_options_alter()` with context `{type: 'filter_link'}`.

So an author writes `<a href="/contact-tools/feedback">Contact</a>` and the filter turns it into a
modal-opening link. The filter parses via `DOMDocument` and strips the wrapper
`<!DOCTYPE>/<html>/<body>` tags DOMDocument adds. Because it is reversible, the stored source keeps
the plain link.
