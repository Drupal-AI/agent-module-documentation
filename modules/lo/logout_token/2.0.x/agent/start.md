<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logout Token — agent index

Endpoint (`GET /session/logout/token`) returning the **CSRF logout token** for the current session — lets
decoupled/JS front ends perform a **CSRF-safe logout**. Uses Drupal's CSRF token generator. Version
**2.0.1**. Core `^10||^11`.

Session/auth helper supporting (not weakening) the CSRF-protected logout flow; token tied to the
authenticated session.
