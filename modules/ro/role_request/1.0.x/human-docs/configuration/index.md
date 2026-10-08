# Configuration

Configuration is short — choose the requestable roles and set the two permissions —
but the choices you make here directly control who can gain which role, so make them
deliberately.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → People → Role request**
   (`/admin/config/people/role-request`).

## 1. Choose which roles can be requested

Select at least one role that users are allowed to request. **Only list roles you
are comfortable granting through this workflow.** Do not add the `administrator`
role or any other privileged role (anything that administers users, permissions,
content types, or configuration) to the requestable list.

## 2. Set the permissions

At **People → Permissions**, configure:

- **Request role** — grant this to the roles whose users should be able to submit
  requests (commonly *authenticated user* on a community site).
- **Administer role requests** — grant this **only to people you trust as full site
  administrators.** Approving a request grants the requested role, so keep this
  permission with a very small group.

## 3. Configure the emails (optional)

You can customize the approval/denial notification emails, using tokens to
personalize the body. Set these up on the settings form so requesters get a clear
message when their request is decided.

## How the workflow runs

1. A user with *Request role* opens their **profile page** and requests one or more
   of the roles you made available, optionally adding a message.
2. The request is created as **pending review**.
3. A user with *Administer role requests* reviews it, optionally attaches a note,
   and **approves or denies** it.
4. On approval, the requested roles are granted to the user; the stored request
   remains for reference but only takes effect on approval.

## Keep role grants contained

Two habits keep this module safe:

- **Never make a privileged role requestable.** Limit the list to low-risk,
  clearly-scoped roles.
- **Keep *Administer role requests* with trusted administrators only.**
