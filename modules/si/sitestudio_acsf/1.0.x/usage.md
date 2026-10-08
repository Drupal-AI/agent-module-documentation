Site Studio ACSF moves Acquia Site Studio's generated Twig templates and stylesheet JSON out of the filesystem and into the database, so Site Studio behaves consistently on distributed-filesystem/multisite platforms such as Acquia Site Factory.

---

Acquia Site Studio (formerly Cohesion) compiles a site's design system into generated assets: Twig templates and stylesheet JSON. By default those live on the filesystem. On a platform where the codebase is treated as immutable and the filesystem is distributed or per-site — Acquia Site Factory being the headline case — rapid read/write of those generated files can lead to inconsistent or unexpected Site Studio behaviour. This module flips both stores over to the database. It does two things: a service-provider alter (`SiteStudioAcsfServiceProvider::alter()`) aliases `cohesion.template_storage` to `cohesion.template_storage.key_value` (KeyValue-backed Twig template storage), and a config override (`StylesheetJsonStorageOverride`) forces `cohesion.settings:stylesheet_json_storage_keyvalue` to TRUE so stylesheet JSON is also stored in the database. On install it sets its own module weight to `-100` so its storage services register early, rebuilds the kernel, and warns that a full Site Studio rebuild is needed to migrate existing templates into the database. `hook_requirements()` reports, on the status page, whether each store is currently Database or Filesystem. There is no UI, no route, no permission, and nothing to configure — enabling the module is the entire configuration. It requires the `cohesion_templates` module and `acquia/cohesion >= 6.3.5`, both commercial Site Studio components; on any stack without Site Studio it has nothing to do.

---

- Run Acquia Site Studio on Acquia Site Factory without generated-asset filesystem inconsistencies.
- Store Site Studio Twig templates in the database instead of the filesystem.
- Store Site Studio stylesheet JSON in the database instead of the filesystem.
- Avoid unstyled or inconsistent pages caused by distributed-filesystem read/write of Site Studio assets.
- Improve read/write consistency of Site Studio state across a multisite platform.
- Enable database template storage introduced in Site Studio v6.3.5.
- Migrate existing Site Studio templates into the database by running `drush cohesion:rebuild`.
- Trigger the same migration from the UI at `/admin/cohesion/developer/rebuild`.
- Check on the status report whether Site Studio template storage is Database or Filesystem.
- Check on the status report whether stylesheet JSON storage is Database or Filesystem.
- Guarantee the module's storage services load before other modules via its `-100` weight.
- Provision a new Site Factory site whose Site Studio state must survive an immutable-codebase deployment.
- Keep a design system intact across a Site Factory release where the filesystem is not persistent.
- Diagnose a Site Studio site rendering unstyled after a deployment by confirming storage is the database.
- Reduce reliance on the local filesystem for Site Studio in containerised or ephemeral environments.
- Trade increased database size and rebuild/sync load for storage consistency, deliberately.
- Audit an inherited Site Factory site to confirm Site Studio uses database storage.
- Verify Site Studio storage assumptions after a core or Site Studio upgrade.
- Plan a Site Studio multisite build on a platform with a non-persistent filesystem.
- Remove the module (and rebuild) to revert Site Studio to filesystem storage.
