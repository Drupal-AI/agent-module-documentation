<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs in REST provides a normalizer to serialize paragraphs in REST.

---

Paragraphs in REST provides a **custom normalizer that serializes nested Paragraphs inline in REST** — so a
node's paragraph fields (entity-reference-revisions) are output as nested data in a REST resource, instead of
just references, making paragraphs consumable by a decoupled/REST client. It depends on core REST and the
Paragraphs module, in the Paragraphs package.

Use it to expose paragraph content over REST. It is a decoupled/integration feature. Security note: the REST
**resource itself enforces the parent entity's access** (a client only reaches paragraphs of a node it may
view), and paragraphs conventionally **inherit their parent's access** (they aren't independently
access-controlled), so inline serialization exposes the same data the parent already exposes — but review your
**field-level** access and which fields the REST resource exposes, so a paragraph field you consider private
isn't serialized to clients. It has no access-control role of its own. Configure the REST resource/fields.

---

- Serialize nested Paragraphs inline in REST.
- Output paragraph fields as nested data.
- Make paragraphs REST-consumable.
- Depend on core REST and Paragraphs.
- Serve decoupled/REST clients.
- Normalize entity-reference-revisions.
- Rely on the REST resource enforcing parent access.
- Know paragraphs inherit the parent's access.
- Review field-level access + exposed fields.
- Not serialize private paragraph fields to clients.
- Have no access-control role of its own.
- Configure the REST resource/fields.
- Handle paragraphs in REST.
- Serialize paragraphs.
- Configure the resource.
- Expose paragraphs.
- Handle the normalizer.
- Nest paragraphs.
- Review field access.
- Provide paragraphs in REST.
