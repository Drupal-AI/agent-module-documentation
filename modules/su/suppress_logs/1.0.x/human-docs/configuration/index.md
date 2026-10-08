# Configuration

All of Suppress Logs' behaviour comes from a single settings form, where you list
the log channels you want to stop recording. Nothing is suppressed until you add a
channel here.

## Open the settings form

1. Log in as a user with the module's suppression permission (an administrator by
   default).
2. Go to **Configuration** and open the **Suppress Logs settings form**
   (`suppress_logs.settings_form`).

## Add the channels to ignore

On the form, add the log **channels** you wish to suppress. A channel is the
category a log message belongs to — for example the channel behind the routine
"page not found" messages. Once a channel is listed and you save, messages on that
channel are routed to a null logger and dropped instead of being written to your
logs.

To find a channel name, look at your existing log entries (under **Reports → Recent
log messages** if you use the Database Logging module) and note the type/channel of
the messages that are cluttering it.

## Use it safely

This is the important part. Because suppression makes messages disappear entirely,
treat the list conservatively:

- **Suppress only genuine noise** — a specific, high-volume, low-value channel.
- **Never broadly suppress security, error or audit channels.** Failed logins,
  access-denied events and exceptions are what you need for detecting attacks and
  for forensics after an incident; dropping them blinds you.
- **Keep the list tight and review it.** The fewer channels you suppress, and the
  more deliberately, the safer. Revisit the list periodically to confirm each entry
  is still justified.

## Save

Click **Save** on the form. Suppression takes effect for the listed channels; if you
later want a channel back, remove it from the list and save again.
