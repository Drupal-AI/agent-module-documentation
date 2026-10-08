Embeds the BugHerd feedback sidebar on your Drupal site and ships a PHP client for the BugHerd REST API (v2).

---

BugHerd API adds BugHerd's on-page issue-reporting overlay to a Drupal site: enter your BugHerd **project key** on the settings form and the module attaches BugHerd's `sidebarv2.js` to front-end pages, so users with the *Access Bugherd* permission can annotate the live site and turn feedback into BugHerd tasks. The project key that reaches the browser is BugHerd's public per-project embed key. Separately, the module provides a server-side `bugherdapi.client` service wrapping the BugHerd REST API v2 (organization, users, projects, tasks, comments and webhooks), authenticated with a *personal API key* that is used only from PHP and is best kept in `settings.php`. The sidebar can be disabled on admin routes, and the module nudges administrators when no project key is configured yet. Core-only: no contrib dependencies.

---

- Add the BugHerd feedback sidebar/overlay to your live site so clients can report bugs in context.
- Let reviewers pin annotations directly onto page elements during a QA or client-review round.
- Turn on-page feedback into structured BugHerd tasks with browser/environment metadata attached.
- Restrict who sees the sidebar by granting the *Access Bugherd* permission only to reviewer roles.
- Hide the BugHerd button on admin pages while keeping it on the public-facing site.
- Configure the module from *Administration → Configuration → System → BugHerd* (`/admin/config/system/bugherd`).
- Get an automatic warning on-screen when the project key has not been set yet (admins only).
- Read your BugHerd organization details from PHP via `getOrganization()`.
- List BugHerd users, members or guests programmatically (`getUsers()`, `getMembers()`, `getGuests()`).
- List all or only active BugHerd projects (`getProjects()` / `getProjects(TRUE)`).
- Create, read, update or delete BugHerd projects from custom code.
- Fetch a project's tasks, optionally filtered by status, priority, tag, `external_id` or a `*_since` date.
- Create a BugHerd task from Drupal, e.g. when a site event or form submission should raise a bug.
- Update an existing task's status, priority, assignee or tags.
- Read and post comments on a task, optionally attributed to a specific BugHerd user.
- Register or delete BugHerd webhooks (e.g. `task_create`, `comment`) so BugHerd can call back into your site.
- Validate a personal API key before storing it — the settings form pings BugHerd and reports the organization name.
- Keep the secret personal API key out of exported config by setting it in `settings.php`.
- Page through large result sets automatically — listing methods fetch every page (100 records each) for you.
- Handle API failures cleanly by catching `BugherdApiException`, with helpers for auth (401/403) and rate-limit (429) errors.
- Build a lightweight in-house bug-triage integration between Drupal content and a BugHerd board.
