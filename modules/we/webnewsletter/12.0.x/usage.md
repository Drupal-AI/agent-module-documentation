WebNewsletter turns a public Webform subscribe form into a managed list of newsletter subscriber records stored as Drupal entities.

---

WebNewsletter is built on the Webform module (part of the web* / Webship suite). It ships a `webnewsletter_subscribe` Webform handler plugin and a default recipe that installs a ready-made "Newsletter Subscribe" webform at `/newsletter/subscribe`. When someone submits that form, the handler creates a `webnewsletter_emails` content entity holding the subscriber's email, name and active status, de-duplicating by email. Site staff manage those records through a dedicated admin list at `admin/config/webnewsletter/emails` (with a running subscriber count) plus revisionable add/edit/delete forms, all gated by fine-grained per-operation permissions (view/create/edit/delete, plus an "administer" permission for the settings tab). The subscribe form is intentionally open to anonymous and authenticated users; the management UI is restricted to permission holders. The bundled recipe also wires an email-confirmation handler that thanks the subscriber. Version 12.0.1 adds Drupal 12 support (`^11.4 || ^12`) and requires Webform `~6.3.0`.

---

- Collect newsletter sign-ups from a public Webform at `/newsletter/subscribe`.
- Store each subscriber as a revisionable `webnewsletter_emails` entity (email, name, status, author, created/changed).
- Automatically create a subscriber record on webform submission via the `webnewsletter_subscribe` handler.
- De-duplicate subscribers by email so a repeat submission does not create a second record.
- Review all subscribers in a sortable admin list with a live "Total subscribers" count.
- Add subscribers manually through the "Add web newsletter emails" action link.
- Edit a subscriber's email, name or active status through the entity edit form.
- Delete subscribers with the standard confirm form (CSRF-protected).
- Mark subscribers active or inactive with the boolean status field for opt-out handling.
- Attach the `webnewsletter_subscribe` handler to any of your own webforms that have `email` and `name` fields.
- Send a confirmation ("Thank you for joining us") email to new subscribers via the recipe's email handler.
- Restrict who can view the subscriber list using the `view` / `administer web newsletter emails` permissions.
- Delegate subscriber data-entry to an editor role via the granular create/edit/delete permissions.
- Expose subscriber data to Views through the entity's `EntityViewsData` for custom reports or blocks.
- Track who added each subscriber via the author (uid) base field.
- Apply the default recipe on standalone install, or list it from a parent recipe for a site build.
- Build a marketing/audience list that other mail-sending tools can consume.
- Keep an audit trail of subscriber changes through entity revisions (`show_revision_ui`).
- Place the subscribe webform on its own page, in a block, or embed it in content.
- Customise the subscribe form (fields, confirmation message, redirect) through the standard Webform UI.
- Manage subscriber-entity fields and displays via Field UI on the entity settings route.
