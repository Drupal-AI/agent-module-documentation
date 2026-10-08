Integrates Entity Browser with Inline Entity Form, adding an "Entity form" widget so editors can create new entities inside a browser and letting IEF complex widgets use a browser to attach existing entities.

---

This submodule (machine name `entity_browser_entity_form`) bridges Entity Browser and the Inline Entity Form (IEF) module. It provides an `entity_form` Entity Browser widget that renders a full entity add/edit form inside a browser, so editors can create a brand-new referenced entity (with a chosen entity type, bundle, and form mode) without leaving the picker. It also alters the IEF "complex" widget: on a reference field using Inline Entity Form, a third-party setting lets you pick an entity browser that replaces IEF's default autocomplete "add existing" control, so existing entities are attached through the browser UI instead. It hooks IEF's reference form, swapping the autocomplete for an `entity_browser` element, handling cardinality, and running custom validation/submit so multi-value selections are added correctly. Configuration is stored as a third-party setting on the field widget (`entity_browser_id`) and via the `entity_browser.browser.widget.entity_form` schema. It requires both Entity Browser and Inline Entity Form. It is a glue module — no admin page of its own, no permissions.

---

- Let editors create a new referenced node/media entity inside a browser via a full entity form.
- Replace IEF complex widget's "add existing" autocomplete with a visual entity browser.
- Choose the entity type, bundle, and form mode the inline form uses.
- Customize the browser submit button text for the entity form widget.
- Attach multiple existing entities to an IEF field through a browser in one pass.
- Combine "create new" (entity form) and "browse existing" widgets in one browser.
- Build a paragraphs-style workflow where sub-entities are created inline.
- Enforce field cardinality when attaching entities via the browser to an IEF field.
- Prevent duplicate references (module validates already-selected entities).
- Configure the integration per field on Manage form display (third-party setting).
- Offer a richer "add existing" UX than autocomplete for large content sets.
- Use a curated View inside the browser to constrain which entities can be attached.
- Create referenced media with required fields filled at selection time.
- Reuse one entity browser across several IEF-backed reference fields.
- Provide a settings summary showing which browser a field widget uses.
- Support decoupled editorial flows needing inline creation plus browsing.
- Migrate autocomplete-based IEF fields to a browser-based experience.
- Let content authors add taxonomy terms inline while referencing them.
- Fill a document/asset reference by uploading through the browser's upload widget.
- Standardize inline creation UX across content types.
