# LC Color Picker — manual setup guide

**LC Color Picker** (`lc_color_picker`) brings a modern JavaScript color picker to
Drupal as a field. It integrates the LC Color Picker library and lets editors
choose **solid colors, linear gradients, and radial gradients** right from the UI.
Rather than being a site-wide setting, it works as a Drupal field: install it, add
a color field to an entity, and editors get a proper visual picker instead of
typing hex codes by hand.

The module supplies the whole trio a color field needs: a **field type** (to store
the value), a **formatter** (to render it), and a **configurable widget** (the
picker itself, set up per field). It works on Drupal 10 and 11. The current
release is a **beta** (`1.0.0-beta1`), so test before relying on it in
production. One thing to keep in mind: a stored color is meant to be emitted as a
sanitized style value wherever it is used in output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no global configuration page** — there is no settings form. You
set it up per field, on a bundle's *Manage fields* and *Manage form display*, as
described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). You use LC Color Picker
entirely from **Structure → (content type / other entity) → Manage fields** and
**Manage form display**, where its field type and widget become available.

## How to use it

1. Enable the module.
2. On the entity you want (a content type, paragraph, block type, and so on), go
   to **Manage fields → Add field** and choose the LC Color Picker **field type**.
3. On **Manage form display**, confirm the field uses the LC Color Picker
   **widget**, and adjust the widget's settings — the widget is configurable, so
   this is where you tune how the picker behaves for editors.
4. On **Manage display**, set the field's **formatter** to control how the stored
   color is rendered.
5. Edit content of that bundle — the field now shows the visual color picker,
   supporting solid, linear-gradient, and radial-gradient selections.
