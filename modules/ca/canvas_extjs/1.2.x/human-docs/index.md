# Canvas External JS — manual setup guide

**Canvas External JS** (`canvas_extjs`) adds a new *component source* to the
**Drupal Canvas** page builder. Canvas normally assembles pages from components it
knows about — single-directory components (SDC), field displays, and blocks. This
module adds one more kind: a component whose implementation is **external
JavaScript**, such as a Vue, React, or Nuxt component maintained outside Drupal.
It stores each component's metadata (its props and slots) inside Canvas's own
component-configuration entities, and renders the component either from custom
JavaScript files you provide or via the Custom Elements preview system.

This suits teams whose design system lives as a front-end package, a widget shared
with non-Drupal properties, or a component that ships on its own release cadence.
Paired with the optional **Custom Elements** and **Lupus Decoupled** modules it can
even drive a fully decoupled, server-side-rendered frontend.

That flexibility comes with a real trade-off, and it is worth stating plainly:
loading a component from outside the site means Drupal renders code it does not
version, review, or control. Whoever controls that JavaScript controls what runs on
the page, including anything the visitor's session can reach. Treat it exactly as
you would a third-party `<script>` tag — pin a known origin, put a change process
around it, add Subresource Integrity where you can, and pair it with a Content
Security Policy that names the origins you allow. This is a supply-chain decision as
much as a technical one.

One compatibility note from the maintainers: this module builds on Canvas's
ComponentSource API, which is not yet declared stable, so each release is only
declared compatible with the current Canvas minor version. When a new Canvas minor
ships you may have to wait a few days for a matching, tested release of this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Drupal Canvas.

There is no dedicated settings page for this module. Component sources are set up
inside the Canvas editor itself once the module is enabled.

## Where it lives in the admin menu

Canvas External JS adds no standalone admin page. You work with it entirely inside
the **Drupal Canvas** editor, where the external-JavaScript component source
becomes available when you build components and pages.

## A note for local development

Documentation review found that the **Canvas** module itself could not be kept
enabled on a development install where third-party SDC components were present:
Canvas's component discovery runs a metadata check over every SDC component on the
site, and an unresolvable field-type property expression trips an assertion. With
`zend.assertions` enabled — the default in DDEV and most development images — that
becomes an uncaught error during the container build, stopping both the site and
Drush. Production PHP compiles assertions out, so this is a development-environment
issue, but it is a total one. If you install Canvas locally, check your
`zend.assertions` setting first.
