<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RefreshLess (refreshless) — agent index

**Turbo-style JavaScript navigation layered over Drupal's server-rendered HTML, with a full non-JS fallback.**

- **Version:** 2.0.x (2.0.0-alpha14)
- **Core:** ^10.5 || ^11.2 · **PHP:** 8.2 · **Depends:** hux
- **Routes / permissions:** none.
- **Services:** `refreshless.kill_switch` (opt responses out), `http_middleware.refreshless.kill_switch`, `refreshless.page_state_factory`, `refreshless.request_wrapper_factory`; cache contexts `refreshless_enabled` / `refreshless_request`.
- **Config:** none (no admin form). Uses Hux hooks; recommends BigPipe.
- **Security:** no routes, no permissions, no external calls, no request-data sinks — pure front-end runtime enhancement; posture is benign.
