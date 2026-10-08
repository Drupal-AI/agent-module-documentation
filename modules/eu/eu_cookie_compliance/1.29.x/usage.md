EU Cookie Compliance displays a configurable cookie‑consent banner (popup) that helps a site meet EU cookie / GDPR requirements by asking visitors for consent before non‑essential cookies and scripts run.

---

The module shows a themeable consent banner at the top or bottom of the page with a fully configurable message, agree/disagree/more‑info buttons, and an optional "privacy settings" tab for withdrawing consent. It supports two consent models: a simple "info" banner and a category‑based consent flow where visitors opt in to named cookie categories (each a `cookie_category` config entity), with the module able to block/disable JavaScript until the matching category is accepted. Consent can be recorded server‑side through pluggable `ConsentStorage` plugins (a basic database logger ships in the box) for GDPR record‑keeping. Banner display can be limited to EU visitors using either a server‑side GeoIP lookup or a JavaScript country check, and paths can be excluded from the banner. Everything is driven by a single settings form (`eu_cookie_compliance.settings`) whose values are stored as `eu_cookie_compliance.settings` config with full schema, and the strings are translatable via config translation. Site builders theme the banner through four Twig templates and matching theme hooks, and place a "Cookie settings" button anywhere via the supplied block. Developers extend behaviour with alter hooks (GeoIP match, path/popup visibility, cache id) and by writing new consent‑storage plugins. A `klaro_migrator` submodule helps sites move their configuration to the Klaro module.

---

- Show an EU‑law cookie‑consent banner before setting non‑essential cookies.
- Ask visitors to explicitly agree or disagree with cookie usage.
- Offer category‑based consent (e.g. functional, analytics, marketing) with per‑category opt‑in.
- Block or disable analytics/marketing JavaScript until the visitor consents.
- Record consent server‑side for GDPR audit trails via a ConsentStorage plugin.
- Restrict the banner to visitors from EU countries using GeoIP.
- Restrict the banner to EU visitors using a JavaScript‑based country check (cache‑friendly).
- Place the banner at the top or bottom of the page, fixed or scrolling.
- Provide a "More information" link to a privacy/cookie policy page.
- Add a persistent "Privacy settings" / withdraw‑consent tab so users can change their mind.
- Let visitors consent by clicking or by scrolling (configurable).
- Exclude specific paths (e.g. the privacy policy itself) from the banner.
- Fully customise the banner message and button labels, with translation per language.
- Theme the banner to match the site by overriding the supplied Twig templates.
- Style the banner for the Olivero theme with the bundled Olivero CSS variant.
- Place a "Cookie settings" button in any region via the provided block.
- Translate all banner text and category labels via config translation.
- Store the consent cookie for a configurable number of days before re‑asking.
- Reload the page (or run scripts) automatically once consent is granted.
- Support decoupled/multisite setups by choosing where consent is stored.
- Force the banner to reappear after a policy change by bumping the consent cookie.
- Add a custom consent‑storage backend (e.g. external CRM) with a ConsentStorage plugin.
- Programmatically hide the banner on certain node types via `hook_eu_cookie_compliance_show_popup_alter`.
- Override EU detection logic with `hook_eu_cookie_compliance_geoip_match_alter`.
- Migrate an existing EUCC configuration to the Klaro module using the klaro_migrator submodule.
- Meet accessibility and disclosure expectations for privacy regulations beyond the EU (e.g. GDPR‑style laws).
