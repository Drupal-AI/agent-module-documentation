<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rut provides a reusable Drupal form element (`#type => 'rut_field'`) and a `Drupal\rut\Rut` helper class that validate Chilean RUT/RUN identifiers (the national ID number and its check digit "DV"); a bundled `rut_field` submodule adds a storable field type.
---
The `Rut` class offers static helpers: `separateRut()` splits a "12.345.678-9" string into number + DV, `calculateDv()` computes the modulo-11 check digit (0-9 or "k"), `validateRut()` verifies a number against its DV, `formatterRut()` renders the dotted/dashed form, and `generateRut()` returns a random valid RUT. The `rut_field` form element extends core Textfield, runs server-side `#element_validate` (with an optional `#bypass_validation`) and can attach a jQuery client-side validator via `#validate_js`. Deprecated Drupal Console generate/validate commands are also shipped.

The `rut_field` submodule (depends on `field` and `rut`) stores a RUT as `rut` (big int) + `dv` (char) columns with a combined `value`, a widget, a default formatter, a Feeds target and Views filter. Field-level `bypass_validation` and a `UniqueRutField` constraint (uniqueness query runs with `accessCheck(FALSE)`, an intentional data-integrity check, not an access decision) are available. The module exposes no routes, controllers or permissions — it is pure field/validation code, so there is no anonymous or mutating surface; validation is CPU-only string math.
---
- Add a self-validating RUT/RUN input to a custom form with `#type => 'rut_field'`.
- Require a valid Chilean RUT on a form (`#required => TRUE`).
- Enable client-side RUT validation with `#validate_js => TRUE`.
- Customise the client-side invalid message via `#message_js`.
- Bypass validation for a specific element with `#bypass_validation => TRUE`.
- Validate a RUT string in code with `Rut::validateRut($value)`.
- Split a formatted RUT into number and DV with `Rut::separateRut()`.
- Compute a check digit with `Rut::calculateDv($number)`.
- Format a number+DV into "12.345.678-9" with `Rut::formatterRut()`.
- Generate a random valid RUT for tests/fixtures with `Rut::generateRut()`.
- Store a RUT on an entity by adding a `rut_field_rut` field (rut_field submodule).
- Enforce uniqueness of a RUT field across entities via the Unique constraint.
- Allow saving inconsistent RUTs by enabling the field's *Bypass validation* setting.
- Display stored RUTs with the default RUT formatter.
- Import RUT values through Feeds using the RUT Feeds target.
- Filter Views results by RUT equality.
- Generate sample RUT field values for content generation.
- Query entities by the numeric `rut` column (indexed).
