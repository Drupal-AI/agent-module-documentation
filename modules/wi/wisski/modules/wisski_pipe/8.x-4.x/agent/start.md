<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Pipe (wisski_pipe) — agent index

Submodule of **wisski**, under the project's **`legacy/`** directory. Composes **processors into
pipelines**. Version **8.x-4.3**. Core `>=10.4 <12`.

The architectural benefit is **testability**: named steps can be run partially, inspected between
stages, and changed one at a time — which matters because data enhancement is always iterative.

**Legacy.** `wisski_apus` is the newer processing base; `flowdrop` (same wave) shows a modern take
on the same pattern. Establish the recommended path before starting here — but the
composable-processor model is sound wherever it appears.