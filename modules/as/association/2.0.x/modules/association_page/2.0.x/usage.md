Adds a fieldable, revisionable landing-page entity that shares an association's ID and serves as its canonical page.

---

`association_page` is a submodule of Entity Association (also needs Toolshed). It defines the `association_page` content entity — fieldable, revisionable, translatable, bundled by `association_type`, and using the same entity ID as its parent `association`. It is registered as the `association_page` landing-page handler plugin; when an association type selects that handler, every association of the type gets a dedicated page auto-created on association creation and auto-deleted on association deletion (there is no manual create/delete of pages). The page's canonical route (`/association/{association_page}`) becomes the association's canonical URL, so blocks, menus and links to the association resolve to this managed page. View access mirrors the association's active state; editing and revision curation (revert/delete) are controlled by per-type page permissions. Route providers add revision history/view/revert/delete pages, and a route enhancer plus hooks wire the page's Field UI, form/display and Layout Builder local tasks onto the association type admin.

---

- Give each association a dedicated, editable landing page instead of just linking to a member entity.
- Add custom fields to association landing pages via Field UI (per association type).
- Configure the page's form and view displays, or lay it out with Layout Builder.
- Keep a full revision history of each landing page, with revert and delete of old revisions.
- Default new edits to create a new revision (per-type landing-page plugin option `new_revision`).
- Translate landing pages alongside their association.
- Have the landing page appear/disappear from the front end automatically with the association's active status.
- Delegate "edit landing page" and "curate landing page revisions" rights per association type to roles.
- Use the page as the canonical target so association menus, breadcrumbs and blocks point at real content.
- Automatically reassign or unpublish a user's landing pages (and revisions) when the account is cancelled.
- Auto-provision the page when an association is created — no separate page-creation step for editors.
