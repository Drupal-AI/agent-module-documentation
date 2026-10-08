Tourauto is a submodule of Tour that automatically opens a page's tour for users who have not yet seen it, and lets each user turn auto-opening on or off from their profile.

---

Tourauto (`part_of` the Tour project) adds automatic tour launching on top of the base Tour module. On every page (`hook_page_bottom`), if the current user has the `access tour` permission and has tourauto enabled, it loads the tours that match the current route via Tour's `tour.helper` service, compares them against the set of tours the user has already "seen" (tracked per-user in `user.data` under the `tourauto` module, key `tourauto_state`), and if there are any new/unseen tours it signals the client (via `drupalSettings.tourauto_open`) to pop the tour open automatically; the newly shown tours are then recorded as seen. Each user gets an "Open tours automatically" checkbox (and a "Clear status / mark all tours as unseen" checkbox) added to their user edit form, stored under the `tourauto_enable` user-data key (defaulting to enabled for users who never set a preference). The logic lives in the `tourauto.manager` service (`TourautoManager`), which exposes helpers to read/set the preference, get current-route tours, and read/mark/clear seen state; a `getManagerForAccount()` helper returns an instance scoped to another user (used when editing someone else's profile). Users with `administer site configuration` also get debug data injected into `drupalSettings.tourauto_debug`. Tourauto defines no config, no permissions, and no plugins — it reuses Tour's config entities and the `access tour` permission.

---

- Automatically open a page's tour the first time a user lands on that page.
- Give new editors a hands-off onboarding walkthrough without them clicking the Tour button.
- Show each auto-tour only once per user (seen state is remembered).
- Let a user opt out of auto-opening tours from their profile ("Open tours automatically").
- Let a user reset their seen state so all tours auto-open again ("Clear status").
- Auto-launch a front-page product tour for first-time authenticated visitors.
- Re-trigger onboarding after a redesign by clearing users' seen state.
- Keep auto-open behavior per-user rather than global (stored in user.data).
- Programmatically read whether a user has tourauto enabled (`tourautoEnabled()`).
- Programmatically set a user's auto-open preference (`setTourautoPreference()`).
- List the tours available on the current route for a user (`getCurrentTours()`).
- Read which tours a user has already seen (`getSeenTours()`).
- Mark tours as seen for a user (`markToursSeen()`).
- Clear a user's seen state in code (`clearState()`).
- Manage another account's tourauto state via `getManagerForAccount($account)`.
- Debug auto-open decisions with the `tourauto_debug` drupalSettings payload (admins).
- Layer auto-opening onto existing Tour config entities without editing the tours.
