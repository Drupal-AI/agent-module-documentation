<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Number Field Token Custom Format — agent index

Adds a **custom `sprintf`-based formatting option to number-field tokens** (zero-pad/decimals/thousands for
tokenized number output). Depends on core `system` (>=10), `field`. Version **2.3.0**. Core `^10||^11`.

Developer/token — the sprintf format is **admin-configured** (not user input), applied to the field's numeric
value. No content/access role.
