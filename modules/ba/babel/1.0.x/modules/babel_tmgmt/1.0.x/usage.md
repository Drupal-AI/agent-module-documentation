Babel submodule that bridges Babel's curated source strings to TMGMT, so they can be sent to any TMGMT translation provider — including continuous, cron-driven jobs.

---

`babel_tmgmt` (requires `drupal/tmgmt`) registers a `babel` TMGMT source plugin. Each Babel source string (identified by its 64-char hash) becomes a TMGMT job item whose data are the source string's plural variants; placeholders like `@name`/`%value`/`!raw` are detected and marked so translators do not alter them. The submodule adds a "TMGMT integration" section to the Babel settings form to choose which TMGMT translators are used, storing only the selected translator IDs in `babel_tmgmt.settings` (TMGMT owns the actual provider connections and credentials). For continuous TMGMT jobs, a cron hook plus a queue worker create job items for every untranslated, active, unlocked string for each continuous job's target language, and event subscribers automatically delete the corresponding job items when a source string is disabled or its translation is locked in Babel — so manual translations are never re-sent or overwritten.

---

- Send Babel's curated, active, unlocked strings to any configured TMGMT translator (machine or human/vendor).
- Machine-translate the whole UI (code, config, content-entity strings) through TMGMT providers.
- Use TMGMT continuous jobs to keep translations up to date automatically as new strings appear.
- Auto-create job items on cron for every untranslated, active, unlocked string per continuous job.
- Automatically remove pending job items when a string is deactivated in Babel.
- Automatically remove pending job items when a translation is locked (manual translations win).
- Choose which TMGMT translators Babel uses from the Babel settings page.
- Preserve translation placeholders when handing strings to translators (escaped so they are not translated).
- Translate strings with multiple plural variants via TMGMT, filling target plural forms from the source.
- Route only approved (active) strings to paid/vendor translators, avoiding wasted translation of admin-only strings.
