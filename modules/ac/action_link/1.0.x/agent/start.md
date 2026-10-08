<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action Link (action_link) — agent index

Framework for configurable **action links**: a link that performs a state-changing action when
clicked (toggle/cycle a field, change workflow state, add to cart), output as AJAX, reload,
POST-button, AJAX-POST-button, or confirmation-form links.

- **Version:** 1.0.0-beta1. **Core:** `^10.3 || ^11`. **License:** GPL-2.0-or-later.
- **Dependencies:** `declarative_form_ajax`. Implicitly uses `drupal/plugin` (plugin_type decorators).
  No `composer.json` requires beyond core.
- **Provides permissions:** yes (`administer action_link entities` + a per-entity `use <id> action links`).
- **Config schema:** yes. **Drush:** no.

## Architecture (two plugins + one config entity)

An **`action_link` config entity** (`src/Entity/ActionLink.php`, `ActionLinkInterface`) holds config
and delegates: `plugin_id`/`plugin_config` → a **State Action** plugin (the logic); `link_style` → a
**Link Style** plugin (the UX); `output` → **Action Link Output** plugins (where links appear).

Provides three plugin types (`action_link.plugin_type.yml`, managers in `src/`):
- **State Action** — `Plugin/StateAction/*`, `#[StateAction]` attribute, `StateActionManager`.
  Core plugins: `boolean_field`, `numeric_field`, `options_field`, `date_field` (all extend
  `EntityFieldStateActionBase`). Geometry traits `ToggleGeometryTrait` / `RepeatableGeometryTrait`.
- **Link Style** — `Plugin/ActionLinkStyle/*`, `#[ActionLinkStyle]`, `ActionLinkStyleManager`.
  `ajax`, `nojs` (internal fallback), `reload`, `post_link`, `post_link_ajax`, `confirm_form_page`.
- **Action Link Output** — `Plugin/ActionLinkOutput/*`, `#[ActionLinkOutput]`, `ActionLinkOutputManager`
  (base only in parent; concrete plugins live in submodules).

## Routes & how a click works

- Admin/entity routes come from core's `AdminHtmlRouteProvider` plus `action_link.routing.yml`
  (`entity.action_link.output_form`, `entity.action_link.demo_form`; both `_permission: administer
  action_link entities`).
- The **action routes are dynamic**: `ActionLinkRouteProvider::routes()` asks each entity's state
  action plugin for a `Route` (`StateActionBase::getActionRoute()`), path
  `/action-link/{id}/{link_style}/{direction}/{state}/{user}/…dynamic params`.
- Every action route is served by `Controller/ActionLinkController::action()` and gated by
  `::access()` (a `_custom_access` callback). See `agent/plugins/link-styles.md` for the CSRF and
  access model.

## Render / output

- `#type => action_linkset` (`Element/ActionLinkset.php`) renders a link set (all directions) with a
  lazy builder; `ActionLink::buildLinkSet()` / `buildSingleLink()` return that element. See
  `agent/api/render.md`.
- Themes: `action_linkset`, `action_link`, `post_link`, `action_link_popup_message`
  (`action_link_theme()`), template suggestions per plugin ID and entity ID.

## Submodules (each documented under `modules/<name>/1.0.x/`)

- `action_link_entity_links` — output links in node/comment entity links.
- `action_link_field` — output links as a Computed Field (needs `computed_field`).
- `action_link_formatter_links` — output links inside a field formatter.
- `action_link_workflow` — State Action for `workflows` transitions (experimental).
- `action_link_poc` — proof-of-concept add-to-cart / subscribe plugins (experimental).

## Solution docs

- `agent/entity/action-link.md` — the config entity, forms, permissions, config schema.
- `agent/plugins/state-actions.md` — State Action plugins, geometry, entity-field actions.
- `agent/plugins/link-styles.md` — Link Style plugins, the action route, CSRF + access model.
- `agent/api/render.md` — outputting action links in render arrays and code.
