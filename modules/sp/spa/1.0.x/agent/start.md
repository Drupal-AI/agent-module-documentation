<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SPA — agent index

**Helps integrate a single-page application (SPA) into a Drupal page/route** (form-element helpers). Depends on
`plugin_form_element`, `multivalue_form_element`. Provides permissions. Version **1.0.0-beta2**. Core `^10||^11`.

Developer/front-end — the SPA is front-end code you supply; ensure its **API endpoints have their own auth**
(don't assume Drupal gates them). No access role beyond permission.
