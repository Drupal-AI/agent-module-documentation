<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RedHen CRM is a CRM built out of Drupal content entities — Contacts, Organizations, and fieldable Connections between them — rather than an integration with a CRM hosted elsewhere. The core `redhen` module is just shared APIs and a dashboard; the real entities live in submodules (`redhen_contact`, `redhen_org`, `redhen_connection`) with `redhen_dedupe` for cleanup.

---

The choice RedHen represents is a real architectural fork for membership organizations, charities and associations. **CiviCRM** is the other answer: a full CRM with its own data model, its own upgrade cycle and a large built-in feature set, installed alongside Drupal or reached over an API (`cmrf_core` is that arrangement). RedHen takes the opposite position — a **Contact** is a Drupal content entity (`redhen_contact`, with `first_name`/`middle_name`/`last_name`/`email`/`status`/`uid` base fields and a nullable link to a Drupal user), an **Organization** is another (`redhen_org`, with a `name` and `status`), and a **Connection** (`redhen_connection`) is a fieldable entity with two endpoint references that models a relationship such as "employee of" or "board member". Because they are ordinary entities they are fieldable, revisionable, Views-integrable and governed by Drupal **entity access**, and a developer already fluent in Drupal learns no second system. What that buys is composability; what it costs is everything a mature CRM ships that RedHen does not — in this **3.0.x alpha** there is deliberately **no membership, note, engagement or groups submodule** (the code base ships only contact, org, connection and dedupe), so fundraising, membership lifecycle and event registration are yours to build or bolt on. Access is **permission-driven and status-aware**: each entity type distinguishes active from inactive records, so viewing a contact requires `view active contact entities` (or the bundle-scoped / "own" variants) and viewing a deactivated one requires the separate `view inactive` permission. Connections add a second, opt-in access path: a **Connection Role** can carry permissions that a connected user's Contact inherits over the entity at the other endpoint (via `hook_entity_access`), which is powerful for delegating org-admin rights but is a configuration surface to design carefully. **A CRM is the most sensitive data a small organization holds** — names, addresses, relationships, correspondence, often giving history — so entity access has to be *designed*, not inherited, and deletion/anonymisation should exist before the first import, not after the first subject-access request.

---

- Store contacts as fieldable Drupal entities with first/middle/last name and email.
- Optionally link a Contact to a Drupal user account (manually or by matching email).
- Model organizations as their own entity type and bundles.
- Model fieldable relationships (job title, role, dates) between contacts and orgs via Connections.
- Define multiple Contact/Org/Connection bundles, each independently fielded.
- Deduplicate a contact database with the find-and-merge dedupe tool.
- Gate contact/org visibility with active-vs-inactive, per-bundle and "own record" permissions.
- Delegate access to an organization's data to its connected contacts via Connection Roles.
- Reference a contact from node content or expose it over JSON:API / Views.
- Build a supporter or donor database for a charity.
- Model an association's or professional body's members.
- Track a contact's organisation and employment history.
- Deactivate (soft-disable) contacts, orgs and connections instead of deleting them.
- Cascade-deactivate a contact's connections when the contact is made inactive.
- Auto-delete a contact's connections when the contact is deleted.
- Mirror a linked contact's email onto its Drupal user account.
- Autocomplete contacts by name or email on admin forms.
- Serve as a Drupal-side staging model that syncs to Salesforce or Blackbaud.
- Attach RedHen entities to a router-driven "Connections" tab on any linkable entity.
- Build a lightweight sales-pipeline or constituent-tracking tool without a second system.
- Customise CRM data with the same field UI, view modes and revisions as the rest of Drupal.
