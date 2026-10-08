<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Meta Relation Node makes the EMR machinery available on nodes — the integration most sites actually need.

---

EMR itself is entity-type-agnostic: it defines meta entities and the relationships that hold them to a host. This submodule supplies the node side — the form integration, the revision handling, and the configuration that says which meta types apply to which content types.

The revision handling is the part that earns the module. When a node is revised, its related meta entities have to be revised with it, or an old revision shows today's metadata — which quietly makes revision history a lie for anything metadata-driven. Getting that right by hand across nodes, translations and moderation states is genuinely hard, and it is what this submodule is for.

Configuration is per content type, which is the right granularity: an Article may need SEO metadata while a Basic page does not, and adding a meta type to one should not add it to all.

Anything building on EMR for node content depends on this rather than on `emr` alone.

---

- Attach meta entities to nodes.
- Configure which meta types apply per content type.
- Revise metadata with the node.
- See a past revision's metadata, not today's.
- Keep revision history honest.
- Add SEO metadata to Articles only.
- Integrate meta forms into the node form.
- Handle metadata across translations.
- Work with moderation states.
- Build a node feature on EMR.
- Avoid hand-rolling revision-correct metadata.
- Audit which content types carry meta types.
- Plan a metadata-driven content model.
- Extend node behaviour without new fields.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
