<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Whoops — agent index

Integrates the **whoops** PHP library for **rich, detailed error pages** (exception, full stack trace,
code snippets, request context). Development tool. Version **2.0.1**. Core `^10.1||^11`.

**SECURITY — DEV ONLY, never on production.** It displays stack traces/source/paths/env on error —
exactly what must not reach visitors (reveals code paths, config, possibly secrets; aids attackers).
Local/dev only; keep production error display off; treat production presence as a misconfiguration.
