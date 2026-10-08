# Configuration

Read Only Mode doesn't have a settings page of its own — its controls are added as
a **Read Only Mode** section on the core Maintenance mode form. Everything is saved
as configuration, so you can toggle and deploy the lock like any other setting.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Maintenance mode**, or navigate directly
   to `/admin/config/development/maintenance`.
3. Expand the **Read Only Mode** section.

## Turn read-only mode on or off

The master switch is a checkbox in that section. When it's **on**, non-allowed
forms are blocked; when **off**, the site behaves normally. You can also toggle it
from the command line, which is handy in a deployment script:

```bash
drush cset readonlymode.settings enabled 1 -y   # turn read-only ON
drush cset readonlymode.settings enabled 0 -y   # turn read-only OFF
```

## Messages and redirect

- **Warning message** — shown on any page that contains a blocked form, letting
  visitors know why they can't submit. The default wording is editable, and tokens
  are supported.
- **Not-saved error** — shown when someone submits a form that's blocked (which can
  happen if they started filling it in before the lock came on).
- **Redirect URL** (optional) — an internal path. If you set it, users who try to
  edit are redirected there (for example a status page) instead of seeing the
  warning. It must be an internal path.

## Allow specific forms while locked

Read Only Mode ships with a sensible allow-list so essential forms keep working —
login, password reset, the search form, exposed Views filters, and the maintenance
settings form itself (so you can always turn the lock back off), among others. You
extend it with two fields, each taking **one form ID per line**:

- **Additional forms that may be submitted** — forms that stay fully functional
  during read-only. Wildcards work here: `webform*` keeps every webform
  submittable, and you can also name a single form such as a contact form.
- **Additional forms that may be shown but not submitted** — forms that remain
  visible but still reject submission.

From the command line, remember these are newline-separated strings:

```bash
drush cset readonlymode.settings forms.additional.edit $'webform*\ncontact_message_feedback_form' -y
```

## Save

Click **Save configuration** on the Maintenance mode form.

## Permissions

Read Only Mode adds two permissions, set on **People → Permissions**:

- **Access forms** (`readonlymode access forms`) — **bypass the lock.** Users with
  this permission can submit any form even while read-only mode is on. Grant it to
  administrators (and any role that must keep editing during a freeze).
- **Access messages** (`readonlymode access messages`) — **see the notices.**
  Controls who is shown the on-page warning and the rejected-submission error.
  Give it to staff so they understand why submissions are blocked.

A typical setup: administrators get *Access forms*, editorial staff get *Access
messages*, and anonymous visitors get neither (they simply can't submit, and see
the friendly warning if you've granted it).

## The Read Only Mode block

The module includes a **Read Only Mode** block that displays the maintenance notice
(site name plus your warning) whenever read-only mode is on. Place it in a region
via **Structure → Block layout** like any other block if you want the notice to
appear somewhere consistent, such as a sidebar.
