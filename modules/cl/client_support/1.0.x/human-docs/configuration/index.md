# Configuration

There are two things to set up: **which support destination the Support tab points to** (the
module's own setting), and, if you use the bundled Contact Form, **where its submissions are sent**
(a core Contact form setting).

## 1. Choose the active support plugin

1. Log in as a user with the **`administer client support`** permission.
2. Go to **Configuration → Client Support** (`/admin/config/client-support`), then open
   **Client Support Settings**
   (`/admin/config/client-support/client-support-settings`) — also reachable via the *Configure*
   link on the **Extend** page.
3. Pick a **Support plugin** from the dropdown and save. With the **Client Support - Contact Form**
   submodule enabled, choose **Contact Form Integration** — the Support tab will then redirect to
   the Support Form.

The dropdown lists every installed support-integration plugin. If it's empty, no plugin is
installed yet: enable the Contact Form submodule or add a custom plugin. Until a plugin is selected,
the Support tab does not appear in the toolbar.

## 2. Set the recipient email (Contact Form submodule)

The Support Form is a normal core Contact form, so its recipient address is configured with core's
Contact tools, not on the Client Support settings form:

1. Go to **Structure → Contact forms** (`/admin/structure/contact`).
2. Edit **Support Form** and set the **Recipients** to the address(es) that should receive support
   requests — typically the developers or maintainers who look after the site. The submodule ships
   a placeholder default of `webmaster@example.com`, so change this before going live.

Every submission is then emailed to that address, including the submitter's name and email, the
message, the chosen severity, any issue URLs, and any attachments.

## Who can use the form

Access is controlled by permissions rather than by the settings form:

- **`access client support`** — the roles that can see and use the Support tab.
- **`administer client support`** — the roles that can reach the settings form and choose the
  plugin.
- For the Contact Form destination, users also need core's **"Use the site-wide contact form"**
  permission to submit the form.

Because support requests can carry personal data, keep the `administer client support` permission
limited to actual support staff, and make sure the recipient address goes to a mailbox that's
monitored and appropriate for that data.

## After saving

Submit a test request as a user who has `access client support` and confirm the configured
recipient receives the email with the expected context.
