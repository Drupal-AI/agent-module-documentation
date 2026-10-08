<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action Link Formatter Links (action_link_formatter_links) — agent index

Submodule of **action_link**. Outputs action links **inside a field's formatter** (e.g. inc/dec links
either side of the value). Depends on `action_link`. Provides config schema; no permissions.

## What it provides

- **Link style** `ajax_entity_field` (`src/Plugin/ActionLinkStyle/AjaxEntityField.php`,
  `#[ActionLinkStyle(id: 'ajax_entity_field', csrf_token_http_method: GET, no_ui: TRUE)]`, extends the
  core `Ajax` style). On a successful action it returns the **whole rendered field** (in every
  relevant view mode) as AJAX `ReplaceCommand`s, so the updated value shows, not just the link. On
  failure it falls back to the parent Ajax behaviour (links only).
- **Admin hooks** `src/Hook/AdminHooks.php` (autowired): `#[Hook(
  'field_formatter_third_party_settings_form')]` adds an `action_links` **checkboxes** element listing
  action links whose state action (`EntityFieldStateActionBase`, single dynamic param) targets that
  field on that entity type.
- **Display hooks** `src/Hook/DisplayHooks.php` (autowired): `#[Hook('entity_display_build_alter')]`
  reads the formatter's `third_party_settings['action_link_formatter_links']['action_links']`, wraps
  the field element in a container, and injects `#type => action_linkset` elements — two directions
  placed **before/after** the value, otherwise the whole set after it. Swaps link style `ajax` →
  `ajax_entity_field`. Also exposes `getViewModeWrapperCssClass()` / `getGenericWrapperCssClass()`
  (used by the link style to target ReplaceCommands).

## Config schema

`config/schema/action_link_formatter_links.schema.yml` —
`field.formatter.third_party.action_link_formatter_links` with an `action_links` sequence of ints
(action link ids to show).

## Operate

Enable the module; in a bundle's **Manage Display**, edit a field's formatter settings and check the
action link(s) under **Action links**. Fields in **Views** additionally require core patch
drupal.org #2686145. Click authorization/CSRF is handled by the core controller.

## Solution docs

- `agent/output/formatter-links.md` — third-party settings, display alter, and the ajax_entity_field
  replacement logic.
