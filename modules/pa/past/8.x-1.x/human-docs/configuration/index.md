# Configuration

Past is a logging framework, so its "configuration" is less about a big settings
form and more about three practical concerns: where the logged events live, who is
allowed to see them, and how you stop the log from growing forever. These apply
once you have the **Past DB** backend enabled (see
[Installation](../installation/index.md)).

## Viewing logged events

With **Past DB** enabled, events are stored as entities and listed in the admin
area. Install the **Views** module to list and filter events in the reports section
of your site — Past DB provides Views integration for exactly this, and it also has
Drush integration for command‑line access. The "bug hunt" UI, with its TODO / done
flags, is where you work through captured errors and mark them handled.

## Permissions — gate who can read the logs

Past provides its own permission(s). Because event logs can contain rich arguments
that reveal internal detail about how your site works — and potentially sensitive
data — restrict access to trusted roles under **Administration → People →
Permissions**. Treat the event log as privileged information, not a page for
general users.

## Expiring old entries

The Past DB backend supports **expiration of old entries** so your log does not
grow without bound. Configure a retention policy that keeps enough history to be
useful for auditing and debugging without accumulating data indefinitely. Pair this
with a scheduled cron run so expiration actually happens on a regular basis.

## What to log — and what not to

Configuration here is partly a discipline in your own code rather than a form
setting. Past will faithfully store whatever arguments you attach to an event, so:

- **Do** log the identifiers, statuses, and structured payloads that make a flow
  understandable after the fact.
- **Do not** log secrets, credentials, tokens, or personal data — once captured,
  they sit in the log for anyone with access to read.

Getting this right at the point where you call Past's logging API is the most
important "setting" of all.
