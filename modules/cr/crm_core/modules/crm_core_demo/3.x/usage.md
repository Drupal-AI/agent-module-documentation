CRM Core demo installs example contact and activity type configuration so a fresh CRM Core install has sample bundles to explore.

---

This is a configuration-only helper module: it has no PHP code, routes, services or permissions.
Enabling it imports a set of `config/install` entities — individual/organization contact types and
activity types — via the standard module-install config mechanism. It depends on
`crm_core_contact` and `crm_core_activity` (so those entity types exist to receive the bundles).
Use it on a demo or evaluation site to get instant, sensible CRM structure; on a real project you
would normally define your own types instead and leave this module disabled.

---

- Seed a new CRM Core install with ready-made **contact and activity types**.
- Install a **Customer** individual type (`crm_core_contact.type.customer`).
- Install a **Supplier** organization type (`crm_core_contact.organization_type.supplier`).
- Install a **Household** organization type (`crm_core_contact.organization_type.household`).
- Install a **Meeting** activity type (`crm_core_activity.type.meeting`).
- Install a **Phone call** activity type (`crm_core_activity.type.phone_call`).
- Explore the CRM UI immediately without hand-building bundle types.
- Provide a starting point you can clone or adapt for your own contact/activity types.
- Demonstrate how activity types reference the activity-type plugin system.
- Support evaluation, screenshots, training and automated demo/test environments.
- Keep the demo separate so production sites can omit it.
