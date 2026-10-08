<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How rules reach the page — three mechanisms

All in `body_attributes.module`, `body_attributes.services.yml`, and `js/body_attributes.js`.
A rule is applied only if `status()` is TRUE and `body_attributes_check_conditions()` passes.

## 1. `html` / `body` zones → `hook_preprocess_html()`

`body_attributes_preprocess_html()` loads all `body_attribute_rule` entities
(`entityTypeManager->getStorage('body_attribute_rule')->loadMultiple()`) and, for each active rule
whose `zone` is `html` or `body` with a non-empty value:

- Target variable is `html_attributes` (zone `html`) or `attributes` (zone `body`).
- It ensures the target is a Drupal `\Drupal\Core\Template\Attribute` object, then:
  - `attribute_type = class` → `$attributes->addClass($value)`.
  - otherwise (with a name) → `$attributes->setAttribute($name, $value)`.

So class/value application here goes through core's `Attribute` object rather than raw string
concatenation. Rules for these two zones are rendered **server-side** into the theme's
`<html>` / `<body>` tag.

## 2. `header` / `main` / `footer` / `selector` zones → JS

`body_attributes_page_attachments()` collects active rules whose zone is **not** `html`/`body` and
maps the zone to a selector: `header`→`header`, `main`→`main`, `footer`→`footer`,
`selector`→`custom_selector`. Each becomes an entry
`{selector, type, name, value}` pushed to `drupalSettings.bodyAttributes`, and the
`body_attributes/apply` library (`js/body_attributes.js`) is attached.

`Drupal.behaviors.bodyAttributes` (in `js/body_attributes.js`) iterates those entries,
`context.querySelectorAll(rule.selector)`, and for each element applies
`el.classList.add(rule.value)` (type `class`) or `el.setAttribute(rule.name, rule.value)` (type
`attribute`). It `console.warn`s when a selector matches nothing. This path is **client-side** and
runs after the DOM is available.

## 3. Always-on automatic `data-*` attributes → event subscriber

Independent of any rule, the module ships an active kernel-response subscriber:

- Service `body_attributes.manager` = `Service\BodyAttributesManager` (args:
  `current_route_match`, `current_user`, `path_alias.manager`, `path.current`). Its
  `getAttributes()` returns diagnostic attributes for the current request:
  `data-role` (each of the current user's roles), `data-route` (current route name),
  `data-node-type` + `data-node-id` (when a `node` route parameter is present), and `data-alias`
  (the current path's alias with `/` replaced by `-`).
- Service `body_attributes.subscriber` = `EventSubscriber\BodyAttributesSubscriber`, tagged
  `event_subscriber`, listening on `KernelEvents::RESPONSE` (`onRespond`, priority 0). For every
  `HtmlResponse` it fetches those attributes and injects them onto the `<body>` open tag of the
  rendered response.

This runs on **every HTML response** as soon as the module is enabled — no configuration required —
and adds those `data-*` attributes for CSS/JS that needs to know the current role, route, node, or
alias.

## Notes / caveats

- `BodyAttributesManager` is passed `current_user` in its constructor but only uses roles from it;
  the class is otherwise self-contained.
- The rule-based `hook_preprocess_html` path (mechanism 1) and the automatic subscriber
  (mechanism 3) both touch the `<body>` tag but are entirely separate code paths — the subscriber
  does not read any rule config.
- `Form\BodyAttributesSettingsForm` in `src/Form/` is unused/dead (no route wires it); it is not
  part of any rendering path.
