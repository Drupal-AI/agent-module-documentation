# UI Patterns Settings — manual setup guide

**UI Patterns Settings** (`ui_patterns_settings`) extends the **UI Patterns**
module so that a pattern (component) can expose typed **settings** — textfields,
selects, booleans, tokens, attributes, colors, links, numbers, and many more —
that a site builder simply fills in when placing the pattern. It removes the need
to write `hook_preprocess` code just to pass configuration into a Twig component.

The idea: with plain UI Patterns, a component declares `fields` (its content
slots). This module adds a peer concept, `settings`, to the pattern's YAML
definition. Each setting has a `type` (a plugin that renders the right form
element and normalizes the value) and appears wherever the pattern is placed — a
Layout Builder section, a field formatter, or a UI Patterns block. The submitted
value flows straight into the template, so `{{ modifier }}`, `{{ variant }}`, or
`{{ attributes }}` just work.

This is a **developer / site‑builder** module driven by YAML — it has **no
settings page of its own** (its `configure` route is null). It depends on the
**UI Patterns** module and the **Token** module, and ships no submodules. It adds
two plugin types you can extend: **setting types** (custom form widgets) and
**data providers** (dynamic option lists, with `menu` and `breadcrumb` built in).
It also stores one small piece of config — a mapping that binds an entity field's
value to a pattern setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside UI Patterns and Token.

## Where it lives in the admin menu

The module adds no admin page of its own. Pattern **settings** appear inline
wherever you place a pattern — in the Layout Builder section configuration, the
"UI Patterns" field formatter settings, or the UI Patterns block form.

## How to use it

Settings are declared in the pattern's YAML definition (`*.ui_patterns.yml`),
alongside `fields`. For example:

```yaml
card:
  label: Card
  settings:
    modifier:
      type: textfield
      label: Modifier
    variant:
      type: select
      label: Variant
      options:
        default: Default
        featured: Featured
    attributes:
      type: attributes
      label: Attributes
```

Then in the Twig template you use the values directly — `{{ modifier }}`,
`{{ variant }}`, `{{ attributes }}` — with no preprocess code. When a site builder
places that pattern, each setting shows as a form element they can fill in.

Many setting **types** ship out of the box, including `textfield`, `select`,
`radios`, `checkboxes`, `boolean`, `number`, `token`, `url`, `links`,
`attributes`, `machine_name`, `media_library`, color widgets, and role/language
access variants. You can also **bind an entity field to a setting** so the field's
value feeds the pattern (for example, driving a component's variant from a field);
that binding is stored in the module's `ui_patterns_settings.settings` config.

Developers can add a custom setting type (a `UiPatternsSettingType` plugin) or a
custom option source (a `UiPatternsSettingDataProvider` plugin) — see the
[`agent/`](../agent/start.md) plugin docs.
