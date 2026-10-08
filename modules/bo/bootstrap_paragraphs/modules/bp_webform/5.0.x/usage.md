<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Webform ships a single config-only Paragraph bundle, `bp_webform`, that lets an editor drop any Webform into a page as a styled content component.

---

This is the thinnest of the Bootstrap Paragraphs submodules: it contains no templates, no CSS, no library, no plugins, no services, no permissions, no Drush commands and no config schema — its entire PHP is a `hook_help()` that prints the README. Installing it imports one paragraph type (`bp_webform`, label "Webform") with three field instances: the shared styling fields `bp_width` and `bp_background` (reusing the parent module's `list_string` storages) and its own storage `paragraph.bp_webform`, a `webform` entity-reference field with `cardinality: 1` provided by the contrib Webform module. That field instance ships with `handler: 'default:webform'`, `target_bundles: null` (any webform may be selected), `auto_create: false`, an empty `default_data`, and `status: open` with blank `open`/`close` dates — the per-reference scheduling controls Webform's field type provides. The default form display uses the `webform_entity_reference_select` widget (a plain select of available webforms) with `bp_background` and `bp_width` as `options_select`, hiding `created`/`status`/`uid`; the default view display renders the reference with `webform_entity_reference_entity_view` and `source_entity: false`, so the embedded form does **not** treat the host node as its submission source entity. Unlike its sibling submodules this one ships its config in `config/install` rather than `config/optional`, which means the config is owned by the module and **is removed when you uninstall it**. Nothing appears to editors until you add an *Entity reference revisions / Paragraphs* field to a content type and allow the `bp_webform` bundle; because it has no template of its own, the paragraph renders through Drupal's generic `paragraph.html.twig` and the `bp_width`/`bp_background` values are printed by the `list_key` formatter rather than being mapped to wrapper classes.

---

- Embed a contact form partway down a long landing page.
- Let editors choose which Webform appears on each page from a dropdown.
- Add a newsletter signup form between two content sections.
- Place an event registration form inside a Bootstrap Paragraphs column layout.
- Build a "Request a demo" section on a product page without a custom block.
- Reuse one Webform across many nodes while positioning it differently on each.
- Add a feedback form to the bottom of documentation pages.
- Give a campaign page a lead-capture form as ordinary editable content.
- Insert a survey into an article without touching the theme.
- Swap the form on a page by editing the paragraph instead of reconfiguring a block.
- Schedule a form open/close window per embed using the field item's `status`/`open`/`close` values.
- Close a form on one page while the same Webform stays open elsewhere.
- Pre-populate fields for one embed only via the field item's `default_data`.
- Set a brand background behind the form with `bp_background: paragraph--color paragraph--color--primary`.
- Constrain the form to a narrow measure with `bp_width: paragraph--width--narrow`.
- Stack several different forms on one page as separate paragraphs.
- Restrict a dedicated paragraphs field to only `bp_webform` for a locked-down page template.
- Keep submissions unattached to the host node by leaving `source_entity: false`.
- Attach submissions to the host node instead by flipping `source_entity` to `true` on the view display.
- Limit which webforms editors may pick by setting `handler_settings.target_bundles`.
- Replace a hard-coded webform block placement with editor-controlled content.
- Add an application form to a job posting content type.
- Put a donation or pledge form inside a nonprofit story page.
- Migrate legacy inline form embeds into structured paragraph content.
- Give a support page a ticket-submission form positioned by the editor.
- Translate the surrounding paragraph while sharing one underlying Webform.
- A/B two different forms on similar pages by picking a different webform per paragraph.
