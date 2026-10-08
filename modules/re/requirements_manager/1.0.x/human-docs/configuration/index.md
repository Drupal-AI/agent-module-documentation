# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Requirements Manager**, or navigate directly to
   `/admin/config/system/requirements-manager`.

The form scans your site's current Status Report and lists **every requirement** it
finds, one per row. Each row shows the requirement's key, its title, and its current
severity, followed by the controls you use to override it.

## The controls, column by column

For each requirement you can set:

- **Action** — what to do with this row:
  - **Show** *(default)* — leave the requirement exactly as it is. Nothing is stored
    for rows left on Show.
  - **Hide** — remove this row from the status report entirely.
  - **Change severity** — keep the row but override how serious it looks.
- **New Severity** — appears only when the action is *Change severity*. Pick one of
  **Info**, **OK**, **Warning**, or **Error**. This remaps the row's severity to the
  value you choose.
- **Reason** — a free-text note, offered for both *Hide* and *Change severity*. Use
  it to explain *why* you made the change so the next administrator understands. For
  a severity change, this reason is shown on the status report itself, appended to
  the requirement's description alongside an automatic note that reads roughly
  *"Severity altered from X to Y state by Requirements Manager. Reason: …"*.

## Save and check the result

Click **Save configuration**, then reload **`/admin/reports/status`** to see the
effect: hidden rows are gone, and severity-changed rows show at their new level with
the audit note attached.

Only your non-default choices are actually stored (in the module's
`requirements_manager.settings` configuration), so the form stays lightweight and
your config export only carries the overrides you've deliberately made.

## Reversing a change

To undo an override, come back to the form and set the row's action back to **Show**,
then save. Rows you previously hid are still listed here (marked as hidden by this
module), precisely so you can find them again and un-hide them.

## What overrides do — and don't — do

These settings change only the **display** of the status report. Hiding a warning or
downgrading an error does not fix, silence, or alter the underlying condition the
requirement is checking — the problem (or the reason for the check) is still there.
Treat this as a tool for curating attention and reducing alert fatigue on
purpose-built environments, not as a fix for the issues themselves.

## Deploying overrides across environments

Because the overrides live in the `requirements_manager.settings` config object, you
can export them and import them elsewhere to apply the same curated status report on
staging, production, and so on. Developers can also set the overrides
programmatically for deployment — see the [`agent/`](../../agent/start.md) docs for
the config structure.
