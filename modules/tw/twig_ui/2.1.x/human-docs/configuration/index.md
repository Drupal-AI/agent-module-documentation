# Configuration

Twig UI Templates has two admin areas: the **templates** screen where you author
overrides, and a **global settings** form that governs which themes editors may
target and the optional code‑editor behaviour.

> **Reminder — this is a trusted tool.** Everything on this page lets you write Twig
> that the site renders. Only grant the **Administer Twig templates** permission to
> people you'd trust with theme or Git access. See
> [Installation](../installation/index.md#grant-the-permissions--carefully).

## Managing templates

Go to **Structure → Twig templates** (`/admin/structure/templates`). You'll see a
list of your templates with **Edit**, **Clone**, **Delete**, and enable/disable
actions. Choose **Add template** to create one.

### The template form, field by field

- **Label** — a human‑friendly admin name for the template (for example "Article
  override"). It's just for the list; it doesn't affect rendering.
- **Machine name** — the internal id, generated from the label. It's the `<id>` in
  the stored configuration name.
- **Theme suggestion** — the theme hook or suggestion this template overrides,
  written with underscores. Examples: `page__front`, `node__article`, `block`. This
  is what ties your template to a specific piece of Drupal's output.
- **Template code** — the raw Twig that gets written to the `.html.twig` file. If
  **CodeMirror Editor** is installed, this field has syntax highlighting and line
  numbers. There's also a helper (if you have the *Load Twig templates from file
  system* permission) to load an existing file‑based template's code as a starting
  point.
- **Themes** — one or more themes the template applies to (for example *Olivero*,
  or an admin theme like *Claro*). You can target several themes at once. Which
  themes appear here is governed by the global settings below.
- **Status (Enabled)** — only **enabled** templates write a file and override
  anything. Disable a template to temporarily fall back to the original
  file‑based template without deleting your work.

### One override per suggestion + theme

The form enforces that only **one enabled** template may exist for a given theme
suggestion within a given theme. If you try to enable a second template that
targets the same suggestion and theme, you'll get a validation error on the Themes
field. This keeps overrides unambiguous.

### Cloning

The **Clone** action copies an existing template as a starting point: it prefixes
the label with "Clone of", gives it a new machine name, and clears the Themes
selection so you must deliberately re‑pick which themes it applies to.

### Saving takes effect immediately

Saving, disabling, or deleting a template flushes caches and rebuilds Drupal so the
change is live right away — handy for iterating on markup, and the reason this can
serve as an emergency, hotfix‑style way to adjust output when a full code deploy
isn't possible.

## Global settings

Go to **Configuration → System → Twig UI Templates** (`/admin/config/system/twig_ui`).
This form needs the **Administer Twig UI templates settings** permission and
controls:

- **Allowed themes** — whether the template form offers **every** active theme, or
  only a **selected** list. Choose *selected* to restrict which themes editors may
  target.
- **Allowed theme list** — when *Allowed themes* is set to *selected*, the specific
  themes that are offered.
- **Default selected themes** — the themes that are pre‑checked on the **new**
  template form, so authors don't have to pick them every time.
- **CodeMirror configuration** — a YAML field passed to the CodeMirror editor when
  the **CodeMirror Editor** module is installed (for example to turn line numbers on
  or off). It has no effect if CodeMirror isn't installed.

Save the form to apply your changes.

## Managing templates as configuration

Because each template is a configuration entity (named `twig_ui.template.<id>`) and
the settings live in `twig_ui.settings`, both export and import with your normal
config workflow (`drush cex` / `drush cim`). That means you can develop template
overrides on one environment and ship them to another, keeping your presentation
overrides in version control instead of scattered across theme files.
