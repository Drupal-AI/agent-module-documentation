# Configuration

Fences has two layers: the **per‑field settings** (where almost all the work happens)
and a tiny **global settings form**.

## Per‑field wrapper markup (the main thing)

1. Log in as a user with the **Edit fences formatter settings** permission (without it
   the Fences section is hidden).
2. Go to **Structure → Content types → *your type* → Manage display** — the display
   config, not the form display. (Any entity type's Manage display works.)
3. Click the **gear** on the field row you want to change, then open the collapsible
   **Fences** section.
4. For each of the four wrappers, choose an HTML tag (or **none** to omit that wrapper),
   and optionally type CSS classes.
5. Click **Update**, then **Save** at the bottom of the page.

### The four wrappers

| Wrapper | Controls | Default tag |
|---------|----------|-------------|
| **Field tag** | the element around the whole field | `div` |
| **Label tag** | the element around the field's label | `div` |
| **Items wrapper tag** | an optional element around *all* the field's items | `none` (no wrapper) |
| **Item tag** | the element around *each* individual item | `div` |

Each wrapper also has a **classes** box for a space‑separated list of CSS classes. A
classes box is ignored (and hidden) when its tag is set to **none**, since there is no
element to put them on.

Some worked examples:

- Give a field a `<section>` wrapper and an `<h3>` label for better semantics.
- Turn a multi‑value field into a real list: items wrapper `ul`, item tag `li`.
- Strip all markup from a field so only the raw value prints: set every tag to `none`.
- Render an address field inside `<address>`, a quote inside `<blockquote>`, or a code
  field as `<pre><code>`.

Because each view mode is configured separately, you can give the same field different
markup in *teaser* versus *full*. The standard core field classes (`field`,
`field--name-…`, `field--type-…`) are still applied to whatever field tag you choose, so
existing CSS keeps working. To remove Fences from a field, set its wrappers back to the
defaults (or remove the Fences settings) — the field falls back to core's `<div>`
markup.

## Global settings form

At **Configuration → User interface → Fences → Settings**
(`/admin/config/user-interface/fences/settings`), guarded by the **Administer fences
settings** permission, there is one option:

- **Override field template in all themes** — off by default. While off, Fences only
  replaces the field template when core provided it, leaving themes that ship their own
  `field.html.twig` untouched. Turn it **on** to force Fences' template even over a
  theme's own. After changing it, run `drush cr`.

## Presets (optional)

If you enabled the **Fences Presets** submodule, each field's Fences section also offers
a preset selector, letting you apply a named bundle of tags (Inline, None, …) in one
click instead of setting each wrapper individually.

## Permissions

- **Edit fences formatter settings** — required to see and edit the per‑field Fences
  section on Manage display.
- **Administer fences settings** — required for the global settings form.
