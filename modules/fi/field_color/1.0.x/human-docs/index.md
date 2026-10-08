# Field Color — manual setup guide

**Field Color** (`field_color`) adds a **color‑picker field type** to Drupal. Add
it to any bundle and editors can store a color value chosen from a visual picker,
which is perfect for per‑entity theming — a brand color on a category, a background
on a card, an accent on a landing page.

The widget is built on the **Spectrum Colorpicker** jQuery plugin (v2.0.0), and
most of its options are exposed so you can customise the picker's behaviour on the
field's *Manage form display*. It is a fields feature — it stores a color value and
has no content or access role.

> **A note on output:** if you emit a stored color into inline CSS somewhere,
> output it safely — validate that the value really is a color before injecting it
> into a stylesheet or `style` attribute.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — you add the field and tune its picker per
bundle, as described in "How to use it" below.

## How to use it

1. Go to the bundle you want, e.g. **Structure → Content types → (your type) →
   Manage fields**, and click **Add field**.
2. Choose the **Color** field type, give it a label, and save the field settings.
3. On the bundle's **Manage form display**, select the color‑picker widget for the
   field and use its settings to customise the Spectrum picker (the plugin's
   options are available here — see the
   [Spectrum documentation](https://seballot.github.io/spectrum/) for what each
   does).
4. Optionally set how the value is shown on **Manage display**.
5. **Save.** Editors now get a color picker on the field, and the chosen color is
   stored with the entity.
