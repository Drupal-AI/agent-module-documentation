# Configuration

The base Flags module has no settings form of its own. Its main configuration is
the set of **code‑to‑flag mapping overrides**, which you manage through the
**Flags: UI** (`flags_ui`) submodule. Field and language‑switcher settings live on
the relevant field's display tabs and come from the field submodules.

## Managing mapping overrides (Flags: UI)

By default, Flags shows the flag whose code matches the country or language code.
A mapping override lets you point one code at a *different* territory's flag — for
example, showing the GB flag for the English language, or the US flag instead.

1. Enable the **Flags: UI** submodule (`drush en flags_ui -y`).
2. Grant the **Administer flag mapping** (`administer flag mapping`) permission at
   **People → Permissions** to the roles that should manage flags.
3. Use the Flags UI admin screens to add mapping overrides. There are two kinds,
   corresponding to the two mapping config entities:
   - **Country flag mappings** — remap a country code to a different flag.
   - **Language flag mappings** — remap a language code to a different flag/
     territory (this is the common case, for locales whose language code differs
     from the flag/territory code).

Each override simply stores a **source** code (the code you're remapping) and a
**flag** code (the target flag to show). Because they are configuration entities,
overrides export and import between environments with the rest of your site
configuration.

Once an override exists, every place that renders that code — the theme hook, field
formatters, the language switcher — uses the overridden flag automatically.

## Field and language‑switcher display settings

These are not on a central Flags page; they live where you'd expect on each field:

- **Country / language field flags** — after enabling **Flags: Country** or
  **Flags: Language**, set the Flags formatter on the field's **Manage display**
  tab. The formatter's output‑format setting controls whether the flag appears
  **before**, **after**, or **instead of** the label. Choose the matching widget on
  **Manage form display** (the flag‑decorated select widgets need the Select Icons
  module).
- **Language switcher flags** — provided by **Flags: Language**; once enabled, the
  core language switcher block and its links render with flags.
