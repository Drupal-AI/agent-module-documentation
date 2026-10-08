TMGMT Crowdin is a Translation Management Tool (TMGMT) translator plugin that submits Drupal content to the Crowdin localization platform and pulls completed translations back into the site.

---

TMGMT manages the Drupal-side translation workflow (jobs, job items, source/target languages, checkout) and delegates the actual translation to a provider plugin. TMGMT Crowdin is that provider for Crowdin, a commercial localization platform. When a job is requested, the plugin exports each job item to a Crowdin-friendly WebXML file, creates a per-job folder inside a "Drupal Connector" root directory in the configured Crowdin project, and uploads the files through the Crowdin API v2. Translations are retrieved either on demand ("Fetch translations" in the job checkout UI) or automatically when Crowdin fires a file-translated / file-approved webhook back to the site. The plugin adds a `crowdin` TMGMT translator plugin, a `webxml` tmgmt_file format plugin, and a webhook endpoint controller. It requires the `tmgmt` and `tmgmt_file` modules and a Crowdin account with a project and a Personal Access Token.

---

- Use Crowdin as a TMGMT translation provider for a Drupal site.
- Add a "Crowdin" translator under TMGMT and connect it to a Crowdin project.
- Send Drupal content (nodes, taxonomy, custom entities, config) to Crowdin for translation.
- Automate localization of a multilingual Drupal website through Crowdin.
- Export TMGMT job items as WebXML and upload them to a Crowdin project folder.
- Organize uploaded files under a per-job folder inside a "Drupal Connector" directory in Crowdin.
- Pull completed translations back into Drupal from the job checkout screen.
- Auto-import translations when Crowdin fires a file.translated or file.approved webhook.
- Register the Crowdin webhook automatically the first time a job is submitted.
- Support Crowdin Enterprise by setting an organization domain.
- Restrict imports to approved-only translations based on the Crowdin project's export settings.
- Update source texts in Crowdin after editing content in Drupal ("Update Source Texts").
- Abort a translation job and remove its remote Crowdin folder.
- Attach a per-job description to give Crowdin translators context.
- Map Drupal languages to Crowdin target languages when submitting a job.
- Use Crowdin's machine translation, translation memory, and QA features on the exported content.
- Run continuous translation jobs through TMGMT with Crowdin as the backend.
- Integrate an existing Crowdin localization project with a Drupal editorial workflow.
- Localize content in multiple target languages from a single Crowdin project.
- Keep Drupal and Crowdin in sync for ongoing translation projects.
