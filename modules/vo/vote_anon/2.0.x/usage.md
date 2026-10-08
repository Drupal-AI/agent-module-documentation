<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vote Anon enables anonymous and authenticated voting.

---

Vote Anon **enables anonymous and authenticated voting** on content — letting visitors (including anonymous
users) cast votes/ratings, with Views integration to display results. It depends on core Views, Node and User,
provides its own permissions, in the Voting package.

Use it to allow anonymous voting. It is a user-engagement/voting feature with an inherent security consideration:
**anonymous votes are spoofable** — without a logged-in identity, deduplication relies on IP/cookie, which a
determined user can bypass (clear cookies, change IP), so anonymous vote counts should be treated as
**approximate** and you should rate-limit/dedup (IP/cookie/CAPTCHA) to blunt ballot-stuffing; never use anonymous
vote outcomes for anything security- or money-sensitive. Authenticated voting is more reliable (per-user). It has
no access-control role beyond its permission. Configure the voting and anti-abuse.

---

- Enable anonymous + authenticated voting.
- Let visitors cast votes/ratings.
- Display results via Views.
- Depend on core Views/Node/User.
- Provide its own permissions.
- Serve user engagement.
- KNOW anonymous votes are spoofable.
- Dedup via IP/cookie (bypassable).
- Rate-limit/CAPTCHA to blunt ballot-stuffing.
- Treat anonymous counts as approximate.
- Not use them for security/money-sensitive decisions.
- Configure voting + anti-abuse.
- Handle anonymous voting.
- Collect votes.
- Configure the voting.
- Show results.
- Handle the votes.
- Rate content.
- Prevent ballot-stuffing.
- Provide anonymous voting.
