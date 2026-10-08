# Configuration

Publish Guard is **off until you configure it**. Everything is set on one form:
**Configuration → Content authoring → Publish Guard**
(`/admin/config/content/publish-guard`). You'll need the **Administer publish
guard** permission (an administrator has it by default) to open it.

## Open and enable

1. Go to **Configuration → Content authoring → Publish Guard**.
2. Tick **Enable publishing restrictions**. This is the master switch — while it's
   unchecked, the module does nothing and all publishing is allowed.

## The settings, field by field

- **Enable publishing restrictions** — the master switch described above. Turn it
  off any time to lift all restrictions without losing your other settings.

- **Allowed days** — choose which days of the week publishing is permitted (for
  example Monday through Friday). On any day you don't select, publishing falls
  outside the window.

- **Allowed start time** and **Allowed end time** — the daily window during which
  publishing is allowed, entered as times (defaults are **09:00** and **17:00**).
  Publishing attempts before the start time or after the end time are outside the
  window. The comparison uses your **site's configured timezone** (from your
  regional settings), so set that correctly for the window to behave as expected.

- **Strictness** — choose the enforcement mode:
  - **Warn** — editors see a message when publishing outside the window, but the
    publish still succeeds. Good for a gentle nudge.
  - **Block** — publishing outside the window is prevented; the node form raises
    an error and refuses to save the node as published. Good for a hard
    change‑freeze.

- **Message** — the custom text shown to editors when they hit the restriction.
  Use it to explain the policy and point people to whom to contact if they need
  to publish urgently.

Click **Save configuration** when you're done.

## Letting trusted users publish anytime

Some people — release managers, on‑call staff — need to publish regardless of the
schedule. Grant them the **Bypass Publish Guard** permission at **People →
Permissions** (`/admin/people/permissions`). Users with this permission skip the
checks entirely and can publish at any time. Both of the module's permissions
(*Bypass Publish Guard* and *Administer publish guard*) are marked as
security‑sensitive, so grant them only to roles you trust.

## Important: what Publish Guard does and doesn't stop

Publish Guard checks the **node add/edit form**, and only that. Keep these limits
in mind so you don't mistake it for an authorization boundary:

- It does **not** restrict who can *view* content.
- It does **not** stop programmatic publishes — code that calls
  `$node->setPublished()->save()`, REST or JSON:API writes, or migrations all
  bypass it.
- It does **not** restrict **Scheduler**‑driven publishing, because those happen
  via cron rather than the node form.
- It guards **nodes** only; other publishable entity types are unaffected.

Treat it as a helpful guardrail against accidental after‑hours publishing, and
combine it with Scheduler or Content Moderation if you need real scheduling or
enforced workflows.
