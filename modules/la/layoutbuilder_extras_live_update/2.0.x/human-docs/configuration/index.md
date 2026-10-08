# Configuration

For most sites this module is **install‑and‑go**: once it is enabled and the
required core patch is applied, the live‑update behavior works with no further
setup. It does, however, provide a settings form and its own permission, both
described here.

## The settings form

The module exposes a settings form at the route
`layoutbuilder_extras_live_update.settings_form`, reached from the Layout Builder
administration area. Use it to review the module's options for the live‑update
behavior. If you do not change anything here, the module still works with its
default behavior — live updating of supported section controls (radios, radio,
select, checkbox, and checkboxes).

## Permission

The module defines its own permission governing who may use its Layout Builder
enhancements. Grant it to the roles that build pages with Layout Builder from
**People → Permissions** (`/admin/people/permissions`). Note that Layout Builder's
own access controls still apply on top of this — the module's tweaks only affect the
Layout Builder interface, never what content or access a user has.

## Save

If you change anything on the settings form, click **Save configuration**. Then
open a Layout Builder‑enabled entity and confirm section changes update the preview
live.
