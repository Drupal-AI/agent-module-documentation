<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Meta Relation attaches separately-stored metadata entities to content, keeping the relationship correct across revisions.

---

Some information about a node is not really *of* the node: SEO metadata, a visual variant, a set of feature toggles, an audio or speed profile. Modelling it as fields on the content type mixes concerns and, more practically, means every content type that needs it grows the same fields again.

EMR models it as separate `entity_meta` entities related to the host, which gives three things fields do not. The metadata is **reusable** across content types without duplicating the field set; it is **revisioned in step** with the host, so an old revision shows the metadata it had rather than today's; and it is **separable**, so a module can add its own meta type without touching the content model.

The submodules show the range: `emr_node` for node integration, and `entity_meta_audio`, `_speed`, `_visual`, `_force` and `_example` as meta types — `_example` being the one to read when writing your own.

The revision behaviour is the part that justifies the complexity. Getting "what did this page's SEO metadata say at the time it was published" right is genuinely hard with plain fields once revisions and translations are involved, and it is exactly the question an editorial audit asks.

It comes from the OpenEuropa ecosystem, where content is heavily revisioned and metadata-driven, which is the shape of site it suits.

---

- Attach metadata to content without adding fields.
- Reuse a metadata set across content types.
- Keep metadata revisioned with its host.
- See what metadata a past revision had.
- Add a new meta type from a module.
- Model SEO metadata separately from content.
- Attach a visual variant to a node.
- Store feature toggles per node.
- Read the example submodule when writing a meta type.
- Integrate meta entities with nodes.
- Avoid duplicating field sets across types.
- Audit metadata history for a page.
- Separate concerns in a content model.
- Plan a metadata-driven site.
- Answer what a page's metadata said when published.
