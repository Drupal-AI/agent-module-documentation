# shs_chosen — agent start

Submodule of **shs**. Adds the Chosen jQuery plugin to the SHS cascading dropdowns, giving each
level a searchable, styled Chosen box. Provides the `options_shs_chosen` field widget (extends
`options_shs`) and Chosen-aware Views filter overrides. Requires `shs` **and** `chosen`. No admin
UI (no `configure` route) — configured per field. Part of project: `shs`.

- Enable the Chosen widget, its settings, and global-vs-per-field Chosen config →
  [configure/shs_chosen.md](configure/shs_chosen.md)
- Library, Backbone view overrides, and how the Chosen styling is applied →
  [theming/shs_chosen.md](theming/shs_chosen.md)
