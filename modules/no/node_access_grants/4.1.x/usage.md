<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Access Grants gives Drupal's node access grants system an object-oriented interface, replacing arrays of realm/gid/priority with a typed collection that is harder to get wrong.

---

The grants system is one of the least forgiving parts of Drupal: `hook_node_grants()` and `hook_node_access_records()` exchange nested arrays whose keys are undocumented in the signature, priority semantics are subtle, and a mistake produces silent over-disclosure that no test catches unless it was written to look for it. This module wraps that in `NodeAccessGrantsCollection` and `NodeAccessGrantsInterface`, so a module builds and returns objects rather than assembling arrays by convention — which moves a class of error from runtime to the type system, and makes the resulting code readable to someone who has not memorised the array shape. It is a small library: five files, no dependencies beyond PHP 7.1+, no routes, permissions or configuration, and core `^10 || ^11`. Enabling it alone changes nothing; it exists for other modules to consume. It is worth stating plainly that this improves the *ergonomics* of grants, not their semantics: grants are still OR-combined across modules, still require a node access rebuild after changes, and still bypass nothing about how carefully the policy itself must be reasoned about.

---

- Write a node access module with typed objects.
- Avoid hand-assembling grant arrays.
- Make grants code readable to a reviewer.
- Reduce mistakes in hook_node_access_records().
- Build grants in a testable collection.
- Share grant-building logic across modules.
- Encapsulate realm and gid handling.
- Prototype an access model quickly.
- Refactor a legacy grants implementation.
- Give a custom access module structure.
- Reduce copy-paste between grant hooks.
- Document a grants policy in code.
- Type-hint grant construction.
- Simplify onboarding to node access.
- Unit-test grant generation.
- Keep priority handling explicit.
- Support several realms cleanly.
- Underpin a bespoke access requirement.
