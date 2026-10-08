<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Remote Requests (eca_remote_request) — agent index

**Runs outbound HTTP requests and handles their JSON responses as ECA plugins.**

- **Version:** 2.0.x  •  **Core:** ^10.3 || ^11  •  **Requires:** eca
- **Plugins:** action `eca_remote_request_run_remote_requests` (Run Remote Requests); action `Convert JSON to List`; ECA condition `Is JSON Data`.
- **No routes, no permissions, no services** of its own — everything runs inside ECA models.
- **Key files:** `src/Plugin/Action/RunRemoteRequestsAction.php`, `src/Plugin/Action/ConvertJsonToListAction.php`, `src/Plugin/ECA/Condition/IsJsonDataCondition.php`.
- **Security:** No public endpoints. The request URL is taken from ECA model config and the request options are token-replaced YAML that may set any Guzzle option (headers, proxy, TLS `verify`); the action's `access()` always returns allowed, so effective access = who may edit/run the ECA model. Guzzle keeps TLS verification on by default. Treat ECA model authoring as a trusted, admin-level surface (SSRF/options are constrained only by that trust).

See [plugins/actions.md](plugins/actions.md)
