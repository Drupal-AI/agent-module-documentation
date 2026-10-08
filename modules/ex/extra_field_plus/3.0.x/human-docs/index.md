# Extra Field Plus — manual setup guide

**Extra Field Plus: Extra Field Settings Provider** (`extra_field_plus`) is a
developer-focused companion to the **Extra Field** module. Extra Field lets you
define "extra fields" — pseudo-fields rendered from code, like a computed
"related items count" or a formatted title — and place them on an entity's
**Manage display**. But plain extra fields have no settings: they render the same
everywhere. Extra Field Plus adds the missing layer, giving each extra field its
own editable **display settings form** — the little cog on Manage display, exactly
like a real field formatter has.

For a site builder, that means an extra field can be configured differently per
view mode (say a wrapper tag or heading level in the full view but not the
teaser), with a settings summary shown next to it, and the chosen values saved
into the display configuration so they deploy like any other config. It supports
**Layout Builder** too, storing settings on the section component. For a
developer, it provides an interface and two base plugin classes to extend —
`ExtraFieldPlusDisplayBase` (raw output) and `ExtraFieldPlusDisplayFormattedBase`
(wrapped in the standard field template) — where you implement a couple of static
methods to declare the settings form and its defaults, then read those values back
at render time.

There is **no module settings page** and no permissions of its own. You use it by
writing plugins in code and configuring them on Manage display. A handy report at
**Reports → Extra Field Plugins List** lists every discovered extra-field plugin
so you can confirm yours registered. It depends on core's **Field** module and the
contributed **Extra Field** module, and ships an example submodule you can copy as
a starting point.

> **Version note:** Extra Field Plus 3.x renamed the plugin methods. The old
> `settingsForm()` / `defaultFormValues()` are deprecated in favor of the static
> `extraFieldSettingsForm()` / `defaultExtraFieldSettings()` — see the module's
> `UPGRADE.md` if you're migrating older plugins.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including Extra
   Field) and enable the module.

## Where it lives in the admin menu

There is no settings page. Two places are relevant:

- **Manage display** on any entity bundle (for example **Structure → Content types
  → *(type)* → Manage display**) — where an extra field's cog and settings form
  appear once you've defined a plugin.
- **Reports → Extra Field Plugins List**
  (`/admin/reports/extra_fields`) — a read-only report of all discovered
  extra-field plugins.

## How to use it

This is a tool for developers building custom pseudo-fields; there is nothing to
configure globally. The workflow:

1. **Write a plugin.** In your own module, create a plugin under
   `your_module/src/Plugin/ExtraField/Display/` using Extra Field's
   `@ExtraFieldDisplay` annotation, extending one of the two base classes
   (`ExtraFieldPlusDisplayBase` for raw markup, or
   `ExtraFieldPlusDisplayFormattedBase` to render inside the standard field
   template).
2. **Declare its settings.** Implement the static `extraFieldSettingsForm()` (the
   form elements — e.g. a wrapper tag or a "link to entity" checkbox) and
   `defaultExtraFieldSettings()` (their defaults), and optionally
   `settingsSummary()` for the line shown on Manage display.
3. **Configure it in the UI.** On the bundle's **Manage display**, your extra
   field now shows a cog. Open it, set the options per view mode, and save. The
   values are stored in the display configuration (or, under Layout Builder, on
   the section component), so they travel with your config export.
4. **Read the settings at render time** in your plugin via its helper methods
   (`getEntityExtraFieldSettings()` / `getEntityExtraFieldSetting($key)`).

Each plugin's settings should be validated by a config schema keyed by the field's
machine name — the example submodule ships one you can follow as a pattern.
