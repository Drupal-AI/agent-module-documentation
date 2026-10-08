Translation Management Tool (TMGMT) is a framework for translating Drupal content: it collects translatable text into translation **jobs**, sends them to a configured translation **provider** (machine, file-based, or human), and lets editors review and accept the returned translations before they are saved.

---

TMGMT decouples *what* gets translated (sources) from *who* translates it (translators/providers) and coordinates the two through a translation workflow. A **source plugin** (`Plugin\tmgmt\Source`) exposes translatable text — content entities, config entities, or locale strings — as flat data items; a **translator/provider plugin** (`Plugin\tmgmt\Translator`) takes that data and returns translations, whether automatically (a machine-translation API), via a round-tripped file (XLIFF/HTML), or from an in-Drupal human translator. When you request a translation, TMGMT creates one `tmgmt_job` config-driven content entity per target language, each holding `tmgmt_job_item` entities (one per translated thing) whose text lives as structured data managed by the `tmgmt.data` service. Jobs move through states (unprocessed → active → finished) and job items through review states (inactive → active → needs review → accepted/aborted). A built-in **review UI** lets editors compare source and translation side by side, edit segments, request revisions, and accept per item; `tmgmt_message` entities log the conversation and events. Providers are stored as `tmgmt_translator` config entities configured at Admin → Translation → Providers, and global behavior (cart/quick checkout, cron submission, word counting) lives in the `tmgmt.settings` config object. The suite ships submodules for each source type (content, config, locale) and translator type (file export/import, local human translation, plus a reusable language-combination field), and invites extension through plugin types, checkout hooks, and a documented job API.

---

- Translate nodes and other content entities into multiple languages from their Translate tab.
- Request a batch translation of many pieces of content in one job via the sources overview.
- Send content to a machine-translation provider and review the result before publishing.
- Export content to an XLIFF file, hand it to an external agency, and import the translation back (tmgmt_file).
- Route translation work to in-house human translators inside Drupal (tmgmt_local).
- Review returned translations segment by segment, editing text before accepting.
- Reject a poor translation and request a revision from the provider.
- Auto-accept finished translations for a trusted provider to skip manual review.
- Configure multiple providers (e.g. a machine translator for drafts, humans for final copy).
- Translate configuration entities such as views, fields, and menus (tmgmt_config).
- Translate interface/locale strings collected from `locale` (tmgmt_locale).
- Add content to a translation "cart" and check it all out into jobs at once.
- Set up continuous jobs that pick up new/changed content automatically on cron.
- Track which content exists in which language and what jobs are in progress via overviews.
- Map remote provider language codes to Drupal langcodes per provider.
- Gate who can create, submit, accept, or delete translation jobs with permissions.
- Build a custom provider plugin that talks to a proprietary translation API.
- Build a custom source plugin to expose a non-standard data type for translation.
- Suggest related content (referenced entities) to translate together in one job.
- React to the checkout flow with `hook_tmgmt_job_checkout_before/after_alter()`.
- Alter source or translation text just before it is sent or imported via data-item hooks.
- Log and audit every state change and provider message through `tmgmt_message` entities.
- Count translatable words up front to estimate translation cost.
- Export provider configuration between environments as `tmgmt_translator` config.
- Assign translation tasks to specific local users based on their language abilities (tmgmt_local + tmgmt_language_combination).
- Abort a running job or job item that is no longer needed.
- Deploy a demo of the full workflow with the tmgmt_demo submodule.
- Drive the whole workflow programmatically with the Job/JobItem entity API and `tmgmt.job_checkout_manager`.
