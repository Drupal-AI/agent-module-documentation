Login Destination redirects users to a configured page after they log in, register, use a one-time login link, or log out, based on rules matched against user roles, the originating page, and language.

---

Login Destination stores a set of `login_destination` configuration entities ("rules"), each pairing one or more **triggers** (Registration, Login, One-time login link, Logout) with a **destination** and optional **conditions**. When a trigger fires, the module's manager service loads all enabled rules, sorts them by **weight**, and redirects the user to the destination of the **first matching rule** — so ordering sets priority. A rule matches when the trigger is selected and the user's roles, the page they came from, and the current language all satisfy the rule (an empty roles/pages/language condition means "any"). The destination can be an internal path, a node picked by autocomplete, an external URL, `<front>`, or `<current>` (the page the user came from), and it supports **user and global tokens** (e.g. `[user:name]`) that are replaced at redirect time. Page conditions accept one path per line with `*` wildcards, in either "all pages except those listed" or "only the listed pages" mode; because forms report the originating page via a `current` GET parameter, custom login/logout links must carry that parameter to match on page. A separate settings form exposes two advanced options: **Preserve the destination parameter** (give Drupal's own `?destination=` query priority over module rules) and **Redirect immediately after using one-time login link** (redirect before the user reaches the password-change form). Rules are managed at Admin → Configuration → People → Login destinations and gated by the `administer login destination settings` permission.

---

- Send editors to `/admin/content` right after they log in, while regular members go to their profile.
- Redirect newly registered users to a welcome or onboarding page.
- Land users on `/dashboard` after login only if they hold the `member` role.
- Redirect to the front page (`<front>`) on logout.
- Send users to an external URL (e.g. a marketing site) after logout.
- Return users to `<current>` — the page they were on when they logged in.
- Personalize the landing URL with a token such as `/users/[user:name]`.
- Redirect only users who logged in from `/user` or `/user/login` (page condition).
- Redirect from all pages except a listed set (e.g. everywhere but `/checkout/*`).
- Apply a rule only when a specific role is present, leaving others at the default destination.
- Redirect after a one-time (password reset) login link to a "set your password" page.
- Redirect immediately after a one-time login link, before the password-change form, via the settings option.
- Restrict a rule to a single language on a multilingual site.
- Order overlapping rules by weight so the most specific one wins.
- Disable a rule temporarily without deleting it (the `enabled` flag).
- Give Drupal's own `?destination=` parameter priority over module rules with "Preserve the destination parameter".
- Route users registered while awaiting admin approval to a "pending approval" page.
- Point one-time login links coming from email verification to a specific edit form.
- Create separate login destinations for anonymous-originated vs. authenticated flows.
- Match pages by URL alias as well as internal path (aliases are resolved before matching).
- Export login destination rules as configuration and deploy them between environments.
- Add the `current` GET parameter to custom login/logout links so page conditions still match.
- Send administrators back to the admin section after a session expires and they re-authenticate.
- Redirect members of several roles (any one match triggers the rule) to a shared members area.
- Keep unmatched logins on Drupal's default destination by leaving a rule's destination scoped narrowly.
