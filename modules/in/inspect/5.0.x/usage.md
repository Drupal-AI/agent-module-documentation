<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inspect provides tools to inspect variables and stack traces.

---

Inspect is a **developer debugging tool** — it inspects variables and stack traces, giving richer
variable dumps and traces than raw `print_r`/`var_dump` for diagnosing code. Its admin functionality is gated
by `administer site configuration`, in the Development package.

Use it during development/diagnosis. **Security note:** tools that dump variables/traces can reveal
**sensitive runtime data** (config, credentials in memory, user data, internal structure) and stack traces
expose internals — so keep it to **trusted administrators/developers**, and prefer **not enabling it on
production** (or strictly limiting who can trigger inspection). It has no access-control role beyond the admin
gate. Use it to inspect variables while developing.

---

- Inspect variables and stack traces.
- Give richer dumps than var_dump.
- Diagnose code.
- Gate admin use by administer site configuration.
- Serve developers.
- Dump variable/trace data.
- KNOW dumps can reveal sensitive runtime data.
- Keep it to trusted admins/developers.
- Avoid enabling on production.
- Have no access-control role beyond the admin gate.
- Handle inspection.
- Inspect data.
- Debug variables.
- Handle the tool.
- Trace code.
- Configure inspection.
- Handle debugging.
- Inspect stacks.
- Restrict to developers.
- Provide inspection.
