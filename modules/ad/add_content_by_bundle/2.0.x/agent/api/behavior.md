<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the area handler resolves the URL and access

`AddContentByBundle::render()` (extends `AreaPluginBase`) builds a `#type => link` render
array. Logic worth knowing:

## URL resolution per entity type

- **node** → `Url::fromRoute('node.add', ['node_type' => $bundle])`.
  - If `group` is enabled and the current route has a `group` parameter and the group type
    has a `group_node:<bundle>` plugin, it instead links to
    `entity.group_relationship.create_form` with `plugin_id => group_node:<bundle>`.
- **taxonomy_term** → `entity.taxonomy_term.add_form` with `taxonomy_vocabulary => $bundle`.
- **ECK** (entity implements `\Drupal\eck\EckEntityInterface`) → `eck.entity.add`
  with `eck_entity_type` + `eck_entity_bundle`.
- **anything else** → reads the entity type's `add-form` (or `add-page`) link template and
  substitutes the bundle into the `{...}` placeholder to build an `internal:` URI. If the
  entity type declares neither link, `render()` returns `[]` (no link).

## Access

Access is checked with the **access manager** (`access_manager.checkNamedRoute()`) for the
resolved route and the current user, and stored on the element as `#access`. So the link is
hidden from users who cannot create that bundle — no separate permission is defined by this
module.

If access fails **and** the user is anonymous **and** `login_redirect` is TRUE, the link is
replaced with a "Login to add your `<bundle label>`" link to `user.login`.

## Query parameters

- Starts from `getDestinationArray()` (adds `destination` back to the current view) unless
  `destination` option is truthy, which removes it.
- If Form Mode Control is on and `form_mode` is set, adds `display => <form_mode>`.
- `params` textarea is parsed line by line via `extractParams()`: each line is `key|value`
  (or a bare token used as both key and value). Values are run through the display's
  `viewsTokenReplace()`, so Views argument tokens like `{{ arguments.user_id }}` resolve.

## Dialog (modal / off-canvas)

When `target` is set, the link gets `use-ajax` plus `data-dialog-options` (JSON `{width}`):

- `tray` → `data-dialog-renderer = off_canvas`, `data-dialog-type = dialog`.
- `modal` → `data-dialog-type = modal`.

## Validation

`validate()` errors if a `form_mode` is chosen that is not defined for the selected
type/bundle (checked against `entity_display.repository`
`getFormModeOptionsByBundle()`).
