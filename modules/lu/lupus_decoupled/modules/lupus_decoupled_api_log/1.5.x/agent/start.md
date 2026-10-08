<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled API Log (lupus_decoupled_api_log) — agent index

Submodule of **lupus_decoupled**. Logs **API requests and responses**.
Version **1.5.1**. Core `^10 || ^11`.

Answers the decoupled debugging question — *what did the front end ask for, and what did it get?* —
without adding print statements to two codebases.

**Say this every time:** it logs whatever passed through the API — personal data in entity
payloads, session-scoped responses, form submissions. Development tool. If it must run in
production: retention limit, access control on who reads it, and a redaction decision. Same class
of exposure as the `lingotek` credential-logging finding, except here it is the module's purpose,
so bounding it is the operator's job.