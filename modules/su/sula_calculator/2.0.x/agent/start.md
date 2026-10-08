<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SULA Eligibility Calculator (sula_calculator) — agent index
**Configurable AJAX block estimating SULA student-loan eligibility.**

- **Version:** 2.0.x — core `^9 || ^10`
- **Depends on:** block
- **Configure:** `sula_calculator.settings` → `/admin/config/system/sula_calculator` (perm `administer sula calculator`)
- **Blocks:** `SulaCalculatorBlockCredit`, `SulaCalculatorBlockClock` (each with an AJAX form)
- **Permission:** administer sula calculator
- **Security:** front-end display block; only privileged route is the permission-gated admin settings form; no external calls or mutating endpoints.
