# Configuration

UI Skins has no single settings form — it adds screens that are **derived per
theme**. Everything here is gated by core's **Administer themes** permission, so
log in as an administrator (or a role that has it) before you start.

## The CSS variables overview

Go to **Appearance → CSS variables** (`/admin/appearance/css-variables`). This
page lists every installed theme. A theme is only clickable through to a settings
screen if it declares at least one CSS variable plugin; themes with none simply
won't have a screen to open.

## Editing a theme's CSS variables

Open **Appearance → CSS variables → {theme}**
(`/admin/appearance/css-variables/{theme}`). This is the
`CssVariablesThemeSettingsForm`. What you see depends entirely on the variables
your theme declared:

- **Grouped tabs.** If the variables use more than one `category`, they render as
  vertical tabs (Colors, Spacing, and so on). With a single group, there are no
  tabs.
- **One row per scope.** Each variable can hold different values for different
  **scopes**, where a scope is just a CSS selector (`:root`, `.dark`, `body`).
  Every scope shows a **Scope** field (the selector) next to a **Value** field
  whose widget matches the variable's declared `type` — a plain textfield, a
  color picker, or the module's **alpha color** picker (a color swatch plus a
  0–255 alpha number, stored as an 8‑digit `#rrggbbaa` hex string).
- **Default scopes are locked.** Scopes that came from the plugin's
  `default_values` show as disabled rows so you can see the baseline. To override
  a value for a new selector, use **Add new scope** — it appends an editable row
  via AJAX where you type both the selector and the value.

Click **Save configuration**. Two things happen on save that are worth knowing:
empty‑scope rows are dropped, and any value that still equals the plugin's
default is **not** stored — config only records real overrides. That also means
the way to "reset" a variable is simply to set it back to its default value.

## Choosing a skin (theme preset)

The skin selector lives on the theme's own settings form, not the CSS variables
screen. Go to **Appearance → Settings → {theme}**
(`/admin/appearance/settings/{theme}`). UI Skins adds a **Theme** select whose
options are the skins (`ui_skins.themes` plugins) declared for that theme. Pick
one and save; from then on the module merges that skin's attribute (usually a
`class`) onto the `<body>` or `<html>` element on every page, pulls in any
library the skin attaches, and applies any skins it depends on first.

## Where the values are stored

Nothing is written to a `ui_skins.*` config object. Instead, both the selected
skin and the variable overrides are saved into the **theme's own** settings
config (`{theme}.settings`) under a third‑party settings key named `ui_skins`.
Because it lives in the theme's config, your customizations are exportable and
deployable like any other configuration. (Internally, dots in scope selectors are
encoded as `%` for storage — you don't need to do anything about that, but it
explains why the raw config shows `:%root` rather than `:root`.)

## A note on trust

The variable values you enter here are concatenated verbatim into the inline
`<style>` block the module prints on every page — there is no CSS escaping. That
is by design: only holders of the **Administer themes** permission can reach this
form, and that is already a trusted, restricted permission. Treat it accordingly
and don't hand **Administer themes** to roles you wouldn't trust to inject CSS.
