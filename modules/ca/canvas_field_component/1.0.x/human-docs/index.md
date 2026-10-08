# Drupal Canvas Field Component — manual setup guide

**Drupal Canvas Field Component** (`canvas_field_component`) lets you place a
rendered **field** directly into a **Drupal Canvas** template, as if the field were
one of Canvas's own components. Canvas builds pages from components, but plain
entity fields are not components — which leaves an awkward gap: a page assembled in
Canvas can hold designed blocks and arbitrary markup but not, without help, the
actual field values of the entity it is displaying. This module closes that gap
with a **Field Display** component you can drag into a template.

Because the field renders through Drupal's normal formatter pipeline, you keep
everything that pipeline gives you: image styles and responsive image styles, date
and text formats, entity-reference rendering, multi-value field output, and
field-level access. It even supports third-party formatter settings, so modules
that extend formatters (such as Date Augmenters) keep working. In short, it lets
Canvas layouts include values from fields that do not yet have a dedicated Canvas
component mapping — Smart Date fields being one example — the way Layout Builder can
place fields, but with Canvas's deeper component customization available where the
mappings exist.

This is a Canvas add-on: it requires the **Drupal Canvas** module, plus PHP 8.3 and
Drupal 11.2 or 12, so like Canvas itself it targets the current edge rather than a
broad range of versions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Drupal Canvas.
2. [Configuration](configuration/index.md) — how to place and configure a Field
   Display component inside a Canvas template.

## Where it lives in the admin menu

There is no standalone settings page. You work with the module inside the Canvas
editor's template and component tooling (the component collection,
`entity.component.collection`). The step-by-step workflow is on the
[Configuration](configuration/index.md) page.

## A note for local development

Documentation review found that the **Canvas** module itself could not be kept
enabled on a development install where third-party SDC components were present:
Canvas's component discovery runs a metadata check over every SDC component on the
site, and an unresolvable field-type property expression trips an assertion. With
`zend.assertions` enabled — the default in DDEV and most development images — that
becomes an uncaught error during the container build, stopping both the site and
Drush. Production PHP compiles assertions out, so this is a development-environment
issue, but a total one. If you install Canvas locally, check your `zend.assertions`
setting first.
