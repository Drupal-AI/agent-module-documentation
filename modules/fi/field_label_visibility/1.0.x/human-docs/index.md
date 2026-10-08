# Field Label Visibility — manual setup guide

**Field Label Visibility** (`field_label_visibility`) lets a site builder control
how a field's label is rendered **on the entity edit form** — hide it entirely,
give it custom text, wrap it in an inline tag, or add CSS classes and an id — all
from **Manage form display**, with no theme overrides, no custom code, and no
`hook_form_alter()`. Unlike the display-management tools, it works on the *form*
widget label, not on the front-end rendering of an entity.

It is aimed at cleaning up busy edit forms: sometimes a field's purpose is obvious
from its placement or help text and its label just adds clutter, and sometimes you
want the label styled or reworded for editors. This module exposes all of that as
UI controls on each widget's settings panel. It depends on core's **Field** and
**Node** modules and supports Drupal 10.3 and 11.

The controls are opt-in in two steps: first you pick, on a small settings page,
*which content types* should expose the per-widget controls; then you configure
each field's label on that content type's **Manage form display**. The settings
page is protected by an **Administer Field Label Visibility** permission that is
restricted by default.

A note on how it behaves: for the "Hide" mode the module sets Drupal's
`#title_display` to `none`, which removes the label from the page while keeping the
input's accessible name intact — the accessibility of the form is preserved in
every mode. Custom classes, ids and wrapper tags are validated and restricted to a
safe allowlist (`span`, `small`, `mark`), and label text is escaped, so the
feature does not open an HTML-injection hole.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types expose the
   controls, then configure each field's label on Manage form display.

## Where it lives in the admin menu

The module's settings page sits at **Configuration → User interface → Field Label
Visibility** (`/admin/config/user-interface/field-label-visibility`). The
per-field controls themselves live on each content type's **Structure → Content
types → *(type)* → Manage form display** screen.
