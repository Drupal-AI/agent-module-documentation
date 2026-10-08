<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Advanced Cache adds a Views cache plugin exposing cache tags, cache contexts and output/results caching as configuration.

---

Views' built-in caching options are time-based — cache the query for an hour, cache the output for a day — which is the crudest possible answer and the one that produces both of the failures people complain about. Too short and the cache does nothing; too long and the listing shows deleted content. Drupal's own model is better and Views does not expose it: **cache tags** invalidate precisely when the thing they name changes, so a view of articles tagged `node_list` is correct the instant an article is saved and cached indefinitely otherwise; **cache contexts** declare what the result varies by, so a view that differs per user says so instead of being cached wrongly or not at all. Putting both in the Views UI is the difference between a listing that is fast and correct and one that is one or the other. Version **2.0.2** on core `^10.3 || ^11`. **Contexts are the side to get exactly right.** A view whose results depend on the current user — anything filtered by ownership, by group membership, by role, or simply subject to node access — must declare (and keep) the contexts that capture that, so each viewer gets their own results. Tags are the forgiving half: a missing or wrong tag only means stale content, which is recoverable. A missing or excluded access context changes which results a viewer receives, so it is not something to trim casually. The working rule when configuring this is: **be generous with tags, and be exact about contexts** — and test with two accounts that should see different results, in both orders.

---

- Cache a view by tag instead of time.
- Invalidate a listing when content changes.
- Declare what a view varies by.
- Fix a listing showing deleted content.
- Cache an expensive view correctly.
- Improve a busy listing's performance.
- Add cache contexts to a personalised view.
- Cache a view indefinitely with tags.
- Fix a view that is never cached.
- Improve a homepage listing's speed.
- Cache a facet-driven view.
- Add a custom cache tag to a view.
- Reduce database load from a listing.
- Cache a menu-driven listing.
- Fix stale results in a view.
- Tune caching for a report view.
- Cache a view varying by role.
- Improve a search results view's caching.
