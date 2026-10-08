# Configuration

Events Logger needs a little setup before it records anything: you tell it which
modules' events and which forms to track, decide what the log messages say, and
set how many entries to keep. Configuration is split across two forms, and the
results appear in the logs listing.

## Grant permissions first

Events Logger ships granular permissions — assign them carefully at **People →
Permissions** (`/admin/people/permissions`):

- **Administer elogger configurations** — change what is tracked and how.
- **View event log entity** — read the audit trail.
- **Delete event log entity** — remove entries. Grant this sparingly: whoever
  holds it can delete the evidence, which matters when the trail is relied on for
  compliance.
- **Administer event log entity** — full management of log entities.

## Filter configuration — choose what to track

Go to **Configuration → System → Events Logger** (`/admin/config/system/elogger`).
Here you decide the scope of logging:

- Select which **modules' events** to track (entity create/update/delete and
  similar CRUD actions).
- Choose specific **forms** whose submissions to log — or opt to track all forms
  on the site, including custom ones.
- Set the **retention limit**: how many log entries the system should keep. A cron
  job prunes older entries beyond this limit. Because each entry stores a diff and
  can be large, set a sensible limit so the table does not grow without bound.

The same page also provides the filters used when browsing the logs listing.

## Log message configuration — set the wording

Go to **Configuration → System → Events Logger → Log Messages**
(`/admin/config/system/elogger/log-messages`). Here you define the system message
recorded for each kind of tracked event. Messages support **tokens**, so you can
include contextual detail (the acting user, the entity, and so on) in each logged
message.

## View, filter, and export the logs

Go to **Reports → Events Logger** (`/admin/reports/elogger`) to browse the trail.
Because the listing is built with Views, you can filter entries, open an entry to
see the **diff** of what changed, **export** the data for an auditor (via Views
Data Export), and act on multiple entries at once (via Views Bulk Operations).

## A privacy note

Remember that the log inherits the sensitivity of whatever it records. If tracked
entities contain personal data, the audit trail contains personal data too — give
it the same lawful basis, retention policy, and access restrictions you apply to
the underlying content, and inform users where required (for example in your
cookie/GDPR policy).
