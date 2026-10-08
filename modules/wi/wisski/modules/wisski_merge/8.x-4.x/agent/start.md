<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Merge (wisski_merge) — agent index

Submodule of **wisski**, nested under **`wisski_apus`** (content and annotation processing).
Merges multiple instances/records. Version **8.x-4.3**. Core `>=10.4 <12`.

**A second merge implementation, belonging to a different workflow** from `wisski_data_merge`: this
one sits in the processing pipeline, i.e. automated rather than editorial.

**Settle before running it:** what the rule is, what it does with ambiguous cases, and whether the
result is reviewable before commit. "Merge anything with the same normalised label" is defensible
for a controlled import and destructive for free-text catalogue data.

Establish which merge implementation a project actually uses.