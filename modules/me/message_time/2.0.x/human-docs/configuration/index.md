# Configuration

Message Time has a single, focused settings form: it controls how long status
messages remain visible before they auto-dismiss.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Message Time**, or navigate directly to
   `/admin/config/user-interface/message-time`.

## Set the display duration

The form lets you set the **time delay** — how long a status message stays on screen
before it fades out. The value is a duration in milliseconds (for example 10000 ms =
10 seconds). Choose a value that balances a tidy interface against giving people
enough time to read the message:

- A **shorter** delay clears the screen quickly, which suits brief success
  confirmations.
- A **longer** delay is safer for messages users need to actually read, such as
  warnings and errors — remember that once the message disappears, it is gone.

## Save

Click **Save configuration**. The new duration applies immediately — trigger a status
message (save a node, for example) and confirm it dismisses itself after the interval
you set.
