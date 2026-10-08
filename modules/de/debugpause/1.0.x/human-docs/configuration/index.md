# Configuration

Debug Pause has a small settings form with just two options — how long it waits
before pausing, and whether the toolbar button shows a text label.

## Open the settings form

1. Log in as a user with the **Use debug pause** (`use debug pause`) permission.
2. Go to **Configuration → Development → Debug Pause**
   (`/admin/config/development/debugpause`).

## Settings, field by field

- **Pause delay** (`pausein`) — how long, after you click the toolbar button, the
  module waits before invoking the JavaScript debugger and freezing the page. This
  is the whole point of the module: set it long enough to perform the interaction
  you want to capture (open the dropdown, trigger the hover state, and so on)
  before execution halts. Shorten it once you know exactly when you need the pause.
- **Display button title** (`displaytitle`) — a toggle for whether the toolbar
  button shows its text title or appears more compactly. Purely a matter of
  preference for how the button looks in your toolbar.

Click **Save configuration** to apply your changes.

## Verify

With DevTools open, click the Debug Pause button and count — after roughly the
delay you set, JavaScript execution should pause in the debugger. If it doesn't
pause at all, the most common cause is that DevTools isn't open.
