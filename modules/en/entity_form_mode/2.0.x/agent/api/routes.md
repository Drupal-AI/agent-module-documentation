<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes & the form-mode selection hook

This module **defines no routes, controllers, services, or access checks of its own** — there is no
`*.routing.yml`, and a runtime route dump confirms zero routes owned by `entity_form_mode`. It works
entirely by implementing one hook that swaps the *form display* used on Drupal core's **existing**
entity form routes. There is no "per-form-mode edit route" to secure; the edit route is core's.

## The hook — `entity_form_mode_entity_form_display_alter()`

`entity_form_mode.module:37-53`, implementing `hook_entity_form_display_alter()`. On every entity
form build it:

1. reads `$context['entity_type']` and `$context['bundle']`;
2. lists the bundle's configured form modes via the core service
   `entity_display.repository`::`getFormModeOptionsByBundle($entity_type, $bundle)`;
3. gets the current route name from `\Drupal::routeMatch()->getRouteName()`;
4. if a form-mode machine key `$key` matches the current route — either `entity.{entity_type}.{key}`
   or, **for nodes only**, `node.{key}` — replaces `$form_display` with
   `getFormDisplay($entity_type, $bundle, $key)` (falling back to the original display if that form
   mode has no stored `EntityFormDisplay`).

So the **form-mode machine name must equal the last segment of the route name**:

| Core route (NOT defined here) | Example path | Form-mode key that activates |
|---|---|---|
| `entity.node.edit_form` | `/node/{node}/edit` | `edit_form` |
| `entity.taxonomy_term.edit_form` | `/taxonomy/term/{taxonomy_term}/edit` | `edit_form` |
| `entity.comment.edit_form` | `/comment/{comment}/edit` | `edit_form` |
| `entity.{custom_type}.edit_form` | its edit route | `edit_form` |

Caveats (from `README.md`):

- **Adding nodes** uses the route `node.add` (not `entity.node.add`); for node *add* forms keep the
  `default` form mode. Other node forms behave normally. The code's special `node.$key` branch exists
  precisely because node routes are `node.*`, not `entity.node.*`.
- **User entities do not work** — the user form routes do not follow the `entity.{type}.{form_id}`
  naming the hook matches.

## Access model — what gates the form

Because the module adds no route, **access is entirely core's**. The route being visited
(e.g. `entity.node.edit_form`) already carries core's `_entity_access: '{entity}.update'` (or
`.create` for add forms); the hook runs only *after* that access check has passed, and it merely
chooses *which* form display renders. It never relaxes, replaces, or bypasses route access.

Field-level access is likewise unchanged: core's `EntityFormDisplay::buildForm()` builds each
component through `WidgetBase::form()`, which checks `$items->access('edit', …, TRUE)` and drops any
field the user is not permitted to edit — regardless of which form mode was selected. Switching form
modes therefore cannot surface a field a user may not edit.

**Important corollary (a design fact, not a code flaw):** a form mode is *presentation*, not
authorization. A field left out of a form display is simply not written *from that form*; it stays
readable and writable via JSON:API, REST, another form mode, a webform, a migration, or `drush`. To
actually forbid a role from changing a value, use field access (`hook_entity_field_access`, or the
`field_permissions` module) — never a form mode.

## Other hook

`entity_form_mode_help()` (`entity_form_mode.module:15-32`) implements `hook_help()` for
`help.page.entity_form_mode`, rendering `README.md` (through the `markdown` filter when the Markdown
module is enabled, otherwise HTML-escaped). This core-generated help route is the only route
associated with the module and is gated by `access administration pages`.
