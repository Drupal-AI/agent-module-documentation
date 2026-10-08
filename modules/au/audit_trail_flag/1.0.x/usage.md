Audit Trail Flag records every flag and unflag action from the Flag module as an entry in the Admin Audit Trail log.

---

Audit Trail Flag is a small bridge module: it registers a `flag` handler with Admin Audit Trail and subscribes to the Flag module's flagging/unflagging events. Whenever an entity is flagged or unflagged, an event subscriber writes an audit-trail row capturing the operation (`flagged`/`unflagged`), the flag label and machine id, and the affected entity's type, label, and id. There is nothing to configure — enabling the module (with `admin_audit_trail` and `flag`) is enough; log entries appear immediately under the Admin Audit Trail report, where they can be filtered by the `flag` type. It provides no routes, permissions, config, or Drush commands of its own; viewing and clearing the log is handled entirely by Admin Audit Trail.

---

- Record who flagged or unflagged content for accountability and compliance auditing.
- Track moderation activity when flags are used to mark content as "reported", "spam", or "reviewed".
- Keep a history of "bookmark", "favorite", or "interested" flags applied to nodes, users, or other entities.
- Audit bulk unflag operations — each affected flagging is logged as its own entry.
- Filter the Admin Audit Trail report by the `flag` log type to see only flag activity.
- Correlate flag events with other logged actions (node, user, comment, etc.) in one central audit trail.
- See the human-readable description of each event, e.g. `Interested in: node Basic Page`.
- Identify the exact entity involved via the numeric reference (entity id) stored on each entry.
- Identify the exact flag involved via the char reference (flag machine id) stored on each entry.
- Monitor use of custom flags across any flaggable entity type (nodes, users, comments, taxonomy terms, media, etc.).
- Provide an evidence trail for content-governance workflows that rely on flags.
- Detect unusual flagging patterns (spikes in flag/unflag activity) from the audit log.
- Support incident review by reconstructing when a flag was set or removed.
- Add flag visibility to sites that already standardize on Admin Audit Trail for logging.
- Integrate flag logging without writing custom code — the module wires itself up on enable.
- Export or report on flag activity using any tooling that reads Admin Audit Trail entries.
- Confirm that automated or programmatic flagging (via the Flag API) is being logged the same as UI actions.
- Retain a record of flag removals even after the flagging entity itself is deleted.
