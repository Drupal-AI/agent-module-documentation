The curation submodule adds a JavaScript-driven discovery interface at Content → Acquia Content Hub, letting editors browse and curate content available in the Content Hub service.

---

It provides a single admin route (`acquia_contenthub_curation.discovery`) at
`/admin/content/acquia-contenthub`, gated by the base `administer acquia content hub`
permission, that loads a discovery UI (a front-end application shipped as a library) for
browsing content the site can syndicate. It has no configuration form, no permissions of its
own, no Drush commands, and no config schema — it is purely a UI layer over the base module's
connection, aimed at editorial discovery and curation of syndicated content rather than the
mechanical publish/subscribe queues handled by the publisher and subscriber submodules. It
depends only on `acquia_contenthub`.

---

- Browse content available in the Content Hub service from the Drupal admin.
- Give editors a discovery interface under Content → Acquia Content Hub.
- Curate which syndicated content is interesting for the site.
- Provide a visual entry point to Content Hub for non-technical staff.
- Explore available content before attaching syndication filters.
- Review syndicated items without using Drush.
- Add a discovery tab to the standard content administration area.
- Access the interface only for users with "Administer Acquia Content Hub".
- Complement publisher/subscriber queues with an editorial curation view.
- Use as the human-facing counterpart to the base module's programmatic APIs.
- Discover content across origins connected to the same Content Hub subscription.
- Serve as a launch point for curating a multi-site content pool.
- Support editorial workflows that pick content to pull into the local site.
- Provide an admin-route (CSRF/admin-protected) UI for curation tasks.
- Keep curation UI concerns separate from import/export logic.
