<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Template suggestions from entity view displays

How `entity_vdts` adds a Twig suggestion, from UI toggle to render. All behavior lives in two hook
classes plus one constant; there is no config form of its own, no route, and no permission.

## Install / enable

- `drush en entity_vdts` (or via *Extend*). Enable **Field UI** too — the toggle appears on the
  entity view display edit form, which Field UI provides (*Manage display* tab, e.g.
  `admin/structure/types/manage/page/display`).
- No settings route (`configure` is null). Configuration is per view display, stored inline on the
  `entity_view_display` config entity as a third-party setting.

## The config namespace and key

- `Drupal\entity_vdts\EntityViewDisplayTemplateSuggestionsInterface::CONFIG_KEY = 'entity_vdts'`
  (`src/EntityViewDisplayTemplateSuggestionsInterface.php`) — the third-party settings provider
  name used everywhere.
- Only one stored setting today: **`bare`** (boolean).
- Schema: `config/schema/entity_vdts.schema.yml` types the setting under
  `core.entity_view_display.*.*.*.third_party.entity_vdts` as a mapping with a `bare` boolean.

## UI: the "Template suggestions" field

`src/Hook/FormEntityViewDisplayEditFormAlter.php`, `#[Hook('form_entity_view_display_edit_form_alter')]`:

- `alter()` returns early unless the form object is a `field_ui` `EntityDisplayFormBase` and its
  entity is an `EntityViewDisplayInterface` — so it only touches genuine view-display edit forms.
- Adds a `#type => details` element keyed `entity_vdts` (`#tree => TRUE`) titled *Template
  suggestions*, containing a `bare` checkbox *"Add bare template suggestion"*. The checkbox
  `#default_value` is the display's existing `getThirdPartySetting('entity_vdts', 'bare')`.
- Registers `$this, 'entityBuilder'` in `$form['#entity_builders']`.
- `entityBuilder()` reads `$form_state->getValue('entity_vdts')`; for `bare` when false it calls
  `unsetThirdPartySetting()` (keeps config clean), otherwise `setThirdPartySetting()`. So an
  unchecked box removes the key entirely rather than storing `false`.

## Render: transferring the setting and adding the suggestion

`src/Hook/ThemeSuggestions.php`:

- `entityView()` — `#[Hook('entity_view')]`: sets
  `$build['#entity_vdts'] = $display->getThirdPartySettings('entity_vdts')`, carrying the display's
  settings into the render array so they survive to theme-suggestion time.
- `themeSuggestionsAlter()` — `#[Hook('theme_suggestions_alter')]`: reads
  `$variables['elements']['#entity_vdts']`; returns early if unset/empty. If `bare` is truthy and
  `$variables['theme_hook_original']` is a string, it appends
  `theme_hook_original . '__bare'` to `$suggestions`. The suggestion string is derived entirely
  from the core theme hook (e.g. `node`, `taxonomy_term`, `user`) — no user or request input is
  interpolated.

## What the theme must do

The module only registers the *suggestion*. For it to take effect, the active theme must provide a
matching template, e.g. `node--bare.html.twig`. With Twig debug enabled you will see
`* node--bare.html.twig` listed among the candidates for displays where `bare` is on. This is what
`tests/src/Functional/TemplateSuggestionsTest.php` asserts: `node--bare.html.twig` is absent until
the `bare` third-party setting is saved on `node.page.default`, then present.

## Extending

Only `bare` exists. The plumbing (`CONFIG_KEY` mapping in the form, `getThirdPartySettings()`
transfer, and the `theme_suggestions_alter` check) is written so additional boolean suggestions
could be added, but no other key is implemented in 1.0.x.
