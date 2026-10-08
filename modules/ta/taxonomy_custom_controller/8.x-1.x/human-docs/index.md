# Taxonomy Custom Controller — manual setup guide

**Taxonomy Custom Controller** (`taxonomy_custom_controller`) is a small
developer‑oriented module that changes how a taxonomy term page is built so that
your own code can shape it. Normally a term page is the `taxonomy_term` View,
and changing it means either editing that View or replacing the term route in a
route subscriber of your own. This module does the route subscription once, hands
the term page to its own controller, and fires an event — `TermPageBuildEvent` —
while the page is being built. Any module can subscribe to that event and rewrite
what the page renders.

That gives you a clean, supported extension point. In your event subscriber you
receive the current taxonomy term, so you can branch on its vocabulary, its
fields, or its position in the hierarchy, and return whatever build array you
like — a per‑vocabulary landing page, a term description shown above a filtered
listing, a custom empty state, extra per‑term metadata, and so on. Several
modules can contribute to the same term page this way without fighting over the
route. Compared with the similar TVI module — which does the same job through the
Views UI — this one requires you to write a little PHP, but in exchange lets you
do essentially anything.

There is nothing to configure: the module has no settings form, no permissions,
and no routes of its own. You enable it and then write an event subscriber. It
depends on core **Taxonomy** and **Views**, and works on Drupal 9, 10 and 11.

**One consequence to keep in mind and to write down for your team:** once this
module is enabled, the term page no longer comes from the `taxonomy_term` View.
A site builder who edits that View will see no effect, and other modules that
assume the default term‑page behaviour may not apply. Nothing in the Views UI
hints at the override, so it is worth a line in your own site documentation to
save someone a confusing afternoon.

This guide is written for a **human** setting the site up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead — they
name the exact classes and the event API.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, add an event subscriber (in a small custom module) to the
`TermPageBuildEvent`. In the handler you get the term via
`$event->getTaxonomyTerm()`, decide what to render — you can check the term's
bundle, fields or depth — and call `$event->setBuildArray($build)` with your
render array. A common pattern is to combine the term's own description with an
embedded View of its content. The project ships a
`taxonomy_custom_controller_example` submodule with a complete working example,
and the [`agent/`](../agent/start.md) docs list the event‑name constants and
classes involved.
