Surfaces status-related messages — including selected core status-report errors and warnings, plus admin-defined notices — through Drupal's messenger via a small pluggable message system.

---

Admin Status Report provides a lightweight, plugin-based way to broadcast operational status messages inside a Drupal site. It defines an "AdminStatus" plugin type; each plugin returns one or more messages (each with a status level: status, warning, or error) that are pushed through Drupal's messenger on page requests. Two plugins ship in the box: "Core Status Report" pulls selected error and/or warning items straight from the core status report at /admin/reports/status and re-displays them as messages, and "Default Message" lets an administrator compose a single fixed message with a chosen severity. Which plugins are active, and their per-plugin options, are configured on one settings form at Administration > Configuration > System > Admin Status Report (guarded by the "administer admin status report" permission) and saved into the admin_status_report.settings configuration object. A kernel.request event subscriber reads that configuration on each request and renders the enabled plugins' messages. Developers can add their own message sources by writing additional AdminStatus plugins. Note: the project is flagged obsolete/unsupported on drupal.org.

---

- Re-surface core status-report errors and warnings as on-page messages so operators notice them without visiting /admin/reports/status.
- Show a persistent, admin-authored maintenance or policy notice to users.
- Highlight only error-level (or only warning-level) core requirements, filtered by the admin's choice.
- Give operators a running reminder that something on the status page needs attention.
- Broadcast a scheduled-maintenance banner-style message via the messenger.
- Surface configuration warnings (e.g. cron, updates) into everyday admin workflow.
- Display a custom "status" confirmation-style message site-wide.
- Toggle each message source on or off independently from one settings form.
- Choose per-plugin whether errors, warnings, or both are echoed.
- Provide a simple, no-code way to promote existing core requirement messages.
- Add a bespoke message source by implementing a new AdminStatus plugin.
- Reuse Drupal's standard message rendering/theming rather than a custom UI block.
- Configure everything through one form under Configuration > System.
- Restrict who can manage these messages via the "administer admin status report" permission.
- Store the whole configuration in a single exportable config object (admin_status_report.settings).
- Prototype a status-notification feature quickly on a development site.
- Combine multiple message sources (core report + a custom notice) at once.
- Show a temporary announcement without editing theme templates.
- Extend the Core Status Report plugin's severity filter for tailored alerting.
- Serve as a reference example of a Drupal plugin type wired to a kernel.request subscriber.
