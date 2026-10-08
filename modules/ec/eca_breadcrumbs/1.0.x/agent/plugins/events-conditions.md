<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA event & condition

## Event: `eca_breadcrumbs:build` — "Build breadcrumb"

Declared by `EcaBreadcrumbsEvents` (`@EcaEvent id = "eca_breadcrumbs"`,
`src/Plugin/ECA/Event/EcaBreadcrumbsEvents.php`) via a deriver `BreadcrumbEventDeriver`
(`EventDeriverBase`). `definitions()` returns one derivative, `build`, mapping to
`BreadcrumbBuildEvent::EVENT_NAME` = `eca_breadcrumbs.build` and event class
`Drupal\eca_breadcrumbs\Event\BreadcrumbBuildEvent`. `eca_version_introduced = "1.0.0"`.

This is the entry point of every model: add it as the event, optionally attach conditions
(content type, route, role, etc.), then run the actions in
[actions.md](actions.md). The event object carries the `Breadcrumb`, the `RouteMatchInterface`,
and the accumulating custom items — see [api/services.md](../api/services.md) for its API.

## Condition: `eca_breadcrumbs_identifier_active` — "Breadcrumb pipeline identifier is active"

`BreadcrumbIdentifierActive` (`@EcaCondition`,
`src/Plugin/ECA/Condition/BreadcrumbIdentifierActive.php`, extends ECA `ConditionBase`,
`eca_version_introduced = "1.0.0"`). Config key `identifier` (required textfield,
token-supported). `evaluate()` returns FALSE unless the current event is a
`BreadcrumbBuildEvent`; it token-replaces and trims the identifier, returns FALSE if empty,
otherwise returns `$this->event->isIdentifierActive($identifier)`.

Use it with the `eca_breadcrumbs_set_applies` action (same identifier string) to let one
pipeline claim a route. This identifier/applies flow is the module's advanced coordination
mechanism and is only partially wired in 1.0.0 (the applies event is not dispatched by the
core builder, and `BreadcrumbBuildEvent` in this release does not define
`isIdentifierActive()`); rely on the plain add/set-item actions for standard breadcrumb
building.
