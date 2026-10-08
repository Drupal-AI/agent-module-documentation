# Configuration

Lightning Scheduler works as soon as it's enabled — the settings form only tunes
two behaviors. The more important setup step is granting the right permissions so
editors can actually queue transitions.

## Open the settings form

1. Log in as a user with the **Administer Lightning Scheduler** permission (grant
   this only to trusted admins — it is marked security-sensitive).
2. Go to **Configuration → System → Lightning → Scheduler**, or navigate directly
   to `/admin/config/system/lightning/scheduler`.

The form has two fields, stored in the `lightning_scheduler.settings` config
object.

### Time step

This sets the precision of the time picker editors use when scheduling a
transition — technically the HTML `step` value on the time input, measured in
**seconds**. The allowed choices are:

- **1 second**
- **1 minute** (`60`) — the default
- **5 minutes** (`300`)
- **10 minutes** (`600`)
- **15 minutes** (`900`)
- **30 minutes** (`1800`)
- **1 hour** (`3600`)

Pick a coarser step (say 15 or 30 minutes) if you don't need editors scheduling
down to the exact minute; pick a finer one if precise timing matters.

### Allow past dates

A checkbox controlling whether an editor may schedule a transition for a date or
time that has already passed. When **checked** (the default), past dates are
allowed. When **unchecked**, the form's validation rejects any scheduled time in
the past. Leaving it on can be handy for backdated workflows or testing; turning
it off prevents editors from accidentally queuing a transition that would fire on
the very next cron run.

Click **Save configuration** to apply your changes.

### Setting these from the command line

```bash
drush cget lightning_scheduler.settings
drush cset lightning_scheduler.settings time_step 900 -y
drush cset lightning_scheduler.settings allow_past_dates 0 -y
```

## Permissions

Beyond the admin permission above, Lightning Scheduler generates a **scheduling
permission for every transition** in every Content Moderation workflow. These
mirror core's transition permissions but with a "schedule" twist — for an
`editorial` workflow, for example, you'd see:

- `schedule editorial transition publish`
- `schedule editorial transition archive`
- `schedule editorial transition create_new_draft`

...one per transition your workflows define. A role needs the matching
`schedule …` permission to queue that particular transition on content. Grant
these on the **People → Permissions** page (`/admin/people/permissions`) to the
editor roles that should be allowed to schedule each change.

This list stays empty until at least one Content Moderation workflow with
transitions exists, so configure your workflow first, then assign the scheduling
permissions.
