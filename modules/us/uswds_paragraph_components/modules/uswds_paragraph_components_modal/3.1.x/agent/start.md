# USWDS Modal — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Installs one USWDS modal
paragraph type. No settings page, no permissions. Hooks in
`src/Hook/UswdsParagraphComponentsModalHooks.php`.

## Paragraph type & fields (config/optional)

**`uswds_modal`** (expose this):
- `field_modal_title` — dialog heading.
- `field_modal_body` — dialog body (rendered via `{{ content.field_modal_body }}`).
- `field_button_text` — trigger label.
- `field_display_as_button` (bool) — trigger as `usa-button` (true) vs unstyled link (false).
- `field_large_modal` (bool) → `usa-modal--lg`.
- `field_force_action` (bool) → `data-force-action`; hides the X close (footer choice required).
- `field_modal_yes_button_text` / `field_modal_no_button_text` — footer labels (default translated
  "Yes" / "No").

## Rendering & assets

Theme hook `paragraph__uswds_modal` → `templates/paragraph--uswds-modal.html.twig`. Emits a trigger
`<a … data-open-modal aria-controls="paragraph--id--N">` plus a `<div class="usa-modal" id="…"
aria-labelledby aria-describedby [data-force-action]>` with `usa-modal__heading`, `usa-prose` body and
a `usa-button-group` footer (Yes/No `data-close-modal` buttons). Open/close is driven by USWDS JS from
your theme. CSS shim `uswds_paragraph_components_modal/uswds-modal` attached when `view_mode !==
'preview'`.

**Gotcha:** the close-button SVG uses a hard-coded sprite path
`/modules/contrib/uswds_paragraph_components/components/modal/sprite.svg#close`; if the module lives
elsewhere the icon 404s (cosmetic, not security).
