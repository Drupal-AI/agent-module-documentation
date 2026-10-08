<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Gate MCP exposes File Gate's status, gate lookup, grants, metrics and single-grant revoke to AI agents as governed MCP Tool API plugins.

---

File Gate MCP is an optional submodule of File Gate that publishes five **Tool API** plugins so an MCP client (an
AI agent) can inspect and, for incident response, act on the file gate. It depends on `file_gate`, `mcp_sentinel`
(>=2.22) and `tool` (>=1.0.0-beta8). Four tools are read-only — `file_gate_status`, `file_gate_file_gate`
(per-file gate lookup), `file_gate_grants_list`, `file_gate_metrics` — and one, `file_gate_grant_revoke`, revokes a
single grant. Every tool is governed by MCP Sentinel: access requires the restricted `use file gate mcp tools`
permission (revoke also requires `revoke file gate grants via mcp`), a resolved policy profile, and passes a
per-tool rate limit and a response-size cap. Tools never return secret material, file paths or download URLs; the
module's own refusals are a single fixed message and caller input / exception text never reach a result. Enable
with `drush en file_gate_mcp`.

---

- Let an AI agent report whether File Gate protects what its configuration claims (`file_gate_status`).
- Check whether one file or media UUID is gated, by which field and method (`file_gate_file_gate`).
- Confirm that a gated file's plain `/system/files` URL will not serve it, for an agent building a UI.
- List active usage-limited signed-URL grants for a gated field (`file_gate_grants_list`).
- See a grant's id, file UUID, expiry, max uses, subject-bound flag and minting secret id — never a token.
- Report mint / delivery / denial / auth-failure counts for 1–90 days, per day and per method (`file_gate_metrics`).
- Surface the ten most-requested file UUIDs from the database log.
- Revoke exactly one grant by field + grant id for incident response (`file_gate_grant_revoke`).
- Gate revoke behind a dedicated restricted permission separate from the read tools.
- Keep every tool governed by MCP Sentinel policy profiles (rate limit + response-size cap).
- Guarantee no secret, file path or download URL is ever returned to the agent.
- Honour media view access when resolving a media UUID, so the tool is not a way around it.
- Validate all inputs (UUID shape, field-key shape, grant-id shape, day range) and fail closed on bad input.
- Record only the failure class (not caller input) when a tool errors.
- Scope a revoke to the grant's own field so a guessed or copied grant id from another field is refused.
- Give agents read visibility into the gate without handing them the ability to mint downloads.
