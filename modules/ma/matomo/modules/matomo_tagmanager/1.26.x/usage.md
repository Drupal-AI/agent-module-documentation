Matomo Tag Manager (a submodule of Matomo Analytics) injects one or more Matomo Tag Manager (MTM) container snippets into your site, letting you manage tags/triggers in Matomo instead of hard-coding a tracker.

---

Where the parent Matomo module outputs a fixed tracking snippet, this submodule instead loads MTM **containers**, each a `matomo_tagmanager_container` config entity holding a container ID and its embed URL. You manage containers in an admin collection (`/admin/config/system/matomo/tagmanager`) with add/edit/delete/enable/disable operations, and enabled containers are attached to pages so their MTM code runs. Because containers are config entities they are exportable and deployable like any other configuration, and a single permission gates administration. This is the right choice when your analytics/marketing team wants to add and change tags (analytics, ads, heatmaps, custom events) through the Matomo Tag Manager UI without a Drupal deployment for each change. It depends on the parent `matomo` module.

---

- Load a Matomo Tag Manager container snippet on the site.
- Manage tags/triggers in Matomo rather than editing Drupal code.
- Run multiple MTM containers (e.g. per brand or per environment).
- Enable or disable a container without uninstalling anything.
- Deploy container configuration across environments as exported config.
- Let a marketing team add new tags without a code deploy.
- Add conversion or event tracking through MTM triggers.
- Swap a staging container for a production container per environment.
- Add heatmap or session-recording tags via MTM.
- Centralize third-party marketing tags behind one container.
- Restrict who can configure Tag Manager with a dedicated permission.
- Temporarily disable a container while debugging.
- Add a new container ID and embed URL from the admin UI.
- Keep the tracking snippet and tag manager separate but on the same Matomo instance.
- Roll out a tag change to all pages instantly via MTM.
- Manage A/B-test or personalization tags through Matomo.
- Version container config alongside the rest of the site config.
- Delete a container that is no longer needed.
