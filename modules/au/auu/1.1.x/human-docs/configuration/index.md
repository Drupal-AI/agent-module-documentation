# Configuration

Auto unblock users has no settings page of its own. Instead it **adds its options
to the Login Security settings form**. All of its configuration is stored in the
`auu.settings` config object.

## Open the settings form

1. Log in as a user who can administer Login Security (an administrator by
   default).
2. Go to the **Login Security settings** form (`login_security.settings`) — the
   same form where you set Login Security's failed‑attempt thresholds and block
   behavior.

Look for the extra fields Auto unblock users injects there.

## The fields it adds

- **Automatically unblock users** (`auu_user`) — the master switch. When ticked,
  any account that Login Security temporarily blocked is re‑enabled automatically
  once the configured block window has elapsed. Leave it off and the module does
  nothing.
- **Show a message to the unblocked user** (`auu_message_opt`) — when ticked, the
  user is shown a message at the point their account is unblocked. This field is
  hidden unless automatic unblocking is turned on.
- **Message text** (`auu_message`) — the wording of that message. Also hidden
  unless the message option above is enabled.

## How the timing works

The unblock is not instant — it happens once **Login Security's own block window**
has passed. In other words, Auto unblock users piggybacks on the timeout you have
already configured in Login Security. Keep those thresholds sensible: set them too
short and accounts are freed almost immediately, which weakens the brute‑force
protection you installed Login Security for in the first place.

## Save and test

Save the Login Security form. To verify: trigger a temporary block by failing
login enough times, then wait for the block window to expire and confirm the
account is usable again (and that your message appears, if you enabled it).
