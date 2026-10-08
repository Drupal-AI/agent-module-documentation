<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Term Machine Name provides a machine-name field for taxonomy terms, giving each term a stable, developer-friendly identifier that is independent of its label or term ID. This is useful for referencing terms from code, config, or migrations without hard-coding numeric term IDs.

---

The module defines a machine-name field type/widget for terms and provides an uninstall helper form at /admin/modules/uninstall/field/taxonomy_term_machine_name (permission "administer modules") to cleanly remove the field data before uninstalling. It depends on core field and taxonomy and requires PHP 8.0+.

Use it when you need to look terms up by a constant key across environments — for example mapping imported data to terms, keying business logic on a category, or building config that survives content rebuilds. The machine name is entered/managed on the term, and the removal route ensures field storage is torn down safely at uninstall time.

---

- Give each taxonomy term a stable machine name.
- Reference terms by a constant key instead of tid.
- Decouple term identity from its human label.
- Key application logic on a category's machine name.
- Map imported/migrated data to terms reliably.
- Build config that survives content rebuilds.
- Add the machine-name field to any vocabulary.
- Keep term identifiers consistent across environments.
- Avoid hard-coding numeric term IDs in code.
- Look up terms programmatically by machine name.
- Support deploy-friendly term references.
- Provide a code-friendly slug per term.
- Clean up field data safely before uninstall.
- Manage removal via the admin uninstall route.
- Restrict field teardown to "administer modules".
- Standardize term naming for developers.
- Integrate machine names into custom queries.
- Ease term-based feature toggles.
