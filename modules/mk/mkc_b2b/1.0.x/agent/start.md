<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MKC B2B — agent index

**B2B procurement for MonkeysCommerce** (companies, quotes, POs, contract pricing, PunchOut). Version **1.0.1**. Core `^11.3||^12`.

**SECURITY (1.0.1):** PunchOut `/mkc/punchout/cxml`+`/oci` are `_access: TRUE`; the SharedSecret is verified with `hash_equals()` only when configured — when unset (default) the check is SKIPPED → anonymous PunchOut session. Set the PunchOut secret. Depends on the MonkeysCommerce suite.