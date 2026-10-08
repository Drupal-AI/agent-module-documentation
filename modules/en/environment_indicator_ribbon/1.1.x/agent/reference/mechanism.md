<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering mechanism

The entire module is one hook plus one asset library. There are no routes, controllers, services,
forms, entities, or plugins.

## Hook: `environment_indicator_ribbon_page_attachments()`

File: `environment_indicator_ribbon.module`, implements `hook_page_attachments(array &$attachments)`.

Steps:
1. `\Drupal::currentUser()->hasPermission('access environment indicator ribbon')` — returns early
   (attaches nothing) if the current user lacks the permission. So the payload and library are only
   emitted to permitted users.
2. Reads the base module's config object `environment_indicator.indicator` and takes three keys:
   `name`, `fg_color`, `bg_color` (each `?? ''` when unset). This module owns none of these values.
3. Writes them to `$attachments['#attached']['drupalSettings']['environment_indicator_ribbon']` as
   `{name, fgColor, bgColor}`.
4. Attaches the library `environment_indicator_ribbon/environment_indicator_ribbon`.

## Library: `environment_indicator_ribbon/environment_indicator_ribbon`

Defined in `environment_indicator_ribbon.libraries.yml`. Dependencies: `core/drupal`, `core/jquery`,
`core/drupalSettings`, `core/once`.

- **`js/environment_indicator_ribbon.js`** — `Drupal.behaviors.environmentIndicatorRibbon`. On
  attach, if `drupalSettings.environment_indicator_ribbon` exists, it uses
  `once('environmentIndicatorRibbon', 'body')` to append a single
  `<div class="environment-indicator-ribbon">` to `body`, with `background-color`/`color` set inline
  from the config colours and the environment `name` as the div's content.
- **`css/environment_indicator_ribbon.css`** — one rule, `.environment-indicator-ribbon`:
  `position: fixed; left: 55px; bottom: 55px`, `transform: rotate(45deg) translate(-50%, 50%)`,
  uppercase letter-spaced 13px sans-serif text, drop shadow, `z-index: 1500`, `pointer-events: none`
  (so it never intercepts clicks).

The ribbon therefore renders on every page (front-end included), independent of the
environment_indicator admin-toolbar bar, for any user holding the permission.
