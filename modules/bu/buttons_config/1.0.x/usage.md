<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Buttons Configuration lets an administrator change the text shown on the submit ("Save") button of content type, media type, and comment type add/edit forms, per bundle.

---

Install it like any contributed module (`ddev drush en buttons_config`); it depends only on Drupal core's **Node**, **Media**, and **Comment** modules, which must be enabled. All setup is in the UI at **Administration → Configuration → Content authoring → Buttons Configuration** (`/admin/config/content/buttons-config`), a landing page linking three editable forms — **Content Types**, **Media Types**, and **Comment Types** — each reachable only with the *Admin buttons config* permission. On a form you pick a bundle, choose whether the change applies to the **Save** (add) or **Edit** form, tick **Enabled**, type the replacement text (up to 50 characters) into **Custom Text**, and save; the setting is stored in a plain config object (`buttons_config.node.settings`, `buttons_config.media.settings`, or `buttons_config.comment.settings`). At runtime a global `hook_form_alter` matches the current form id against your saved rows and rewrites `$form['actions']['submit']['#value']`, so the next time an editor opens that type's form the button shows your wording (core escapes the text, so it is safe but not itself translatable per-language — set it in your default language). Note that because of how form ids are built, the content-type options are the most reliable; the media **Edit** option and comment relabeling do not always match a real form id.

---

- Rename the Save button on a content type's add form.
- Rename the Save button on a content type's edit form.
- Say "Publish article" instead of "Save" on a news type.
- Say "Submit application" on a public-facing application content type.
- Say "File report" on an incident-report content type.
- Rename the Save button on a media type's add form.
- Give image uploads a "Add to library" button label.
- Set a per-bundle button label without writing a custom module.
- Keep button wording as site configuration instead of a hidden form alter.
- Reduce editor hesitation caused by a generic "Save" label.
- Reassure anonymous users on a public submission form.
- Match the button word to what the action actually does.
- Avoid promising "Publish" on a moderated content type.
- Configure labels from Administration → Configuration → Content authoring.
- Restrict who can change labels via the Admin buttons config permission.
- Enable or disable a configured label with the Enabled checkbox.
- Limit label text to 50 characters.
- Store the labels in exportable config objects.
- Review current button-text overrides during a site audit.
- Verify the module's form-id matching after a Drupal upgrade.
- Document the button-wording conventions for an editorial team.
