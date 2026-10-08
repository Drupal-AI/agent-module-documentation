<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Meta Force is one of four demonstration meta types under Entity Meta Example, carrying force information.

---

It exists to be one of several. EMR's design allows a host entity to carry more than one meta type at once, each configured and revised independently, and a single example cannot show that — so the example module ships four, of which this is one.

The `force` subject is arbitrary and deliberately so. Reading it, the useful content is the *shape*: how a meta type declares itself, how its fields are defined, how it is related to a host and how it participates in the host's revisions. The subject matter is a placeholder chosen precisely because nobody will mistake it for a real requirement.

**Not for production.** Enabling it adds a meta type with no meaning to any real content model.

Where it is genuinely useful is as a diff target: build your own meta type, compare it against this one, and the differences are either deliberate or a mistake you have just found.

---

- See how a force meta type is declared.
- Show several meta types coexisting.
- Read the shape rather than the subject.
- Compare a custom meta type against it.
- Find a mistake by diffing against the example.
- Understand independent meta configuration.
- See how a meta type joins host revisions.
- Prototype from a working definition.
- Avoid enabling it in production.
- Remove it before launch.
- Audit configuration for example meta types.
- Teach the EMR model with a concrete case.
- Verify a custom type's revision behaviour.
- Plan several meta types on one host.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
