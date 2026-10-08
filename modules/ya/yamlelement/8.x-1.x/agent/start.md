<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yaml Form Element (yamlelement) — agent index

Provides a reusable Form API element, **`#type => 'yaml'`** (`Element\Yaml`, extends core
`Textarea`): it renders a `<textarea>`, parses the submitted text with Symfony YAML on
`#element_validate`, and **replaces the submitted string in `$form_state` with the parsed PHP
structure**; on `#pre_render` it dumps the stored structure back to YAML text for editing. On top of
that element it ships a field **widget** and **formatter** (both plugin id `yamlelement`) for the
core **`map`** field type, so a `map` field can be edited and displayed as YAML with no custom code.

- Depends on: nothing (core only). Core: `^8.8 || ^9 || ^10 || ^11`. Package: none (info.yml sets no `package`).
- No settings page / `configure` route, no permissions, no services, no drush, no hooks, no
  `.module`/`.install` file. Developer-facing only.
- Provides config schema (empty widget/formatter settings mappings). Defines **no new plugin
  *types*** — only element/widget/formatter plugin *instances*.

## What you'd do → where

- **Use the YAML element in a custom form; understand its parse/dump lifecycle and properties** →
  [forms/yaml-element.md](forms/yaml-element.md)
- **Store, edit and display a `map` field as YAML (widget + formatter)** →
  [fields/widget-formatter.md](fields/widget-formatter.md)

## Key facts (real machine names)

- Render element: `yaml` — `Drupal\yamlelement\Element\Yaml`, extends
  `Drupal\Core\Render\Element\Textarea`, implements `TrustedCallbackInterface`. Callbacks:
  `validateYaml` (`#element_validate`), `preRenderYaml` (`#pre_render`, the only trusted callback).
  Element property `#allow_objects` (bool, default `FALSE`) controls object-tag handling in the
  underlying Symfony parser/dumper.
- Field widget: `yamlelement` — `Drupal\yamlelement\Plugin\Field\FieldWidget\YamlWidget` (extends
  `WidgetBase`), `field_types = {"map"}`; no settings.
- Field formatter: `yamlelement` — `Drupal\yamlelement\Plugin\Field\FieldFormatter\YamlFormatter`
  (extends `FormatterBase`), `field_types = {"map"}`; no settings; renders `Yaml::dump()` inside
  `<pre>…</pre>`.
- Config schema: `field.widget.settings.yamlelement`, `field.formatter.settings.yamlelement` (both
  empty mappings).
- Parser/dumper: `Symfony\Component\Yaml\Yaml::parse()` / `::dump()` (core's bundled `symfony/yaml`).
- The element validates **syntax only** — it reports a form error on invalid YAML but does not check
  that the parsed keys/values match any schema; consuming code must validate the parsed shape itself.
