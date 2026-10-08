Embed ActiveCampaign hosted forms in Drupal content and, via submodules, sync webform submissions to ActiveCampaign contacts and browse ActiveCampaign campaigns, contacts and lists from the admin UI.

---

The ActiveCampaign module connects a Drupal site to the ActiveCampaign marketing-automation / CRM platform through the official `activecampaign/api-php` PHP SDK. The base module stores a site URL, API URL and API key in one config object (`activecampaign.settings`, edited at `/admin/config/services/activecampaign`) and exposes a single `activecampaign.api` service (`ActiveCampaignApi`) that wraps the SDK for listing forms, fetching contacts / lists / campaigns and syncing a contact. On top of that service it ships a custom field type (`active_campaign_field`) with two widgets (autocomplete or select list, both populated live from your ActiveCampaign form list) and a formatter that renders the chosen form by injecting ActiveCampaign's hosted `embed.php` script — so any fieldable entity (node, custom block, and therefore Layout Builder) can display a real ActiveCampaign form. Two optional submodules extend it: `activecampaign_dashboard` adds three read-only admin dashboard pages (campaigns, contacts, lists), and `activecampaign_webform` adds a Webform handler that maps submitted fields to an ActiveCampaign contact and syncs it on submission. The project targets Drupal 10.2+/11 and PHP 8.1+; a 2.x rewrite is on the roadmap and the custom YAML field mapping is documented as experimental.

---

- Connect a Drupal site to ActiveCampaign by entering the site URL, API URL and API key at `/admin/config/services/activecampaign`.
- Embed a live, hosted ActiveCampaign signup/marketing form inside a node by adding an "Active campaign field" and choosing a form.
- Place an ActiveCampaign form in a Layout Builder layout by adding the field to a custom block type and selecting a form.
- Let editors pick which ActiveCampaign form to show per entity, using a select-list widget populated from the account's forms.
- Let editors search and pick a form by name with the autocomplete widget instead of a long dropdown.
- Render the same ActiveCampaign form across many entities while keeping the embed script and base URL centrally configured.
- Capture newsletter or lead-gen signups directly in ActiveCampaign's own form (double opt-in, automations) while embedding it natively in Drupal pages.
- Sync a Drupal Webform submission to ActiveCampaign as a contact (email, first name, last name) with the Webform handler.
- Forward extra Webform answers to ActiveCampaign custom fields using the handler's YAML field-mapping (e.g. `field[345,0]: '[webform_field_machine_name]'`).
- Map a Webform field to an ActiveCampaign personalization tag (e.g. `field[%PERS_1%,0]: '[machine_name]'`).
- Add multiple ActiveCampaign handlers to a single Webform to push submissions to different field sets.
- Build a marketing lead pipeline: a contact-us or demo-request Webform that creates/updates the ActiveCampaign contact on submit.
- Review recent ActiveCampaign contacts (email, first/last name, created date) from a Drupal admin dashboard page.
- Review ActiveCampaign campaign performance (sends, open rate, click rate, bounce rate, unsubscribe rate) in a Drupal admin table.
- Review ActiveCampaign lists with subscriber and active-subscriber counts from Drupal.
- Jump from a dashboard row straight to the matching contact, campaign report or list on the ActiveCampaign app via generated deep links.
- Give marketing staff a read-only ActiveCampaign overview inside Drupal without handing out ActiveCampaign logins (gated by the `access activecampaign dashboard` permission).
- Reuse the `activecampaign.api` service from custom code to fetch forms, contacts, lists or campaigns, or to sync a contact.
- Programmatically resolve an ActiveCampaign form's title from its id, or build a deep link to a contact or campaign, via the API service helpers.
- Paginate through ActiveCampaign contacts, lists or campaigns 20 records at a time (dashboards use Drupal's core pager).
- Keep marketing configuration in code by exporting the `activecampaign.settings` config object between environments.
