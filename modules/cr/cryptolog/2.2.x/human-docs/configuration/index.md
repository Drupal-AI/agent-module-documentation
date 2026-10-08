# Configuration

Cryptolog starts working the moment you enable it — it replaces client IPs with
rotating pseudonyms using sensible defaults. The settings form lets you tune two
things that matter for privacy and for multi‑server setups: **how the salt is
stored** and **how often the identifier rotates**.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the **Cryptolog settings** page (config route `cryptolog.settings`),
   under **Configuration → People**.

## How the pseudonym works

Cryptolog hashes each client IP with a random salt and records the result (a
128‑bit value in IPv6 notation) instead of the real address. The salt is held in
the cache and **regenerated on a schedule** — every 24 hours by default. Because
the salt is stable within that window, the same visitor maps to the same
pseudonym for the day, which is what lets unique‑visitor counts and Drupal's
flood control continue to work. When the salt rotates, the mapping resets.

## Salt storage

Choose where the rotating salt lives. On a **single web server**, storing the
salt only in an in‑memory store such as APCu keeps it off disk entirely, so it is
lost (and effectively unrecoverable) on a restart — the strongest privacy
posture. On **multiple web servers**, the salt must be shared so every node
produces the same pseudonym for a given IP; use a shared backend such as Memcache
or Redis to keep it off disk while still sharing it.

## Rotation period

The salt's lifetime controls how long a pseudonym stays stable before it rotates.
A longer period gives you more days of consistent per‑visitor correlation; a
shorter period rotates identities more aggressively for stronger privacy. Set it
comfortably **larger than your flood‑control window** so abuse throttling keeps
functioning across the period.

## A note on reversibility

As long as the current salt can still be retrieved, a determined attacker could
brute‑force the (relatively small) IPv4 space to build a rainbow table and reverse
the pseudonyms. Once the salt expires and a new one is generated — or once an
in‑memory‑only salt is lost on a restart — recovering the original IPs is no
longer feasible. Storing the salt in memory only (single‑server case) and keeping
the rotation period reasonable both strengthen this protection.

## Save

Click **Save configuration**. Changes take effect for subsequent requests.
