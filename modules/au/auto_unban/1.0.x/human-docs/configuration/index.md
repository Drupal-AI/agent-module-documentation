# Configuration

## The one setting: the base ban window

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Auto Unban**
   (`/admin/config/system/auto-unban`).
3. Choose a value from the **ban window** select list and save.

That single value is the base length of a ban. The options range from **one minute**
up to **one year** (specifically: 1 minute, 10 minutes, 30 minutes, 1 hour, 6 hours,
12 hours, 1 day, 2 days, 1 week, 30 days, 1 year). The default is **1 hour** (3600
seconds).

Prefer the command line? You can set it with Drush:

```bash
drush config:set auto_unban.settings seconds 86400 -y   # 86400 = one day
```

> **Note:** changing this value only affects IPs banned **from now on**. Bans that
> already exist keep whatever expiry they were given. So adjusting the window is safe
> — it won't retroactively lengthen or shorten current bans.

## How the exponential back-off works

The base window is just the *first* ban's length. Each time the same IP is banned
again (after its previous ban has already expired), the duration doubles:

| Ban of this IP | Length (with a 1-hour base) |
|----------------|-----------------------------|
| 1st            | 1 hour                      |
| 2nd            | 2 hours                     |
| 3rd            | 4 hours                     |
| 4th            | 8 hours                     |
| …              | …and so on                  |

So persistent abusers earn progressively longer time-outs automatically, without you
hand-tuning a schedule, while a one-time offender is released after just the base
window. Expiry is checked live on every request, so a ban lifts the moment its window
passes — there's no cron job to wait for.

## The enhanced ban list

Auto Unban upgrades core's ban page at **Configuration → People → IP address bans**
(`/admin/config/people/ban`):

- **Ban count** and **Expires** columns are added, both **sortable**.
- Expiry is shown human-readably — either *"expired"* or a formatted date/time.
- The list is **paginated** at 50 rows so a large ban list stays manageable.
- An **Add indefinitely** button bans an IP permanently (until roughly the year
  2038), for the cases where you really don't want the ban to expire.

## Making a ban permanent

Because ordinary bans are now time-limited, use one of these when you want a ban that
never lapses on its own:

- The **Add indefinitely** button on the ban form, or
- `drush ban <ip> --permanent` on the command line.

## Drush commands

Auto Unban provides three commands that mirror the UI:

| Command | What it does |
|---------|--------------|
| `drush ban <ip>` | Bans an IP (time-limited by default). Add `--permanent` for an indefinite ban. |
| `drush unban <ip>` | Lifts the ban on an IP. |
| `drush banned` | Prints banned IPs as JSON. By default only currently-active bans; add `--all` to include expired ones (each row then carries an `expired` flag). Also accepts `--limit=N`, `--sort=expires\|attempts`, and `--ip=<ip>`. |

Examples:

```bash
drush ban 203.0.113.5
drush ban 203.0.113.5 --permanent
drush unban 203.0.113.5
drush banned --all --sort=expires --limit=20
```

The JSON output of `drush banned` makes it easy to script ban monitoring or
reporting.

## A reminder on the behavior change

With Auto Unban enabled, *every* new ban is time-limited unless you explicitly make it
permanent. If your site relies on bans staying put forever, make sure your team knows
to use *Add indefinitely* / `--permanent`. Also worth knowing: there is no mechanism
by which a banned visitor could lift their own ban — expiry is purely time-based and
evaluated on the server.
