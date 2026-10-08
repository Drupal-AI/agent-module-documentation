<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wire provides an HTML-over-the-wire (Livewire-style) reactive component framework for Drupal.

---

Wire (WireDrupal) **provides an "HTML over the wire" reactive component framework** — a Livewire-inspired way
to build dynamic, server-rendered UI components in Drupal where interactions round-trip to the server and swap in
fresh HTML, so developers get reactive UIs without hand-writing much JavaScript. It is distributed via Packagist as
`wire-drupal/wire` (here it is present as a dependency of the `musaed` module) and works on core 10–11.

Use it as a developer framework for reactive components. Security note for any HTML-over-the-wire framework:
component actions are **server endpoints driven by client input**, so components must **treat their inputs as
untrusted** (validate/authorize each action, don't expose sensitive methods/properties to the client, and enforce
access on any data a component reads or mutates) — the framework moves logic to the server, but each component
author is responsible for access checks and input validation on its actions. It has no access-control role of its
own. Build components against the Wire API.

---

- Provide HTML-over-the-wire components.
- Enable Livewire-style reactive UI.
- Server-render dynamic components.
- Distribute via Packagist (wire-drupal/wire).
- Serve developers.
- Reduce hand-written JavaScript.
- EXPOSE component actions as server endpoints driven by client input.
- TREAT component inputs as untrusted (validate/authorize each action).
- Not expose sensitive methods/properties to the client + enforce data access.
- Make each component author responsible for access checks + validation.
- Have no access-control role of its own.
- Build components against the Wire API.
- Handle reactive components.
- Render components.
- Configure nothing (framework).
- Swap HTML.
- Handle the round-trip.
- Drive UI from the server.
- Validate inputs.
- Provide an HTML-over-the-wire framework.
