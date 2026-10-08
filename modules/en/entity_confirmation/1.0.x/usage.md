<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Confirmation customizes or suppresses the status message shown after an entity is created, edited, or deleted.

---

Entity Confirmation lets you **replace, or turn off, the default "X has been created/updated/deleted" status
message** on a per-entity-form-display (form-mode) basis. On each form mode's *Manage form display* page it adds a
*Confirmation settings* section with a textarea and a "disable" checkbox for the create, edit, and delete operations.
When an entity is saved through that form mode, the module removes the default status message and, if you entered
custom text, shows that instead. Custom text supports **tokens** for the entity type (when the Token module is
enabled) and is passed through `Xss::filterAdmin()`, so basic admin HTML is allowed. Other modules and themes can
change the final message through `hook_entity_confirmation_alter()`. It is purely a message/UX feature: it defines no
routes, permissions, entities, or services, and it does **not** change post-save redirects.

---

- Replace the default node "has been created" message with custom wording.
- Replace the default "has been updated" message on edit.
- Replace the default "has been deleted" message on delete.
- Suppress (hide) the default create confirmation message entirely.
- Suppress the default edit confirmation message.
- Suppress the default delete confirmation message.
- Configure different messages for different form modes of the same content type.
- Set a friendlier confirmation for a specific bundle's default form.
- Include the saved entity's title or fields in the message via tokens.
- Add basic admin HTML (e.g. links, emphasis) to a confirmation message.
- Tailor confirmation wording for editors of a custom entity type.
- Give taxonomy term forms a custom save message.
- Give media entity forms a custom save message.
- Give user-registration/edit forms a custom confirmation.
- Show a call-to-action after content is created.
- Reduce noise by silencing routine save messages in an editorial workflow.
- Adjust messaging per form mode without writing a custom module.
- Alter a confirmation message programmatically from another module.
- Alter a confirmation message from a theme's `.theme` file.
- Provide consistent branded save feedback across content types.
- Localize/customize confirmation text for a specific entity form.
- Present next-step instructions to editors right after saving.
- Keep the create message but disable only the delete message (or any mix).
