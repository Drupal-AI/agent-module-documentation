<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Extras Bootstrap (apigee_extras_bootstrap) — agent index

Submodule of **Apigee Extras** that makes Apigee portal elements Bootstrap 5 compatible.
Package `Apigee`. Depends on `apigee_extras:apigee_extras`. Core `^10.3 || ^11.1`.
GPL-2.0-or-later. Version **1.0.0-beta1**. Needs a Bootstrap 5-based theme for the styles.

## What it actually is

- A single file, `apigee_extras_bootstrap.module`, implementing
  **`apigee_extras_bootstrap_preprocess_status_property(array &$variables)`** — a preprocess hook on
  the Apigee Edge `status_property` theme element. No `src/`, routes, permissions, services, config,
  templates, libraries or Drush.
- The hook lower-cases `$variables['element']['value']`, resolves Bootstrap `bg-*` colour class(es)
  from a hard-coded `$status_map`, and merges `['badge', 'rounded-pill']` + the colour class(es) +
  `'wrapper--status--<status>'` into `$variables['attributes']['class']`. Result: the existing
  `status-property.html.twig` (rendered by Apigee Edge) outputs a Bootstrap pill badge with no
  template override.

## Status → class map (from `$status_map`)

- `active` / `approved` / `published` / `enabled` / `1` → `bg-success`
- `inactive` / `disabled` / `0` → `bg-secondary`
- `revoked` / `blocked` / `deleted` / `error` → `bg-danger`
- `pending` / `pending_approval` → `bg-warning text-dark`
- `expired` → `bg-dark`
- anything else → `bg-secondary` (fallback)

## Docs

- The hook, the map, and how to customise the badge → [theming/badges.md](theming/badges.md)
