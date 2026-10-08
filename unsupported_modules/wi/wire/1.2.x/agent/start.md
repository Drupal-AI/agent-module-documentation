<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wire (WireDrupal) — agent index

**HTML-over-the-wire (Livewire-style) reactive component framework for Drupal** — server-rendered dynamic
components without much JS. Distributed via Packagist as `wire-drupal/wire`; pulled here as a dependency of
`musaed`. Version **1.2.1** (v1.2.1). Core `^10||^11`.

Developer framework — component actions are **server endpoints driven by client input**: each component must treat
inputs as untrusted (validate/authorize actions, enforce data access, don't expose sensitive methods). No access
role of its own.
