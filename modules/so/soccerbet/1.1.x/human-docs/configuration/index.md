# Configuration

After enabling the module and running the database updates, set up the game from
**Administration → Soccer Bet**. This page walks through the main settings form,
the permissions, participant setup, and connecting the optional external API.

## The settings form

Go to **Administration → Soccer Bet → Settings** (`/admin/config/soccerbet`). The
form offers:

| Setting | What it does | Default |
|---------|--------------|---------|
| **Default tournament** | The tournament shown on the public leaderboard (one at a time). | — |
| **Points for exact result** | Points awarded for a correct score prediction. | 3 |
| **Points for correct tendency** | Points awarded for a correct win/draw/loss call. | 1 |
| **Betting closes N minutes before kick‑off** | The lock‑out window; `0` means bets close exactly at kick‑off. | 0 |
| **football‑data.org API key** | Required for API import and live updates (see below). | — |
| **Enable automatic score updates** | When on, polls the football‑data.org API on every Drupal cron run. | off |
| **Enable live scores** | Enables the live leaderboard page. | off |

Save the form when you're done.

## Permissions

Assign these permissions to the appropriate roles under **People → Permissions**:

| Permission | Recommended for |
|------------|-----------------|
| `access soccerbet content` | Authenticated users |
| `place soccerbet bets` | Authenticated users |
| `administer soccerbet` | Administrators |
| `edit soccerbet scores` | A scorekeeper role |
| `manage soccerbet payments` | Administrators |

## Participants (Tippers) and groups

Each bettor — a **Tipper** — is linked to a Drupal user account. Go to **Admin →
Soccer Bet → Participants** to create tippers and link them to user accounts.
Tippers can be organised into **groups**, and a tournament can be restricted to
one or more groups, so different circles of friends or colleagues can run separate
competitions on the same site.

## Payment tracking

Participation fees are tracked as a simple paid/unpaid marker per tournament,
managed by users with the `manage soccerbet payments` permission. There is no
online payment gateway — this is an administrative record only.

## Connecting the football‑data.org API (optional)

Automatic match import and live score updates come from the external
**football‑data.org** service. This is optional — you can enter teams, matches,
and scores by hand without it.

1. **Get an API key** — register at football‑data.org. The free tier covers most
   major competitions (Bundesliga, Premier League, Champions League, World Cup,
   Euro, and more) with a rate limit of 10 requests per minute.
2. **Enter the key** — go to **Admin → Soccer Bet → Settings** and paste it into
   the **football‑data.org API key** field.
3. **Import matches** — go to **Admin → Soccer Bet → Settings → Score update** and
   run the import.

Be aware that turning on **automatic score updates** makes your site send outbound
requests to football‑data.org on every cron run, and enabling **live scores**
turns on the live leaderboard page that polls for updates during matches. Leave
both off if you prefer to enter scores manually.
