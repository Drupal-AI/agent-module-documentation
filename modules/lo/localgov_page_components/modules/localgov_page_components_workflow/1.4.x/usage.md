Adds content-moderation-aware publishing to LocalGov Page Components so that draft edits to reusable components stay hidden on the frontend until the parent node is published, via a bundled `page_components` workflow and a "smart revisions" field formatter.

---

The submodule ships a ready-made content-moderation workflow (`page_components`, states Draft/Published, applied to the `paragraphs_library_item` entity type) and a field formatter, `localgov_page_components_workflow_formatter` ("Page components (smart revisions)"), for the `localgov_page_components` entity-reference field. A `node_update` hook (`src/Hook/NodeHooks.php`) cascades the parent node's moderation state down to every referenced page component: it creates a new revision on each component, sets its `moderation_state` to `published` when the node is published (else `draft`), writes an auto-sync revision log message, and recursively re-points nested paragraph reference fields to their latest revisions (all kept `status = 1`). The formatter (`PageComponentsFieldFormatter`) decides which revision to render: on the node's *Latest version* route it shows each component's latest revision (with latest nested paragraphs); elsewhere it shows the latest **published** revision (found by scanning all revisions for `moderation_state === 'published'`). The net effect is that in-progress component edits only surface once the host node itself is published. The README notes the caveat that saving a component *directly* as Published makes its changes visible immediately regardless of the node state, and suggests standard host-entity paragraph fields as an alternative if this wrapper isn't wanted.

---

- Keep draft edits to a shared component hidden until the parent page is published.
- Cascade a node's publish action to all of its referenced page components automatically.
- Cascade a node's draft state down to components so they revert to draft alongside the node.
- Render the latest *published* revision of a component on the live (canonical) page.
- Render the latest revision (including nested paragraph edits) on the node's *Latest version* tab for preview.
- Apply a content-moderation workflow to `paragraphs_library_item` entities out of the box.
- Give editors Draft/Published control over reusable components.
- Auto-write revision log messages ("Auto-synced with parent node …") for traceability.
- Recursively stage the latest revisions of deeply nested paragraphs inside a component.
- Coordinate publication of a page and its shared building blocks as a single editorial action.
- Preview unpublished component changes without exposing them to anonymous visitors.
- Switch a Page components field to "smart revisions" rendering by changing its formatter.
- Provide an editorial-workflow layer on top of the otherwise host-independent paragraphs library.
- Avoid premature exposure of component edits that are re-used across several published pages.
- Attach the workflow admin CSS only on admin-themed pages (via `page_attachments`).
- Serve as a reference implementation for cascading moderation state to referenced entities.
