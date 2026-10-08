# Configuration

Login Destination is configured through **rules** you create on its admin screen,
plus two advanced settings. Everything is under **Configuration → People → Login
destinations** (`/admin/config/people/login-destination`), which requires the
**Administer login destination settings** permission.

## Create a rule

Click **Add login destination** and fill in the form:

- **Label** — a short human description of the rule (required).
- **Triggers** — one or more of **Registration**, **Login**, **One-time login link**,
  and **Logout**. The rule only applies to the triggers you tick (required).
- **Destination** — where to send the user (required). It can be:
  - an internal path such as `/dashboard`;
  - a node chosen through the autocomplete field;
  - an external URL such as `https://example.com`;
  - `<front>` — the front page;
  - `<current>` — the page the user was on when the trigger fired;
  - a value containing **tokens** (user and global, e.g. `/users/[user:name]`), which
    are replaced at redirect time. A token browser is shown to help you pick them.

### Conditions (all optional)

- **Roles** — restrict the rule to users holding one of the selected roles. Leave it
  empty to match **all** users. Only one of the selected roles needs to match.
- **Pages** — restrict by the page the user came from. Enter one path per line, with
  `*` wildcards allowed, and choose the mode: **all pages except those listed**, or
  **only the listed pages**. Paths are matched against both the internal path and the
  URL alias.
- **Language** — restrict the rule to a single language. Leave it empty to match all
  languages.

### Enable and order

- **Enabled** — untick to switch a rule off temporarily without deleting it.
- **Weight** — sets priority. When a trigger fires, rules are checked in weight order
  (lowest first) and the **first** enabled rule whose trigger and conditions all match
  wins. If no rule matches, Drupal's default destination is used. So order your rules
  so the most specific one comes first.

Save the rule. Rules are stored as configuration entities, so they export and deploy
between environments.

> **A note on page conditions:** matching on the originating page only works when the
> module knows what that page was. Drupal's own forms and the module's altered
> login/logout links pass it along automatically, but **custom login/logout links must
> carry a `current` query parameter** for page conditions to match.

## Advanced settings

Open the **Settings** tab
(`/admin/config/people/login-destination/settings`). Both options are off by default:

- **Preserve the destination parameter** — when on, Drupal's own `?destination=` query
  parameter takes priority over your Login Destination rules. Note that turning this on
  stops the login-block redirect from working.
- **Redirect immediately after using one-time login link** — when on, a user who
  follows a one-time (password-reset) login link is redirected immediately, **before**
  reaching the password-change form.

Click **Save configuration**. These two options are also stored as configuration and
deploy with an export.

## Permissions

At **People → Permissions**, the module defines a single permission:

- **Administer login destination settings** (`administer login destination settings`)
  — the one gate for everything the module exposes: the rule list, add/edit/delete of
  rules, and the advanced settings form. Trusted/administrative.
