<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form block turns four everyday Drupal forms — the node add form, the site-wide contact form, the user registration form and the request-new-password form — into placeable block plugins, so they can be dropped into any region, Layout Builder section or Panels pane.

---

The module ships no routes, no services, no permissions, no settings form and no configuration schema. It is four `@Block` plugins plus one `hook_entity_type_alter()`. `formblock_node` ("Content form") renders `entity.form_builder`'s form for a freshly created, unsaved node of a configured content type, optionally prefixed by that content type's submission guidelines, and delegates access to the node access control handler's `createAccess()`. `formblock_user_register` ("User registration form") renders the user entity form in a configurable form mode and hides itself when `user.settings:register` is set to administrators-only for non-administrators. `formblock_contact` ("Site-wide contact form") builds an unsaved `contact_message` for a configured contact form entity, honours core's contact flood limits (showing the "you cannot send more than N messages" text instead of the form), and requires the `access site-wide contact form` permission. `formblock_user_password` ("Request new password form") simply builds `Drupal\user\Form\UserPasswordForm` and has no settings at all. All four are categorised under **Forms** in the block library. The `hook_entity_type_alter()` implementation copies the default entity form handler class onto every node and user *form mode* that does not already declare one, which is what makes the per-block "Form mode" selector actually work.

---

- Put a "Submit an event" node form directly on the front page instead of linking to `/node/add/event`.
- Add a contact form block to the footer of every page.
- Drop a user registration form into a Layout Builder section on a landing page.
- Place a "Request new password" block on a custom login page built with Layout Builder.
- Build a marketing landing page in Panels that ends with an inline lead-capture node form.
- Show a "Post a job" form in the sidebar of a jobs listing view.
- Render a node form in a specific form mode so a public-facing block shows fewer fields than the admin form.
- Show the content type's submission guidelines above an embedded node form for anonymous submitters.
- Offer a simplified "quick registration" block using a custom user form mode.
- Give a community site an inline "Ask a question" form on the forum overview page.
- Combine a node form block with block visibility conditions so it only appears on selected pages.
- Add a contact block that targets a specific contact form (department, sales, support) per region.
- Put a support-request form in a modal-friendly block region for a help centre.
- Expose a node form block only to a specific role by using core's block role visibility condition.
- Replace a custom "embed the node form" controller with a configurable block.
- Use the node form block inside a Layout Builder default so every page of a bundle gets an inline submission form.
- Provide a "Suggest a link" block in a resource directory site.
- Add an inline testimonial submission form to a product page layout.
- Provide a registration block on a members-only landing page while core registration is still open.
- Let the block hide itself automatically when the current user lacks create access for the content type.
- Rely on the block's flood-control message so an embedded contact form degrades gracefully under abuse.
- Give editors a way to place forms without writing any custom render-array code.
- Put a password-reset block in the same sidebar as a login block for a single-page account recovery flow.
- Add a node form block to a Views page's "no results" area via Layout Builder.
- Support decoupled-ish page composition where the form is one component among many on the page.
