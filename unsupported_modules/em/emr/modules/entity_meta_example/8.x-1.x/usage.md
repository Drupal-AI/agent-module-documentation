<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Meta Example defines a worked meta entity related to nodes, and parents four demonstration meta types.

---

EMR is an abstraction, and abstractions are learned from examples. This submodule is the example: a complete meta entity related to nodes, with the entity definition, the relationship, the form integration and the configuration all present and working.

Beneath it sit four demonstration types — `entity_meta_audio`, `entity_meta_speed`, `entity_meta_visual` and `entity_meta_force` — which exist to show that several meta types can coexist on one host and be configured independently. The names are deliberately abstract rather than realistic, which is a reasonable choice for a reference: nobody mistakes them for something to use.

**Read this before writing a meta type of your own.** The interfaces alone do not convey how the pieces fit — which parts are entity definition, which are relationship configuration, and where the revision behaviour comes from. The example does.

**Do not enable it on a production site.** It contributes meta types with no meaning to a real content model, and they will appear in configuration where someone will eventually wonder what they are.

---

- Learn how a meta entity is defined.
- See a working EMR relationship.
- Read reference code before writing a meta type.
- Understand where revision behaviour comes from.
- See several meta types coexisting.
- Configure meta types independently.
- Study the form integration.
- Prototype a meta type quickly.
- Avoid enabling it in production.
- Remove demonstration meta types before launch.
- Audit configuration for example entities.
- Teach a team the EMR model.
- Compare a custom meta type against the example.
- Plan a metadata architecture.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
