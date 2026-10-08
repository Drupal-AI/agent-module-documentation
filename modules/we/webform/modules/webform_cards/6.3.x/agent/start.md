# webform_cards — agent start

Adds a **`webform_card`** container element (WebformElement plugin in `src/Plugin/WebformElement/`)
for fast **client-side** multistep pagination. Requires `webform`,
`webform_clientside_validation`, and core `inline_form_errors`.

- Add a "Card" container in the Webform build UI (or YAML `'#type': webform_card`); each card is a
  step navigated with JS — no page reload, no server post until final submit.
- Per-card client-side validation gates advancing; Inline Form Errors gives accessible messages.
- Reuses Webform's progress bar/tracker; supports `#states` conditional logic to skip/reveal cards.
- Config schema in `config/schema/`; behavior settings live on the form and the card element.
- Use instead of server-side `webform_wizard_page` when instant stepping / low drop-off matters.
