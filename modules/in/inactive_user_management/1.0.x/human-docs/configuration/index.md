# Configuration

Out of the box the notification is **off** — the module explicitly asks you to
enable it after installing and to write your own message. Configuration has two
parts: the module's own settings form, and the cron schedule that drives it.

## Step 1 — Enable and tune notifications

1. Log in as a user with the module's administer permission.
2. Open the **Inactive User Management** settings form under **Configuration**.
3. **Enable the inactive‑user notification** — this is off by default, so nothing
   is sent until you switch it on.
4. Set the **inactivity period** — how long an account may go without a login before
   it counts as inactive.
5. Set the **interval between notifications** — how often a still‑inactive user is
   reminded.
6. **Customize the message.** It is recommended to write your own notification text
   rather than rely on the default; the module uses an `email.html.twig` template in
   the usual way.
7. Save the form.

## Step 2 — Set how often the job runs

The module's work happens on cron, scheduled through **Ultimate Cron**:

1. Go to **Configuration → System → Cron jobs** (Ultimate Cron).
2. Find this module's job and adjust its schedule. The default is **once a day**,
   which suits most sites.

Make sure your site's cron actually runs on a real schedule (a system cron hitting
Drupal's cron), or the notifications will not go out.

## What this version does (and does not) do

- **This release sends notifications only.** It emails inactive users to prompt them
  to return.
- **Automatic deactivation and deletion are on the roadmap, not in this release.**
  The maintainer plans to add optional auto‑deactivation after a period, then
  auto‑deletion of deactivated/blocked users, plus a report of who was notified,
  blocked, and deleted. Until those land, this module will not block or remove
  accounts on its own — so there is no destructive action to guard against yet. Keep
  this in mind when you plan account‑lifecycle policy.
