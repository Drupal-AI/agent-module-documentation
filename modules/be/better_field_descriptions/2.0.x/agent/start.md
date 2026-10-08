<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# better_field_descriptions — agent start

Themeable, repositionable field help text on **entity edit forms**, plus a single admin
screen to edit that text in bulk. No dependencies, no Drush, no config schema, no plugins.
Version **2.0.3**, core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later.

## Mechanism (confirmed from source)
- `hook_field_widget_form_alter` (`better_field_descriptions.module`) is the whole engine. For
  each field enabled in config it renders the configured description via the
  `better_field_descriptions` theme hook and appends the result to the widget element's
  `#prefix` or `#suffix` (`#field_prefix` / `#field_suffix` for `managed_file` widgets).
- The field's own core description and the field config are **not** modified — this is a
  form-time overlay only.
- **Positions** (radio, config key `position`): `0` = above title+input (`#prefix`), `1` =
  below title+input (`#suffix`, the default), `2` = between title and input — "between" hides
  the widget's own title (`#title_display = invisible`, plus a recursive duplicate-title
  hider) and reuses the label as the description's label.
- Descriptions render through a **Twig template**. Two ship: `better-field-descriptions-text`
  (plain text block) and `better-field-descriptions-fieldset` (collapsible `<details>` with the
  label as `<summary>`). Any `*.html.twig` placed in a theme's `templates/` folder is
  auto-discovered by the Bundles form's template `glob`. Changing the selected template calls
  `theme.registry->reset()`.

## Configuration — three tabs at `/admin/config/content/better_field_descriptions`
Order matters: enable entity types → select fields → write text. See
[configure/workflow.md](configure/workflow.md).
- **Settings** (default form, `BetterFieldDescriptionsSettingsForm`, route
  `better_field_descriptions_admin_settings`) — checkbox tree of fields per enabled
  bundle; the "which fields get a better description" switch.
- **Entities** (`BetterFieldDescriptionsEntitiesForm`, `…settings.entities`) — which entity
  types participate.
- **Bundles** (`BetterFieldDescriptionsFieldsForm`, `…settings.bundles`) — the actual
  description text, per-field label, position, plus the template select and a site-wide
  default label.

All three write into one config object, `better_field_descriptions.settings`, with keys
`better_field_descriptions_entities`, `better_field_descriptions_settings` (enabled fields) and
`better_field_descriptions` (text/label/position + template/default_label/template_uri).

## Permissions
- `administer better field descriptions settings` — gates the **Settings** field-selection form.
- `add better descriptions to fields` — gates the **Entities** and **Bundles** forms, where the
  text is written. This permission's holder can change help text on **every bundle site-wide**;
  grant it as an editorial-lead permission, not a general editor one.

## Markup handling
Descriptions and labels accept a restricted HTML subset: both the Bundles-form defaults and the
rendered output are wrapped in `FieldFilteredMarkup::create()` (core's limited allowed-tags
filter — emphasis, lists, links, `img`; scripts and event handlers stripped). The templates emit
`{{ description }}` / `{{ label }}` with normal Twig autoescape and no `|raw`.

## Not provided
No dependencies, no submodules, no Drush commands, no plugin types, no config schema, no
libraries. Menu link lives under the **Content** admin menu (`system.admin_content`).
