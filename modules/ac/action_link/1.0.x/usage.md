Action Link provides configurable links that perform a state-changing action on your site (toggle a field, cycle options, change workflow state, add to cart) with AJAX, reload, POST-button, or confirmation-form output.

---

Action Link is a framework, not a single feature: each action link is an `action_link` config entity that pairs a **State Action plugin** (the logic — what changes and how) with a **Link Style plugin** (the UX — how the link behaves when clicked). Core ships State Action plugins for boolean, numeric, options, and date fields on any content entity, and Link Style plugins for AJAX in-place updates (with graceful no-JS fallback), full-page reloads, link-styled POST buttons, AJAX POST buttons, and confirmation forms. Links can be placed in a render array with the `action_linkset` element, or output automatically by the bundled submodules into entity links, field formatters, or computed fields. The maintainer positions it as "the UX of Flag" generalised to any action, without Flag's storage layer. Access is enforced per action link (a `use <id> action links` permission) plus the operand entity's own edit/field access, and state-changing links carry a CSRF token where the link style requires one.

---

- Add a "Publish / Unpublish" toggle link to nodes by targeting the `status` boolean field with the `boolean_field` state action.
- Let editors flip any boolean flag field (featured, promoted, sticky, sponsored) directly from a listing without opening the edit form.
- Provide "+1 / -1" increment/decrement links next to a numeric field (votes, stock level, priority) using the `numeric_field` state action with a configurable step.
- Cycle an options/list field forward and back (status categories, size, colour) with the `options_field` state action.
- Add "earlier / later" links that shift a datetime field by a configured `DateInterval` step (event date, deadline) using the `date_field` state action.
- Move a moderated entity through its workflow transitions via clickable links using the Action Link Workflow submodule.
- Build a subscribe / unsubscribe toggle on nodes or comments (proof-of-concept plugin as a starting point).
- Offer an add-to-cart-style repeatable increment link (proof-of-concept plugin as a starting point).
- Render an action link in a block, controller, or preprocess hook with a `#type => action_linkset` render element.
- Show action links automatically in the node or comment links area (Read more / Edit row) with the Action Link Entity Links submodule.
- Output increment/decrement links on either side of a field value inside its formatter with the Action Link Formatter Links submodule.
- Expose an action link as a computed field on an entity type so it appears in Manage Display, using the Action Link Field submodule.
- Give a link the AJAX style so clicking it updates the link (and, in the formatter submodule, the field value) in place with a pop-up confirmation message, without a page reload.
- Fall back automatically to a plain reload link for users with JavaScript disabled, preserving the same action.
- Require a confirmation form before a destructive action by choosing the "Confirmation form" link style.
- Use the POST-button link style for a more CSRF-resistant action than a plain GET link.
- Theme individual links, link sets, and the AJAX pop-up message with template suggestions keyed by action-link ID and state-action plugin ID.
- Customise link labels and status messages per direction/state in the action link's configuration, with token replacement support.
- Restrict who can use each action link with its dedicated `use <id> action links` permission at Admin › People › Permissions.
- Preview and try out a configured action link on its Demo tab before deploying it.
- Extend the system with custom State Action plugins (new kinds of change) or Link Style plugins (new UX behaviours) via attribute-based plugin discovery.
- Add new output locations for action links by writing an Action Link Output plugin.
