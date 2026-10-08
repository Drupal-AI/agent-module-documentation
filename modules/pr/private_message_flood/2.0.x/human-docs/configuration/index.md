# Configuration

Private Message Flood is configured **per role**: for each role on your site you
decide how many messages, and how many new threads, its members may create within
a chosen time window. The settings live with the module's flood configuration
alongside the Private Message settings — look under **Configuration** for the
Private Message / Private Message Flood settings once the module is enabled.

## The settings, explained

The module offers two kinds of limit, each paired with a duration:

- **Messages per duration** — the maximum number of private messages a user in a
  given role may *send* before they are rate-limited. Pair it with the duration
  below to make it "N messages per X".
- **Threads per duration** — the maximum number of new message *threads* (new
  conversations) a user in that role may start within the window. This is the
  knob that most directly limits mass outreach / spam, since a spammer typically
  opens many separate threads.

### Durations

Each limit has an accompanying **duration** field, provided by the Duration Field
module. Rather than a fixed unit, you enter a full duration — seconds, minutes,
hours, days, weeks — so you can express limits like "5 messages per 10 minutes"
or "20 threads per week" exactly as your community needs.

## Setting limits per role

Configure a separate limit for each role. Because the limit that applies is
chosen from the sending user's roles, you can be generous with trusted roles and
strict with new or unverified ones:

- Give brand-new / default authenticated users a tight limit to blunt spam.
- Give an established or moderated role a much higher (or effectively unlimited)
  allowance.

Save the form to apply. New messages and threads are counted against the window
from that point on; when a user hits a limit they are prevented from sending more
until the window elapses.
