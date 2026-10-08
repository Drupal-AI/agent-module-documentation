<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views random seed adds a "Random seed" sort handler to Views that orders rows randomly using a stored seed, so a paged random listing stays consistent across pages (no duplicates or gaps between page 1 and page 2). It is the fix for core's plain "Global: Random" sort, which reshuffles on every query and breaks paging.

---

The module registers a Views sort plugin (`views_random_seed_random`, exposed as the "Random seed" field on the `views` table) that sorts with a seeded random function — `RAND(<seed>)` on MySQL/MariaDB and `setseed()` + `RANDOM()` on PostgreSQL. Because the seed is persisted, every page of a pager uses the same random order. The seed is produced by the `views_random_seed.seed_calculator` service (`SeedCalculator`), which stores it in a key-value collection (`views_random_seed`) — or in the user session when "different seed per user" is chosen — keyed by view id and display. Sort options control the behaviour: `user_seed_type` (`same_per_user` vs `diff_per_user`), `anonymous_session` (start sessions for anonymous users so each gets a different order), `reset_seed_int` (how often to regenerate the seed: never `-1`, custom `0`, hourly `3600`, every 8 hours `28800`, daily `86400`), `reset_seed_custom` (a custom interval in seconds), and `reuse_seed` (share another view display's seed so two listings shuffle identically). When the seed is regenerated the cache tag `views_random_seed-<view>-<display>` is invalidated. It also supports Search API views (passing the seed and formula through to the Search API query). There is no admin page — you configure it entirely inside the Views UI; a `views_random_seed_view_messages` setting toggles debug messages. Recommendation for cached views: use time-based caching aligned with the reset interval.

---

- Randomly order a "Related articles" or "Featured" listing while keeping the pager consistent.
- Fix core's Global: Random sort duplicating/skipping items across paged results.
- Show a random selection of products that stays stable while a visitor browses pages.
- Reshuffle a random listing once an hour / eight hours / daily via the reset interval.
- Keep the same random order for all users (`same_per_user`) for cache-friendliness.
- Give each logged-in user a different random order (`diff_per_user`).
- Give each anonymous visitor a different order by enabling anonymous sessions.
- Reset the random order on a custom interval (in seconds) with `reset_seed_custom`.
- Never reshuffle (fix the order permanently) by setting the reset to Never (`-1`).
- Sync two different views so they present the same random order via `reuse_seed`.
- Randomize a homepage block of teasers without editors curating the order.
- Rotate sponsor/banner listings randomly but predictably within a time window.
- Randomize a quiz or flashcard listing that a user pages through.
- Provide a "surprise me" random content view that supports Next/Previous paging.
- Randomize a gallery grid while allowing infinite-scroll/pager loading.
- Combine with time-based Views caching so the cache and the seed refresh together.
- Randomly order Search API results with a seed (Search API views support).
- Ensure the same random order across a View and its attached block by reusing the seed.
- Randomize a directory of members that stays stable per browsing session.
- Avoid writing a custom Views sort plugin just to get seeded random ordering.
- Invalidate the view's cache automatically when the seed is regenerated.
- Offer fair, rotating exposure of listings by resetting the seed on a schedule.
