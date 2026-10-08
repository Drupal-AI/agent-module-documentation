Submodule of Entity Reference Delete Check that resolves a linkable URL for paragraph references shown on a delete confirm form by walking up to the paragraph's host entity.

---

Paragraph entities have no meaningful canonical URL of their own, so when a to-be-deleted entity is referenced from inside a Paragraph, the parent module's delete-check notice cannot link to it directly. This submodule adds an event subscriber (`ParagraphUrlProvider`) that listens for the same `DeleteCheckEntityUrlEvent`, detects when the referencing entity is a Paragraph, walks up the `getParentEntity()` chain to the first non-paragraph host, and sets that host's `toUrl()` as the link. It requires the Paragraphs module and the parent Entity Reference Delete Check module, and adds no configuration, permissions, or routes of its own.

---

- Turn a paragraph reference on a delete form into a clickable link to its host node.
- Link references nested inside a paragraph up to the page that actually contains it.
- Resolve links for entities referenced from deeply nested paragraph structures.
- Improve the delete-check notice for sites that build content with Paragraphs.
- Give editors a working link when a term or media item is referenced inside a paragraph field.
- Walk up multiple paragraph nesting levels to reach the real host entity.
- Keep the delete-check notice useful on paragraph-heavy content models.
- Install only when Paragraphs is in use, keeping the base module dependency-free.
- Complement the base module's default entity-URL subscriber for non-paragraph entities.
- Point reviewers to the host page during content cleanups involving paragraphs.
