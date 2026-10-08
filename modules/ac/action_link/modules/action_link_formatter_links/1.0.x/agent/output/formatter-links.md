<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter Links output

Renders action links inside the formatter of the field they control, driven by the formatter's
third-party settings. Two hook services + one link style; wired in
`action_link_formatter_links.services.yml` (both hook classes `autowire: true`).

## Configuration UI — `src/Hook/AdminHooks.php`

`#[Hook('field_formatter_third_party_settings_form')]` → `fieldFormatterThirdPartySettingsForm()`.
Adds an `action_links` `#type => checkboxes` element whose options are the action links that control
this field. `getActionLinksForField()` / `getActionLinksForEntityType()` (statically cached per
entity type) select action links whose state action `is_subclass_of EntityFieldStateActionBase`, has
exactly one dynamic parameter, targets this entity type, and whose `getTargetFieldName()` matches the
field. Stored under third-party settings namespace `action_link_formatter_links`, key `action_links`
(schema: `field.formatter.third_party.action_link_formatter_links` → sequence of ints).

## Injection — `src/Hook/DisplayHooks.php`

`#[Hook('entity_display_build_alter')]` → `entityDisplayBuildAlter(&$build, $context)`. For each field
in the display whose component carries non-empty `third_party_settings[...]['action_links']`, for each
delta and each selected action link:
- loads the action link; if its link style is `ajax`, swaps the style id to `ajax_entity_field`.
- wraps the original field element in a `#type => container` with two CSS classes from
  `getViewModeWrapperCssClass()` (includes view mode) and `getGenericWrapperCssClass()`.
- if the action has exactly **two** directions, inserts one `action_linkset` (single `#direction`)
  before the value and one after; otherwise inserts the whole link set after the value. Each injected
  element passes `#dynamic_parameters => [$entity->id()]` and `#link_style`.

## AJAX replacement — `src/Plugin/ActionLinkStyle/AjaxEntityField.php`

`#[ActionLinkStyle(id: 'ajax_entity_field', csrf_token_http_method: GET, no_ui: TRUE)]`, extends the
core `Ajax` style; deps add `entity_type.manager`, `entity_display.repository`, and the `DisplayHooks`
service. Overrides `addReplacementsToResponse()`:
- on failure, defers to the parent Ajax (replaces only the links).
- on success, re-renders the controlled field with `getViewBuilder()->viewField()` for the `default`
  view mode plus every enabled view mode that shows the field (and disabled ones when the default
  display shows it — since disabled modes fall back to default), skipping `rss`/`token`/`search_index`.
  Each is emitted as a `ReplaceCommand` targeting the wrapper CSS class, so the visible value updates.
  A final ReplaceCommand covers the custom-view-mode selector, rendered with the default display
  (there's no way to recover arbitrary custom display options). `getMessageCommandSelector()` puts the
  status message on the clicked direction's link.

## Notes

- Fields shown in **Views** require core patch drupal.org #2686145.
- Custom formatter display options are not recoverable for AJAX replacement; the field falls back to
  the default display (see README workarounds, incl. `hook_action_link_style_info_alter()`).
- Authorization/CSRF of a click remains the core `ActionLinkController`'s responsibility.
