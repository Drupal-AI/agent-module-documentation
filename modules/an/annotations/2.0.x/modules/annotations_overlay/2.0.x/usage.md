<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Overlay surfaces annotations as triggered inline help overlays on entity forms and view displays, so editors get guidance in context.

---

Annotations Overlay injects a small trigger button next to annotated fields on entity add/edit forms and on rendered entity view displays; clicking it opens a native `<dialog>` overlay containing that field's annotations (rendered via the annotation view builder using a dedicated `overlay` view mode). It also appends bundle-level "overview" annotations to entity/node add-list chooser pages. Which annotations show is filtered by the viewer's per-type `consume {type} annotations` permission, and each user can additionally hide types they do not want (stored in `user.data`, gated site-wide by the `enable_type_hiding` setting and surfaced on the user edit form). When the optional annotations_ui module is present, empty slots can show "Add {type} annotation" create links. Two permissions control exposure — `view annotations form overlay` and `view annotations view overlay`. Annotation text is escaped on output; admin-authored bundle descriptions are filtered with the admin XSS tag list. Depends on `annotations`.

---

- Show a help trigger next to annotated fields on entity edit forms.
- Open a modal dialog with a field's annotations on demand.
- Render annotations through a dedicated `overlay` view mode.
- Attach overlays to rendered entity view displays too.
- Append bundle-level overview annotations on entity/node add-list chooser pages.
- Filter shown annotations by the viewer's consume permissions.
- Let each user hide annotation types they don't want to see.
- Store per-user hidden types in user.data with immediate cache invalidation.
- Toggle the whole type-hiding feature site-wide via `enable_type_hiding`.
- Offer inline "Add {type} annotation" links for empty slots (with annotations_ui).
- Inject overlays into inline Paragraphs subforms (structural, no hard dependency).
- Provide a shared trigger-icon builder reused by webform and profile integrations.
- Gate form overlays behind `view annotations form overlay`.
- Gate view-display overlays behind `view annotations view overlay`.
- Show a role-based overlay preview button for editors.
- Keep guidance current via annotation cache-tag invalidation.
- Configure whether empty create-links and the bundle chooser overview appear.
