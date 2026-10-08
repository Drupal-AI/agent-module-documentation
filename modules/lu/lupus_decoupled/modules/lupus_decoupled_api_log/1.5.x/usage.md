<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled API Log records the API requests the front end makes and the responses Drupal returns.

---

Debugging a decoupled site means answering "what did the front end actually ask for, and what did it get?" — and without a log, that question is answered by adding print statements to two codebases at once.

This submodule records both sides. When a page renders wrongly, the log shows whether the request was what you expected and whether Drupal's answer was, which usually settles in one look whether the problem is in Drupal or in the front end.

**Treat it as a development tool and be deliberate about leaving it on.** Logging full API requests and responses means logging whatever passed through them: personal data in an entity payload, a session-scoped response, a form submission. That belongs in a development environment and, if it must run in production, needs a retention limit, access control on who can read it, and a decision about redaction. It is the same class of exposure as the credential logging found in `lingotek` this wave — the difference is that here it is the module's purpose, so it is on the operator to bound it.

---

- See what the front end requested.
- See what Drupal returned.
- Settle whether a bug is front end or back end.
- Debug an unexpected page render.
- Trace a failing API call.
- Compare requests across environments.
- Verify a front-end change hit the right endpoint.
- Investigate a slow response.
- Keep logging to development environments.
- Set a retention limit if run in production.
- Restrict who can read API logs.
- Consider redaction for personal data.
- Audit what the log captures.
- Correlate a front-end error with a Drupal response.
- Turn logging off after debugging.