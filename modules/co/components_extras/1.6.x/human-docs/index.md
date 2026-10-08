# Components Extras — manual setup guide

**Components Extras** (`components_extras`) is a small developer add-on for the
**Components** module. Components gives you namespaced Twig paths — for example
`@mycomponents/card.html.twig` — which is fine when you are writing a template but
awkward when you are building a **render array** in PHP and want a component
rendered as part of it. Components Extras closes that gap by supplying a **render
element** so you can render a component from a render array, plus a theme-manager
service that resolves which theme's version of a component should be used (so a
subtheme can override a component).

This is a developer-facing module only: it has no routes, no permissions, no
configuration, and nothing user-visible. It depends on the **Components** module,
and its Composer constraint is unusually permissive
(`drupal/components: ^1.0|^2.0@beta|^3.0@beta`) — meaning a `composer update` can
move Components onto a beta branch, so pin the parent explicitly if that matters
to you. The module is minimally maintained with no further development planned,
but it supports a wide range of Drupal core versions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Components dependency.

There is **no configuration page** for this module — it is a developer API you
call from code.

## Where it lives in the admin menu

Components Extras adds nothing to the admin menu. You use it entirely from code:
place the module's render element in a render array (in a block plugin,
controller, Views field, form element, or email pipeline) to render a Components
component, letting the theme-manager service pick the right theme's version.
