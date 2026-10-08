# Configuration

Entity Abuse needs configuration before it does anything visible. This page walks
through the settings form, the report entity's fields and display, and the
permissions that decide who can report and who can review.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Structure → Entity abuse**, or navigate directly to
   `/admin/structure/entity-abuse`.

## The main settings

- **Enabled** — the list of content types (and other content entities) that should
  carry an "Add complaint" link. Tick every type you want users to be able to
  report. Nothing can be reported until you enable at least one here.
- **Report link behavior** — what happens when a user clicks the "Add complaint"
  link (for example how the report form is presented).
- **When cancelling a user account** — what to do with the reports a user
  submitted if that user's account is later cancelled.
- **No access behavior** — what a user without permission to report sees. One
  option hides the report link entirely; another still shows the link and then
  displays a "no access" message when it is clicked.

## Report adding, editing, and cancelling tabs

The form groups the button labels and status messages under three tabs so you can
word them to suit your site:

- **Report adding** — the label for the *Add report* button, the confirmation
  message shown once a report is added, and the "you have no access" message (this
  last one only appears when **No access behavior** is set to still show the report
  link).
- **Report editing** — the label for the *Edit report* button and the message shown
  once a report is updated.
- **Report canceling** — the label for the *Cancel report* button, the message
  shown once a report is cancelled, and the confirmation prompt shown before
  cancelling.

Click **Save configuration** when you are done.

## Translating the labels and messages

If you enable core's **Configuration Translation** module, a **Translate entity
abuse** tab appears on the settings page. Use it to provide translations of the
button labels and messages you entered above.

## The report form's fields and display

Because reports are content entities, you shape the report form itself from two
tabs in the same admin area:

- **Manage fields** (`/admin/structure/entity-abuse/fields`) — the fields a report
  collects. Out of the box there is a single **Message** field
  (`entity_abuse_report`) using the *Text (formatted, long)* type. Add more fields
  here if you want reporters to supply extra detail.
- **Manage form display** (`/admin/structure/entity-abuse/form-display`) — how
  those fields are laid out on the report form. By default the **Message** field is
  shown as a multi-row text area.

You also control where the "Abuse report link" appears on each reportable content
type from that content type's **Manage display** tab, per view mode.

## Permissions

Finally, set who can do what at **People → Permissions**
(`/admin/people/permissions#module-entity_abuse`):

- Grant the ability to **add** reports to the roles that should be able to flag
  content. Think carefully before granting this to anonymous users — see the note
  about spam and flood control in the [overview](../index.md).
- If a role can **edit own** (or **edit any**) abuse report, an *Edit* link appears
  after a report is added.
- If a role can **delete own** (or **delete any**) abuse report, a *Delete* link
  appears after a report is added.
- Restrict who can **view** the collected reports to your moderators, since reports
  can contain user-submitted text and accusations about other users.
