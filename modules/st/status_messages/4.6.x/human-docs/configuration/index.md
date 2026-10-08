# Configuration

Status Messages has exactly one setting: how long a message stays on screen before
it fades out.

## Open the settings form

1. Log in as a user with the **Administer status messages configuration**
   permission.
2. Go to **Configuration → User interface → Status Messages**, or directly to
   `/admin/config/user-interface/status-messages`.

## Display time

The form has a single **display time** select. Choose one of:

| Option | What it does |
|---|---|
| 5 seconds | Messages fade out quickly — good for reducing clutter. |
| 10 seconds | A short, comfortable default. |
| 15 seconds | A little longer to read. |
| 20 seconds | Keeps messages up longer, useful for errors. |
| Never | Messages stay until the visitor dismisses them with the × button. |

Pick a value and click **Save configuration**. The choice is passed to the popup's
JavaScript, which times the fade accordingly.

> **First‑run note:** the module ships no default configuration, so on a fresh
> install the display time is unset until you save this form once. Saving it even at
> the default value ensures the auto‑fade behaves predictably.

## Permission

| Permission | Controls |
|---|---|
| `administer status messages configuration` | Access to the settings form above |

Grant this to any role that should be able to change the auto‑fade time.
