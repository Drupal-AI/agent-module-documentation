<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Duplicate (wisski_duplicate) — agent index

Submodule of **wisski**. **Detects** duplicate records. Version **8.x-4.3**. Core `>=10.4 <12`.
Pairs with `wisski_data_merge` / `wisski_merge`, which resolve them.

**The separation is deliberate and worth stating.** A merge is destructive and, in research, an
**editorial judgement** — two identical-looking records may be two genuinely different objects
whose distinction someone made on purpose. Workflow: detect automatically → review by someone who
knows the material → merge deliberately.

Run detection **regularly**. Duplicates accumulate continuously; a database cleaned at the end of a
project was wrong throughout it.