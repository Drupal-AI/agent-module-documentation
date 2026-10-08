<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Farm Eggs — agent orientation

farmOS contrib add-on (D9/D10) providing an egg-harvest "quick form".

- Depends on farmOS `farm_harvest` and `farm_quick`; only usable inside a farmOS install.
- Single plugin: `src/Plugin/QuickForm/Eggs.php` (a `farm_quick` QuickForm), plus `farm_eggs.module`.
- Creates harvest logs via farmOS APIs. Access/permissions inherited from farm_quick and farmOS log access. No custom routes or public endpoints. No notable security surface.
