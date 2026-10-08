Inactive Autologout logs authenticated users out after a configurable period of inactivity, showing a countdown warning modal before ending the session, with an optional per-role timeout.

---

A lightweight idle-timeout module driven entirely by one config object and a small JS library. When enabled (`inactive_autologout.settings:enable`), `hook_page_attachments()` attaches the `user_autologout` library (jquery.inactivity + a custom script) and passes settings to `drupalSettings` for every authenticated user: the timeout in milliseconds, the base URL, and the warning modal's title and text. The default idle time is `timeout` seconds (minimum 120, validated on the settings form). If **role-based timeout** (`role_based_timeout`) is on, the module looks at the user's roles and, for the first role that is enabled in config (a per-role boolean key), uses that role's `<role_id>_timeout` value instead of the default. The warning modal is fully customizable: `modal_title` and `modal_text`, where `@count` is the placeholder for the live countdown number (HTML allowed). The JS pings back to the module's routes to track activity: `/autologout_active` stores the latest client timestamp in the session, `/autologout_gettimestamp` reads it, and `/autologout` performs the actual `user_logout()` and redirects to the login page. The settings form lives at route `inactive_autologout.admin_settings_form` (`/admin/config/people/autologoutsettings`) behind the `administer inactiveautologout` permission. Config keys: `timeout`, `enable`, `role_based_timeout`, `modal_title`, `modal_text`, plus dynamic `<role_id>` and `<role_id>_timeout` entries. No dependencies beyond core.

---

- Automatically log out staff left idle on an admin workstation after N minutes.
- Meet a security policy that requires inactive sessions to end (e.g. after 15 minutes).
- Warn users with a countdown modal before their session is terminated.
- Customize the warning modal's title (e.g. "Session Expiring").
- Customize the warning text and place the live countdown with the `@count` placeholder.
- Give administrators a shorter idle timeout than regular authenticated users via role-based timeout.
- Give a "kiosk" role a very short timeout while leaving editors a longer one.
- Enforce a minimum 120-second inactivity window (validated by the settings form).
- Protect healthcare/finance back-office screens that display sensitive data when unattended.
- Reduce the risk of unauthorized actions from an abandoned but logged-in browser.
- Enable or disable the whole feature site-wide with a single config flag.
- Roll out autologout via exported `inactive_autologout.settings` config across environments.
- Keep anonymous users unaffected (the library only loads for authenticated users).
- Apply different timeouts per staff role (support, editors, managers) from one settings form.
- Redirect logged-out users to the standard login page automatically.
- Track real user activity through lightweight AJAX timestamp pings rather than full page loads.
- Comply with PCI/HIPAA-style unattended-session requirements on an intranet.
- Localize/translate the modal title and text for a multilingual audience.
- Restrict who can change the autologout policy via the `administer inactiveautologout` permission.
- Provide a gentle UX (countdown + modal) instead of an abrupt silent logout.
- Combine with other session-security modules for defense in depth.
- Set a strict short timeout for a highly privileged role while excluding day-to-day roles.
- Turn the feature on temporarily for an audit period, then disable it again.
