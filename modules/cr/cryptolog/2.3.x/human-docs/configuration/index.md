# Configuration

Cryptolog starts pseudonymizing IPs the moment you enable it, using sensible
defaults. The settings form lets you control **where the salt is stored**, **how
often it rotates**, and gives you diagnostics for salt state and reverse‑proxy
handling.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Cryptolog**, or navigate directly to
   `/admin/config/people/cryptolog`.

## Single web head (salt storage)

**Single web head** is a checkbox (default **off**). When you turn it on *and*
APCu is available, Cryptolog stores the salt **solely in APCu** — kept in memory,
never written to disk. This is the strongest privacy posture and is appropriate
when your site runs on a **single web server**.

Leave it **off** on **multi‑server** setups. With it off, the salt is stored in
Drupal's default cache backend so that every web node produces the same pseudonym
for a given IP. To keep the shared salt off disk in that case, back your cache
with **Memcache or Redis** rather than the database.

## Salt lifetime (TTL)

The **TTL** (time‑to‑live), in seconds, sets how long the salt — and therefore
each visitor's pseudonym — stays stable before it rotates. The default is
**86400** (24 hours). On expiry the salt regenerates and every IP maps to a new
pseudonym.

Keep the TTL **larger than your flood‑control window** so abuse throttling keeps
working across the whole period; the form enforces a minimum drawn from your
`user.flood` settings (the IP or user window). A longer TTL gives more days of
consistent per‑visitor correlation; a shorter one rotates identities more
aggressively for stronger privacy.

## Regenerate the salt now

The form includes a **"Regenerate salt now"** checkbox. Ticking it and saving
invalidates the current salt immediately, so all pseudonyms roll over at once —
useful if you suspect the salt may have been exposed, or simply want a clean
break.

## Diagnostics on the form

The settings page also **displays**, for reference (you don't edit these):

- the current **storage backend** in use and the **time until the salt expires**;
- **reverse‑proxy diagnostics** — the original client IP, whether the request came
  through a trusted proxy, and the restored HTTP host and scheme — to help you
  confirm Drupal is seeing the right client IP before Cryptolog hashes it.

## A note on reversibility

While the current salt can still be retrieved, a determined attacker could
brute‑force the IPv4 space to build a rainbow table and reverse the pseudonyms.
Once the salt expires (or an in‑memory‑only salt is lost on a restart), recovering
the original IPs is no longer feasible. Storing the salt in memory only
(single‑web‑head) and keeping a reasonable TTL both strengthen this protection.

## Save

Click **Save configuration**. Note that changing **Single web head** or **TTL**
rebuilds the service container, so those changes settle on the next request.
