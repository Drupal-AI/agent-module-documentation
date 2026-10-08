<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Add Another speeds up repetitive content entry by offering editors a "Save and add another" button, an "Add another…" message, and an "Add another" tab so they can immediately create the next node of the same type.

---

The module targets high-volume node creation. Per content type it can enable four independent things, all stored in the single `addanother.settings` config object keyed by node type: a **button** ("Save and add another") added to the node add form's actions, a **message** shown after a normal save linking to the add form, a local-task **tab** on node pages that jumps to the add form, and an option to also show that tab on the **edit** page. Global defaults for new content types (`default_button`, `default_message`, `default_tab`, `default_tab_edit`) live on the settings form at `/admin/config/content/addanother`; per-type overrides (`button.<type>`, `message.<type>`, `tab.<type>`, `tab_edit.<type>`) are added to each content type's edit form via `hook_form_BASE_FORM_form_alter()`. The button and message only appear for users with the `use add another` permission, and the tab's access is gated the same way. It is a pure UI/workflow convenience: no fields, entities, or plugins, and it only works with core `node` entities.

---

- Give editors a "Save and add another" button when bulk-entering many articles in one sitting.
- Show an "Add another…" link after each save so a content team can chain node creation without navigating the menu.
- Add an "Add another" tab to node pages for one-click creation of a sibling of the same type.
- Also surface the "Add another" tab on edit pages so reviewers can spin off a new node while editing.
- Configure sensible site-wide defaults for all future content types on the settings form.
- Enable the button only for a "Product" content type while leaving blogs untouched.
- Disable the after-save message on a type where editors found it noisy.
- Restrict who can use the shortcuts by granting `use add another` only to trusted editorial roles.
- Speed up data-entry days (event listings, directory entries, catalog items) where dozens of same-type nodes are created back to back.
- Reduce clicks for a call-center workflow logging many records of one node type.
- Keep the standard Save behavior while adding the extra button, so existing habits are unaffected.
- Turn the shortcuts on for a newly created content type by editing its "Add another settings" section.
- Provide a consistent create-next experience across a multi-editor newsroom.
- Remove the default "… has been created" message and replace it with an actionable "add another" prompt.
- Let a moderator jump straight from a just-reviewed node to creating the next one via the tab.
- Roll shortcuts out gradually by toggling them per content type rather than globally.
- Export the per-type toggles as config (`addanother.settings`) for deployment across environments.
- Offer the button on the add form but suppress the redundant message for the same type.
- Support seasonal data-loading tasks (e.g. importing job postings by hand) with fewer navigation steps.
- Standardize the create-another affordance instead of writing a custom node form alter.
- Give survey/registration-style content types a quick way to add the next entry.
- Encourage prolific tagging/glossary entry by removing friction between saves.
- Keep authors on-task by redirecting to the add form immediately after "Save and add another".
