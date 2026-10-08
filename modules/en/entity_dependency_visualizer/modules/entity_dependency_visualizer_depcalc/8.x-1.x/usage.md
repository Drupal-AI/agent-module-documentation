<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional submodule that lets Entity Dependency Visualizer calculate an entity's dependencies with the contrib Dependency Calculator (depcalc) module instead of the built-in native field traversal.

---

Entity Dependency Visualizer + Dependency Calculator (entity_dependency_visualizer_depcalc) registers a second DependenciesCalculator plugin, "DepCalc" (id `depcalc`), that runs contrib depcalc's DependencyCalculator over the viewed entity and feeds the results into the visualizer's DependencyStack for graphing. It requires the depcalc module and the parent entity_dependency_visualizer module. Select the "DepCalc" plugin on the parent module's settings form and clear caches to switch calculators. Supports Drupal 10.2 and 11.

---

- Compute dependency graphs using contrib depcalc's calculation engine.
- Reuse depcalc's deeper dependency resolution for the visualizer graph.
- Offer an alternative to the native reference-field traversal.
- Feed depcalc results into the same Graphviz rendering pipeline.
- Graph content-entity dependencies collected during a depcalc calculation.
- Switch the active calculator via the parent settings form.
- Integrate with sites already using depcalc (e.g. Acquia Content Hub).
- Skip user entities during depcalc collection (current behaviour).
- Provide a drop-in plugin discovered automatically by the parent's plugin manager.
- Keep graph appearance/config shared with the native calculator.
- Let developers compare native vs. depcalc dependency output.
- Enable only when depcalc-based calculation is actually needed.
