<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ePayco API operations exposes a POST endpoint for running ePayco SDK operations and REST lookups.

---

ePayco API operations (`epayco_api`) is an experimental submodule of the ePayco project. It adds a single POST
route, `/epayco/api/operation` (`epayco_api.endpoint`), whose controller runs ePayco operations through the base
module's `epayco.handler` service and returns a JSON response. Callers pass a `type` (`factory:system`,
`factory:custom`, `transaction:info`, `reference:info`, or `pse:banks`) and a `config` payload. This lets custom
code or trusted external systems query a transaction by id, look up a payment by reference code, list PSE banks,
or run an arbitrary SDK factory operation, without wiring up their own service calls. The endpoint is gated by the
`execute epayco_api operations` permission; grant it only to trusted roles.

---

- Query ePayco data over a single HTTP POST endpoint.
- Look up a remote transaction by id (`transaction:info`).
- Look up a payment by ePayco reference code (`reference:info`).
- Fetch the available PSE bank list for a public key (`pse:banks`).
- Run an operation against a saved factory (`factory:system`).
- Run an operation against ad-hoc credentials (`factory:custom`).
- Call an arbitrary ePayco SDK object/method via a factory operation.
- Build custom ePayco integrations without writing service-call boilerplate.
- Return results as structured JSON with a `status` code.
- Drive an external/back-office tool that needs ePayco transaction data.
- Reconcile payments from a scripted caller.
- Restrict endpoint use with the `execute epayco_api operations` permission.
- Reuse the base module's configured factories from HTTP callers.
- Prototype ePayco SDK calls quickly during development.
- Centralize ePayco lookups behind one route.
- Support multiple merchant accounts by naming a factory in the request.
