Convivial Profiler builds a behavioural visitor profile in the browser and uses it to personalise content, driven by an admin-configured pipeline of sources, processors and destinations executed by an external Convivial Profiler JavaScript SDK.

---

The module itself is thin Drupal glue: it stores a `convivial_profiler.settings` config object (a `site_id`, a `license_key`, feature toggles and a `profilers` array), attaches an external JS bundle (`cdn.jsdelivr.net/gh/morpht/convivial-profiler`) plus an init script, and exposes the whole pipeline definition to the browser via `drupalSettings.convivialProfiler`. All actual data collection, storage and personalisation happens client-side in the SDK — the profile lives in browser cookies and localStorage, not in Drupal's database. Each "profiler" is an ordered set of Sources (read a cookie, query param, meta tag, user agent, Accept-Language, time, etc.), Processors (map/accumulate/count/log values, GeoIP lookup, language normalisation, thresholds), and Destinations (copy/flag/set values to cookie or localStorage, calculate top/season/office-hours, fill or track forms, push `datalayer_event`s to Google Tag Manager). Profilers are defined at `/admin/config/convivial/profiler` (list/add/edit/delete forms, all gated by `administer convivial profiler`), and site-wide behaviour (site ID, licence key, event tracking, cookie-consent gating, and block-style visibility conditions) is set at `/admin/config/convivial/profiler/settings`. Assets are only attached when both `site_id` and `license_key` are set and the visibility conditions pass. Three YAML+attribute plugin types (`profiler_source`, `profiler_processor`, `profiler_destination`) make the palette of pipeline steps extensible by other modules or themes. The optional `convivial_profiler_sync` submodule adds JSON export/import of the profiler definitions. A Key entity or environment variable is not involved: the licence key is a plain config string that is intentionally sent to the browser as SDK configuration.

---

- Personalise page content based on a visitor's inferred interests without server-side tracking storage.
- Build a topic-affinity profile from the pages a visitor reads (page-view counters into dimensions, then "top" topic).
- Store a client ID and behavioural flags in cookies/localStorage for use by front-end personalisation logic.
- Push behavioural events (clicks on `.cp_trackable a.btn`) into `window.dataLayer` for Google Tag Manager / GA.
- Send `datalayer_event` destinations to GTM for downstream analytics and segmentation.
- Detect a visitor's approximate location via the GeoIP-lookup processor and map it to a region/zone.
- Convert a browser language (`navigator.language`) into a simple or full language code for targeting.
- Derive the visitor's local season from latitude, or whether an office is currently open from time + timezone.
- Set a "flag" (on/off) or boolean key when a page-view threshold is exceeded (e.g. mark returning/engaged users).
- Track search queries entered on a search page and log the recent terms for personalisation.
- Pre-fill form fields from stored profile values (the `formfiller` destination).
- Track form responses (e.g. sentiment) into the dataLayer on submit (the `formtracker` destination).
- Gate all profiling behind cookie-consent so the SDK only runs once consent is given.
- Limit profiling to specific pages, node bundles, user roles or languages via block-style visibility conditions.
- Reorder profilers by weight so pipeline steps run in a deliberate sequence.
- Enable or disable individual profilers, or mark them "deferred" for later execution.
- Extend the source/processor/destination palette from a custom module using the plugin YAML + attribute API.
- Alter existing pipeline-step definitions with `hook_convivial_profiler_profiler_source_info_alter()` and its processor/destination siblings.
- Export a site's profiler configuration as JSON and import it into another site or an external Convivial system (sync submodule).
- Run the profiler as free/community usage or with a purchased commercial licence key.
- Clean up stale client-side stored values automatically when the client ID changes (`client_cleanup`).
- Use time-of-day sources to vary messaging (e.g. morning vs. evening greetings) entirely client-side.
