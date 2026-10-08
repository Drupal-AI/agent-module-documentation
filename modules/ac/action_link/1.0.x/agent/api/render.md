<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Outputting action links in code

## The `action_linkset` render element

`src/Element/ActionLinkset.php` (`@RenderElement("action_linkset")`, extends `RenderElementBase`).
Renders a set of links (one
per direction) for an action link, using a lazy builder so the link set's poor cacheability does not
pollute the surrounding page.

Properties:
- `#action_link` — the action link entity ID (string).
- `#user` — user ID the links are for (defaults to the current user).
- `#dynamic_parameters` — array of the state action plugin's dynamic parameter values, in the order
  the plugin declares them (keying by name is optional; values must be scalar).
- `#direction` — (optional) render only this one direction instead of the whole set.
- `#link_style` — (optional) override the entity's configured link style (used by the field/formatter
  submodules to force `ajax`/`nojs`/`ajax_entity_field`).

Example:

```php
$build['links'] = [
  '#type' => 'action_linkset',
  '#action_link' => 'node_publish',
  '#dynamic_parameters' => [$node->id()],
];
```

A direction whose target state is not currently reachable, or which the user cannot access, is
rendered as an **empty `<span>`** (not omitted) so that an AJAX response to another direction's link
can populate it in place.

## From the entity

`ActionLink::buildLinkSet($user, …$parameters)` and
`ActionLink::buildSingleLink($direction, $user, …$parameters)` return the same `action_linkset`
element. Both assert that parameters are scalar.

## Directly from the state action plugin (uncacheable)

`StateActionInterface::buildLinkSet()` / `buildLinkArray()` / `buildSingleLink()` build the render
array immediately without a lazy builder — prefer the entity/element methods above; use these only
when extending the module.

## Theming

Themes registered in `action_link_theme()`:
- `action_linkset` — the set; suggestion `action_linkset__<plugin_id>__<action_link_id>`.
- `action_link` — one link (render element); template `action-link.html.twig`.
- `post_link` — the POST-button link; `post-link.html.twig`.
- `action_link_popup_message` — the AJAX pop-up; `action-link-popup-message.html.twig`.

## Automatic output (submodules)

Rather than placing the element yourself, enable an Action Link Output plugin on the entity's Output
tab: `entity_links` (node/comment links), `computed_field` (a computed field), or configure the
formatter submodule. See the submodule docs under `modules/<name>/1.0.x/`.
