<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate the Collabora Online / CODE office suite into Drupal so users can view and edit office documents (ODF and MS Office formats) directly in the browser, with permissions driven by Drupal's own user and media access system.

---

Collabora Online (COOL) connects a Drupal site to a Collabora Online / CODE server — an online office suite built on LibreOffice that supports collaborative, simultaneous editing of Open Document and Microsoft Office files. Documents live as Drupal **media** entities with a single attached file. Drupal acts as the **WOPI host**: when a user opens a document it embeds the Collabora editor in an iframe and mints a short-lived signed access token, and the Collabora server then calls back to Drupal's WOPI endpoints to load the file and, on save, write the edited version back — creating a new file revision or overwriting in place depending on the configured interval. Who may view or edit is decided entirely by Drupal permissions: the module adds per-media-type "preview" and "edit" permissions (with published / own-unpublished and any / own variants), and every entry point re-checks them. The Collabora server URL and the JWT signing secret are configured by an administrator, the secret being stored through the **Key** module rather than in plain configuration. An optional `collabora_online_group` submodule extends this to the Group / Group Media modules so document access can follow group membership.

---

- View office documents (docx, odt, xlsx, ods, pptx, odp, etc.) inline in the browser without downloading them.
- Edit documents in a full-page Collabora editor and save changes straight back into the Drupal media entity.
- Offer collaborative, simultaneous editing backed by a Collabora Online / CODE server.
- Preview a document read-only in an embedded iframe or an AJAX modal dialog via field formatters.
- Add "View in Collabora Online" / "Edit in Collabora Online" operations to media admin listings and Views.
- Gate viewing and editing per media type with dedicated Drupal permissions (published vs own-unpublished, edit any vs edit own).
- Keep document access under Drupal's control by acting as a WOPI host that binds each access token to a specific document and user.
- Store the JWT signing secret securely through the Key module instead of in configuration.
- Automatically create a new file revision on save (or overwrite within a configurable time window).
- Verify the authenticity of incoming Collabora requests with the WOPI proof (RSA signature) mechanism.
- Extend document access control to group membership with the Collabora Online Group submodule.
- Support both the community CODE build and commercially licensed Collabora Online servers.
- Mark formats Collabora cannot edit (e.g. Apple iWork) as view-only automatically.
- Configure token lifetime, discovery caching, and iframe fullscreen behaviour from an admin settings form.
- Run Drupal and Collabora on separate hosts/networks by configuring distinct server and WOPI base URLs.
