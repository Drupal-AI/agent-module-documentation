<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Usage Data — agent index

Logs **site usage data** for analysis/visualization (usage metrics, self-hosted). Config at
`usage_data.settings`; provides permissions. Version **2.0.0-beta3**. Core `^9.3||^10||^11`.

**Privacy:** if it logs user-identifiable activity, that's PII — mind what's captured, gate the reports by
permission, handle per retention. No access role beyond permission.
