# Soccer Bet — manual setup guide

**Soccer Bet** (`soccerbet`) is a football prediction game — a *Tippspiel* — for
Drupal 10/11. It lets a group of users place score predictions on football
matches, earn points, and compete on a live leaderboard. It is a complete
in‑Drupal application for running a prediction pool among friends, colleagues, or
a wider community.

Players predict the home/away score of each match before kick‑off (with a
configurable lock‑out window), and knockout rounds add a prediction of the
advancing team when a draw is possible, plus an optional bonus bet on the overall
tournament winner. The scoring system is configurable: an exact result is worth 3
points by default, a correct tendency (win/draw/loss) 1 point, bonus points flow
from wrong bettors to correct bettors per match, and a correct knockout‑round
winner earns points equal to the number of participants. Around the betting the
module provides a live leaderboard with real‑time rank updates during matches,
round‑by‑round standings history, a colour‑coded bets overview across all
participants, a per‑tournament shoutbox chat, national/club flags, and English
plus German translations.

You can run multiple tournaments (one active tournament appears on the public
leaderboard at a time), enter teams and matches by hand, or import them
automatically from the **football‑data.org** API. That external API is optional:
manual score entry works without it, but automatic match import and live score
updates require a free or paid API key from football‑data.org. When enabled,
automatic score updates poll that external service on every Drupal cron run, so be
aware the site makes outbound calls to football‑data.org when you turn that on.
The module also tracks participation payments — you can mark each participant's fee
as paid per tournament — but there is no online payment processing; it is simply a
paid/unpaid record that administrators manage.

The module has no other module dependencies but requires **PHP 8.2+**. It needs
configuration before use (at minimum a tournament and the relevant permissions),
and a database update step after enabling. It is **not** covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and run the database updates.
2. [Configuration](configuration/index.md) — the settings form, permissions,
   participants, and connecting the football‑data.org API.

## Where it lives in the admin menu

Once enabled, Soccer Bet's admin area lives under **Soccer Bet** in the
administration menu. Its main settings form is at **Administration → Soccer Bet →
Settings** (`/admin/config/soccerbet`), participants are managed at **Admin →
Soccer Bet → Participants**, and match/score import lives under **Settings → Score
update**. The public leaderboard shows the currently active tournament to your
players.
