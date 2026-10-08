Apigee Teams extends the Apigee Edge module with teams, letting developers be organized into groups
that own shared apps. A team maps to an Apigee company (on Apigee Edge) or an appgroup (on Apigee X),
and members collaborate on the team's apps, credentials, and API products.

---

The module adds team and team-app entities, a team membership manager that keeps Drupal memberships in
sync with the Apigee company/appgroup, and an invitation flow (team_invitation entities with email
notifications and accept/decline forms). Access is governed by a two-layer permission model: normal
Drupal permissions such as "administer team" and "manage team members" for site-wide administration,
plus per-team permissions granted through team roles (shipped roles "admin" and "member") and resolved
per user per team by the team permission handler. It provides a team context switcher block, Views
integration, a Drush team-member sync command, and configurable team/team-app settings, caching, and
role definitions. It depends on apigee_edge, Views, and Datetime.

---

- Let developers form teams that share apps and API keys.
- Map a Drupal team to an Apigee company (Edge) or appgroup (Apigee X).
- Invite users to join a team by email and let them accept or decline.
- Assign per-team roles (admin/member) that scope what each member can do.
- Define custom team roles with specific team permissions.
- Let team admins manage their own team's members without site-admin rights.
- Create and manage team apps and their credentials.
- Control which API products (public/private/internal) a team can use.
- Add, revoke, or delete API keys on team apps per team permission.
- View analytics for a team's apps.
- Switch the active team context with a block to act as a team.
- Synchronize team members from Apigee after install (`drush apigee-edge:teams-sync`).
- List and filter pending team invitations with the bundled view.
- Relabel the Team and Team App entities to match your terminology.
- Tune caching for teams and team apps.
- Restrict team-member management routes to authorized users.
- Notify invited users automatically by email.
- Reconcile memberships changed directly in Apigee back into Drupal.
- Extend team permissions from a custom module via a dynamic permission provider.
- Build a multi-tenant developer portal where organizations manage their own apps.
