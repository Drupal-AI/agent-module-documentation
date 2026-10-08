<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integer to Decimal (integer_to_decimal) — agent index

Converts an existing **integer/numeric field to decimal in place**, preserving data — the in-place
type change core forbids. Version **dev (1.x)**. Core `^10.3.0 || ^11`.

**Schema-altering maintenance operation, not a runtime feature.** Rewrites field storage — run
deliberately on a **backed-up** DB, verify the result, then disable. Solves "this integer field
needs to hold decimals now" without a new-field migration.