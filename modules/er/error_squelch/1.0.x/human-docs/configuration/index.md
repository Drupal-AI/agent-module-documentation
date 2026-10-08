# Configuration

Error Squelch does nothing until you give it patterns to match. You manage those
either from the settings form or from the command line.

## Open the settings form

1. Log in as a user with the **Administer Error Squelch** permission.
2. Open the Error Squelch settings form via the module's **Configure** link on the
   **Extend** page.

## The pattern list

The heart of the form is the list of **patterns** to suppress. For each pattern you
specify:

- **The pattern text** — the string to match against each message.
- **Match type** — either a **substring** match (case-insensitive; this is the
  default and is all you need for most fixed notices) or a **PHP regular
  expression** with delimiters, for more flexible matching. A message that matches a
  pattern is removed before the status-messages template renders.

Add one pattern per message you want to quiet. Because matching is done on the
message text, aim for text that is stable across page loads.

## Logging suppressed messages

The form includes an option to **log suppressed messages** to the `error_squelch`
log channel. Turning this on gives you an audit trail — you can see what was hidden
and when, which keeps suppression accountable and helps you notice if a "benign"
message is actually spiking. Leave it off if you truly want the noise gone without a
record.

## Test mode

**Test mode** injects a known status message that is visible **only to users with
the Administer Error Squelch permission**. Use it to confirm your patterns actually
match before you rely on them in production: turn on test mode, add a pattern that
should catch the injected message, and check that it disappears for you.

## Managing patterns from the command line

If you have Drush 11+, you can manage the pattern list without the UI:

- `drush error-squelch:list` (alias `esl`) — list the current patterns.
- `drush error-squelch:add` (alias `esa`) — add a pattern.
- `drush error-squelch:remove` (alias `esrm`) — remove a pattern.

## A reminder

Suppression is cosmetic — the message is gone, but the condition that triggered it
isn't. Use Error Squelch to reduce known, benign noise while a real fix is pending,
and lean on the logging option so masked problems don't get forgotten.
