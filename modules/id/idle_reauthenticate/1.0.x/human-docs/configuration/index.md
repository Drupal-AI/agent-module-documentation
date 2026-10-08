# Configuration

Reauthenticate on idle browser has a small settings form where you decide **how
long** a session may sit idle and **how** a returning user proves who they are.
Open it as a user with permission to administer the module's settings; the form
lives under **Configuration**.

## Idle time before re‑authentication

Set the period of inactivity that must pass before the module blocks the session
and shows the re‑authentication dialog. Choosing this value is a balance: a
shorter idle time is more secure (a walked‑away browser is locked sooner) but
interrupts active users more often; a longer time is gentler on users but leaves
a bigger window on an unattended machine. Pick a value that matches how sensitive
the data behind the login is and where the machines physically sit (a locked
office versus a shared public terminal).

## Allowed re‑authentication methods

Choose which methods the returning user may use to unlock the session from the
modal dialog:

- **Password** — the user re‑enters their account password. This is the primary
  method available today.
- **Log in as a different user** — lets someone else take over the same browser
  by signing in with their own account, useful on machines shared between staff.

The maintainers note two further methods as **planned**: re‑authentication with a
user‑defined token, and re‑authentication with 2FA. Enable only the methods you
want to permit.

## What the module blocks (good to know)

When the idle timeout is reached, the module blocks the **entire session**, not
just the current tab — so a user cannot dodge the prompt by opening a second tab.
It deliberately does **not** invalidate the session, so any half‑completed work
(an open, partly filled form, for example) is preserved and the user can continue
right where they left off once they re‑authenticate.

## Save

Click **Save configuration**. The new idle time and allowed methods take effect
for subsequent sessions.
