CRM Core is a framework of modules that add contact-management (CRM) functionality — contacts, activities, matching and user synchronization — to a Drupal site.

---

CRM Core is the base module of a small suite. On its own it only wires up the CRM admin sections (`/admin/structure/crm-core`, `/admin/config/crm-core`, and the `/crm-core` overview), a general settings form, and an optional "CRM theme" negotiator that renders every `/crm-core` page with a chosen admin theme. The real functionality lives in its submodules: **CRM Core Contact** (Individual and Organization content entities with bundle types and primary fields), **CRM Core Activity** (activity records linked to contacts through dynamic entity references), **CRM Core Match** (a pluggable engine framework for finding duplicate contacts), **CRM Core User Synchronization** (pairing Drupal user accounts with contact records), and **CRM Core demo** (sample contact/activity types). Contacts, activities and their bundle types are all standard Drupal entities, so they gain Field UI, Views, revisions and per-bundle permissions for free. The project is mature but only lightly maintained; new Drupal 7 users are pointed at the separate "Drupal CRM" project.

---

- Build a lightweight in-Drupal CRM without a third-party SaaS.
- Store people as **Individual** contacts and companies as **Organization** contacts.
- Define multiple **individual types** (e.g. Customer, Lead) and **organization types** (e.g. Supplier, Household) as bundles.
- Add arbitrary fields (address, email, phone, custom) to any contact type via Field UI.
- Designate "primary" address / email / phone fields per contact type for quick programmatic access.
- Record **activities** (meetings, phone calls, emails) against one or more contacts.
- Define custom **activity types** backed by activity-type plugins.
- Track a full **revision history** for Individual and Organization contacts.
- Apply granular, per-bundle **permissions** (create / edit own / edit any / view own / view any) to contacts and activities.
- Give each contact record an **owner** (Drupal user) and support "own" vs "any" access.
- Deduplicate contacts with configurable **matching engines** that score field-by-field matches against a threshold.
- Match on name, email, telephone, phone number, address, dates, integers, strings, text and select fields using the shipped field handlers.
- Automatically create a contact record whenever a new **user account** is registered.
- Relate existing users to existing contacts by matching email addresses.
- Show a user's related contact information on their **user profile** page.
- Place an "Edit own contact information" block so users can self-service their linked contact.
- Route new users of specific **roles** to specific contact types via user-sync rules.
- Use a dedicated **admin theme** for all CRM pages while keeping the front-end theme elsewhere.
- Merge, join-into-household or email contacts through action plugins (VBO-style bulk operations).
- Integrate contacts and activities into custom **Views** listings and reports.
- Seed a demo environment quickly with the bundled **CRM Core demo** contact and activity types.
- Extend the system with custom activity-type plugins, matching engines and match-field handlers.
