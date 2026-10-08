<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taarikh algorithm plugins & field usage

## Using the field
1. Add a core **Date** (`datetime`) field to your entity.
2. On **Manage form display**, choose the Taarikh widget (`TaarikhDefaultWidget`) for Hijri entry.
3. On **Manage display**, choose the Taarikh formatter (`TaarikhDefaultFormatter`) for Hijri output.

Storage stays standard datetime; Taarikh only converts for entry/display via its form elements `TaarikhDate` / `TaarikhDatetime`.

## Conversion-algorithm plugin type
- **Annotation:** `@TaarikhAlgorithm` (`src/Annotation/TaarikhAlgorithm.php`).
- **Manager:** `AlgorithmPluginManager`, service id `plugin.manager.taarikh_algorithm` (parent `default_plugin_manager`).
- **Base class:** `TaarikhAlgorithmPluginBase` implementing `TaarikhAlgorithmPluginInterface`.
- **Default plugin:** `FatimidAstronomical` (`src/Plugin/TaarikhAlgorithm/FatimidAstronomical.php`).

### Add a custom algorithm
Create `src/Plugin/TaarikhAlgorithm/MyAlgorithm.php`, annotate with `@TaarikhAlgorithm(id=..., label=...)`, extend `TaarikhAlgorithmPluginBase`, and implement the Gregorian↔Hijri conversion methods from the interface. Resolve instances via `\Drupal::service('plugin.manager.taarikh_algorithm')`.
