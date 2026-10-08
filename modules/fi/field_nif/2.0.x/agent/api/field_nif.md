<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field NIF — usage & surface

**Add the field**
- *Manage fields* on any bundle → add **NIF/CIF/NIE** (`nif`) → set widget and the `nif_default` formatter.

**Stored components** (columns on `NifItem`): first letter, number, last/control letter, and detected `type` (NIF / CIF / NIE) — so displays can render parts independently.

**Validation**
- `NifConstraint` + `NifValueValidator` reject malformed or wrong-check-digit values on save.
- `NifUtils` (`NifUtilsInterface`, unit-tested) holds the validation/parse logic and is reused everywhere.

**Other surfaces**
- `src/Element/Nif.php` — a `nif` Form API render element for custom forms.
- `src/Plugin/WebformElement/Nif.php` — collect a validated NIF/CIF/NIE in Webforms.
- `NifFormatter::viewValue()` returns `Html::escape($item->value)` — output is escaped.