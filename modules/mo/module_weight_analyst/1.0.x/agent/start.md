<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Weight Analyst — agent index

**Developer utility for monitoring and managing module execution order** (weights, dependency tracking, integrity
score, conflict detection). Provides permissions. Version **1.0.0**. Core `^10||^11`.

Developer/admin — inspects + can change module weights (affects hook order; adjust deliberately, gate to trusted
developers); no content/access role beyond permission.
