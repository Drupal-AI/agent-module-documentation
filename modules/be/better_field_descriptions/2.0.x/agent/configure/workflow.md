<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration workflow

All UI lives under `/admin/config/content/better_field_descriptions` (also reachable from the
**Content** admin menu). It is three tabs that must be used in order, because each one only
exposes what the previous one enabled.

## 1. Entities tab (`…/entities`)
Form `BetterFieldDescriptionsEntitiesForm`. A flat checkbox list of every entity type that has
bundle info. Tick the entity types that should be eligible (e.g. `node`, `taxonomy_term`,
`media`, `user`). Stored as config `better_field_descriptions_entities` (a map of
`entity_type => entity_type`). Permission: `add better descriptions to fields`.

## 2. Settings tab (`…` — the default form)
Form `BetterFieldDescriptionsSettingsForm`, route `better_field_descriptions_admin_settings`.
For every bundle of the enabled entity types it renders a `details` group with a checkbox per
**non-base** field (plus the pseudo `title` field). Tick the fields that should get a better
description. Stored as config `better_field_descriptions_settings`
(`entity_type => bundle => field => field`). Only ticked fields survive save (unchecked ones are
dropped). On save it also seeds `better_field_descriptions` entries for newly ticked fields with
placeholder defaults (`description: "Sample Description"`, `label: "Label"`, `position: 1`).
Permission: `administer better field descriptions settings`.

## 3. Bundles tab (`…/bundles`)
Form `BetterFieldDescriptionsFieldsForm`, route `better_field_descriptions_admin_settings.bundles`.
This is where the real content is written. Global controls at the top:
- **Template** select — options are the `*.html.twig` files found by globbing this module's
  `templates/` folder (`better-field-descriptions-text`, `better-field-descriptions-fieldset`,
  plus any you added). Changing it triggers a theme-registry rebuild on submit.
- **Default label** textfield — used for any field whose own label is left blank.

Then, per enabled field (grouped by entity type → bundle in collapsible `details`):
- **Description** (textarea) — the help text. Restricted HTML only (`FieldFilteredMarkup`).
- **Label** (textfield) — per-field label; blank falls back to the default label.
- **Position** (radios) — `0` above title+input, `1` below (default), `2` between title and
  input. "Between" replaces the field's own visible title with this label and can duplicate
  titles on some widgets — the form warns to review the content form after saving.

Stored as config `better_field_descriptions` (`entity_type => bundle => field =>
{description,label,position}`, plus top-level `template`, `default_label`, `template_uri`).
Permission: `add better descriptions to fields`.

## Custom templates
Drop a `my-template.html.twig` into your **theme's** `templates/` directory; the Bundles-form
template select is built from this module's own `templates/` folder, so to expose a theme
template it must be picked up by the theme layer — the shipped pattern is to copy one of the two
provided templates. Available Twig variables: `label`, `description`, `required`. Selecting a new
template resets the theme registry.

## Notes for agents
- There is **no** config schema shipped, so these settings are untyped in `config/schema` terms;
  they still export/import normally as `better_field_descriptions.settings`.
- Removing a field from a bundle leaves stale config entries; the Bundles form silently skips
  fields that no longer exist.
