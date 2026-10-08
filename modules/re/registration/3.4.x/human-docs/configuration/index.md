# Configuration

Setting up registrations is a three-part job: create a **registration type**, add the
**Registration field** to a host content type, then tune each host's **settings**.
After that there are global options and permissions to review.

## 1. Create a registration type

A registration type ties a Workflow to your sign-ups and acts as a bundle you can add
fields to.

1. Go to **Structure → Registration → Registration types**
   (`/admin/structure/registration/type`) and click **Add registration type**.
2. Give it a **Label** (e.g. "Conference") and choose:
   - **Workflow** — which registration workflow governs its states (the module ships a
     default "Registration" workflow with states pending, complete, held, canceled).
   - **Default state** — the state new registrations start in (usually *pending*).
   - **Held expiration** — how many hours a *held* registration is kept before it
     expires (0 = never), and which state it moves to when it expires (e.g. *canceled*).
3. Save. To collect extra data per sign-up, add fields to the type at
   **Registration types → (your type) → Manage fields**.

### The registration workflow

The workflow is a normal core Workflows config entity of type "Registration". Its
default states are **pending**, **complete**, **held** and **canceled**, with
transitions to complete, hold and cancel. You can edit these states or create
additional registration workflows and point a registration type at the one you want.

## 2. Make a content type registrable

You turn a bundle into a "host" by adding a **Registration** field to it.

1. Go to the content type's **Manage fields** (e.g. **Structure → Content types →
   Event → Manage fields**) and click **Add field**.
2. Choose the **Registration** field type, label it (e.g. "Registration") and save.
3. In the field settings, use **allowed types** to restrict which registration types
   editors may pick for this bundle.

Once a host entity has a value in its Registration field it becomes a **host entity**
and automatically gains three tabs:

- **Register** — the sign-up form (e.g. `/node/{node}/register`).
- **Manage registrations** — an admin list of sign-ups, plus a form to email all
  registrants at once.
- **Registration settings** — the per-host settings form described next.

## 3. Tune each host's registration settings

Every host has its own **Registration settings** (created on demand) that hold the
operational limits for that specific event. Open the host's **Registration settings**
tab and set:

| Setting | Meaning |
|---------|---------|
| **Enable** (`status`) | Whether registration is open for this host at all. |
| **Capacity** | Total spaces available (0 = unlimited). |
| **Open / Close** | The datetime window during which registration is allowed. |
| **Maximum spaces** | The most spaces a single registration may reserve (0 = unlimited). |
| **Multiple registrations** | Whether one user may submit more than one registration. |
| **Send reminder / Reminder date / Reminder template** | Whether, when, and with what body to email a reminder. |
| **From address** | The "From" address for this host's mail. |
| **Confirmation** | The message shown after a successful registration. |
| **Confirmation redirect** | A path to send the registrant to afterwards. |

Default values for new hosts of a type come from that type's settings form display,
editable from the global settings page.

Each individual sign-up is stored as a `registration` record capturing the registrant
(a logged-in user, another user, or an anonymous email address), the number of spaces
taken, and its workflow state. Administrators can bulk-set the state of selected
registrations with the "Set registration state" action.

## 4. Global settings

Site-wide options live at **Structure → Registration settings**
(`/admin/structure/registration-settings`), which requires the *administer
registration* permission. Notable options include:

- **Send email as HTML** (`html_email`).
- **Queue notifications** above a given recipient count (default 50) so large
  broadcasts don't block a request.
- **Manage Registrations filter threshold** (`hide_filter`, default 10) — when to show
  a filter on the manage list.
- **Broadcast filter** — add a status filter to the "email registrants" form.
- **Lenient access check** — ignore open/close dates in the register access check.
- **Prevent editing when disabled** — block edits to existing registrations when new
  registration is turned off.
- **Synchronise registration settings** across languages on multilingual sites.

These can also be read and set with Drush, e.g.
`drush cget registration.settings` / `drush cset registration.settings html_email true -y`.

## 5. Permissions

Grant these at **People → Permissions** as appropriate:

| Permission | Grants |
|------------|--------|
| **Access registration overview** | View the registrations overview page. |
| **Administer registration types** | Manage registration types, their fields and displays (restricted). |
| **Administer registration** | View/edit/delete/manage *all* registrations and settings, and the global settings form (restricted). |
| **Create registration** | Create registrations of any type (for oneself, other users, or by email). |
| **View any registration** / **View own registration** | View all, or only one's own, registrations. |
| **View / update / delete host registration** | Manage registrations for hosts the user can edit. |

In addition, each registration type gets its own per-type permissions (e.g. **create
*conference* registration**, **update any *conference* registration**), so you can grant
rights on one type without granting them for all.

## Automatic behaviour

Cron does two housekeeping jobs for you: it expires **held** registrations once their
hold time passes, and it sends scheduled **reminder** emails. The module also provides
Views integration (registration counts, "user is registered" flags, spaces-remaining
fields), a **Registration Status** block for showing remaining/reserved spaces on an
event page, and it sanitizes registrant emails and names during
`drush sql:sanitize`.
