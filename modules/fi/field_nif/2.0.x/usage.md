<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field NIF defines a `nif` field type for storing Spanish administrative identification numbers — NIF (individuals), CIF (companies) and NIE (foreigners) — with built-in format and check-digit validation.
---
The field validates input via a constraint (`NifConstraint`/`NifValueValidator`) so invalid numbers cannot be saved, and stores the value **split into components** in the database (first letter, number, last/control letter, and the detected type) rather than as one opaque string. This lets formatters and downstream code display or process the parts independently. The module ships a widget, a default formatter (which HTML-escapes the value on output), a form API `nif` element, and a Webform element plugin so the same validated input can be collected in Webforms.

Setup: enable the module, add a **NIF/CIF/NIE** field to any fieldable bundle, and configure its widget and formatter as usual. Validation logic lives in `NifUtils` (unit-tested) and is reused by the constraint, the render element and the Webform element, so entity fields, plain form elements and Webform submissions all enforce the same rules.
---
- Add a validated NIF/CIF/NIE field to a content type
- Reject invalid Spanish tax/ID numbers on save
- Store the ID split into letter/number/control components
- Detect whether a value is a NIF, CIF or NIE
- Display the number with the default formatter
- Collect a NIF/CIF/NIE in a Webform via the element plugin
- Use the `nif` render element in a custom form
- Validate a value programmatically with NifUtils
- Build custom displays from the stored components
- Enforce consistent ID validation across entity and Webform
- Require a valid company CIF on an organisation content type
- Require a valid NIE on a foreigner-registration form
- Capture individuals' NIF on membership content
- Format output safely (values are HTML-escaped)
- Migrate/import records with validated Spanish IDs
- Reuse the same validation rules in code and forms