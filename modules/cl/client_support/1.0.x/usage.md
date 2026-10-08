Adds a "Support" item to the Drupal admin toolbar that sends users to a support destination, chosen from pluggable integration plugins; an optional submodule wires it to a core Contact Form.

---

Client Support is a small, extensible bridge between site users and a support channel. The base module adds a right-floated "Support" tab to the admin toolbar and a route (`/client-support`) that redirects the clicker to wherever the active *SupportIntegration* plugin points. It does not itself render a form or send email — it only dispatches to a plugin's redirect target. On a settings form (`/admin/config/client-support/client-support-settings`) an administrator picks which integration plugin is active, and the toolbar tab stays hidden until a plugin exists, one is selected, and the user holds the `access client support` permission. Developers extend it by adding a plugin under `Plugin/SupportIntegration` that extends `SupportIntegrationBase` and returns a redirect from `redirect()`. The bundled `client_support_contact_form` submodule is the reference plugin: it redirects to a core Contact Form named "Support Form", which it ships preconfigured with severity, issue-URL and file-attachment fields, so submissions are emailed to a recipient address you set. Two permissions gate the feature: `access client support` (use the Support link) and `administer client support` (choose the plugin). Supports Drupal 10 and 11.

---

- Add a one-click "Support" entry point to the admin toolbar for editors and clients.
- Redirect users from that entry point to any support destination behind a plugin.
- Keep the base module lightweight — no form, no mailer, just a dispatcher.
- Choose the active support destination from a settings form.
- Hide the toolbar tab automatically until a plugin is configured and the user has access.
- Extend support behaviour by writing a `SupportIntegration` plugin (redirect-based).
- Reuse the reference `client_support_contact_form` submodule for an out-of-the-box channel.
- Point the toolbar at a core Contact Form ("Support Form") via the submodule.
- Collect a severity level (Low / Medium / High / Critical) on the support form.
- Let submitters attach files and add relevant issue URLs on the form.
- Email support submissions to a configured recipient address (via core Contact).
- Gate use of the Support link with the `access client support` permission.
- Gate configuration with the `administer client support` permission.
- Serve client portals or membership sites needing a built-in support link.
- Route support requests to developers or site maintainers.
- Support Drupal 10 and 11.
- Add the Support tab to the admin theme's toolbar with a question-mark icon.
- Swap the support target without code by changing the selected plugin.
- Provide a redirect to a node, a route, an external help desk, or a contact form.
- Restrict administration to trusted support staff handling personal data.
