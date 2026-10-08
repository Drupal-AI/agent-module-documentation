# Configuration

Suspect Blocker has a small settings page where you tell it how aggressive to be.
Getting these two values right for your traffic is the whole job.

## Open the settings page

1. Log in as an administrator (or a user with the module's permission).
2. Go to **Configuration → Security → Suspect Blocker**, or navigate directly to
   `/admin/config/security/suspect-blocker`.

## The settings

- **Ban threshold** *(default 5)* — the number of suspicious requests an IP may make
  before it is automatically banned. Lower is stricter (bans sooner); higher is more
  forgiving. Requests that trigger errors such as 403 and 404 count toward this
  total.
- **Monitoring time window** *(default 60 seconds)* — the length of the window over
  which those suspicious requests are counted. A shorter window only catches genuine
  rapid bursts; a longer window will also catch slower, drawn-out probing but raises
  the chance of catching legitimate traffic.

Together these define a burst: "more than *threshold* suspicious requests within
*window* seconds" triggers a ban.

## Tuning to avoid false positives

Because banning is automatic, tune with care:

- Legitimate search-engine crawlers and several real users sharing one IP (behind a
  corporate proxy or NAT) can look bursty. If you see good traffic being banned,
  raise the threshold or shorten the window.
- Start a little loose and tighten gradually as you learn what your normal traffic
  looks like.
- Suspicious attempts are logged via syslog (IP, path, HTTP status), so review those
  logs to judge whether your thresholds are catching the right requests.

## Save and manage bans

Click **Save** to apply the settings; monitoring starts immediately. Banned
addresses are held by core's **Ban** module — you can view and remove them at
**Configuration → People → IP address bans** (`/admin/config/people/ban`) if you
need to lift a ban.
