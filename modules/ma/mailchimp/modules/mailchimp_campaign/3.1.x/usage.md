Mailchimp Campaign lets editors create, edit, test, send, and view stats for Mailchimp email campaigns directly from the Drupal admin, storing each campaign as a Drupal entity.

---

This submodule adds a `mailchimp_campaign` content entity and an admin UI at `/admin/config/services/mailchimp/campaigns` for managing campaigns without leaving Drupal. You compose a campaign by choosing a recipient audience (from `mailchimp_lists`) and filling template sections; a text filter (`FilterMailchimpCampaign`) and entity-autocomplete let you embed rendered Drupal entities into the campaign HTML so newsletter content can pull from site nodes. From the campaign's operations you can send a test email, send the campaign for real, and view open/click statistics pulled back from Mailchimp. Campaign create/edit/send actions are gated by the `administer mailchimp campaigns` permission, and developers can adjust recipients or template/content just before saving via `hook_mailchimp_campaign_alter()` and `hook_mailchimp_campaign_content_alter()`. It depends on Mailchimp Audiences and is aimed at teams that want to run their newsletter workflow inside Drupal rather than the Mailchimp web app.

---

- Compose a newsletter campaign from within Drupal.
- Pick the recipient audience for a campaign from connected Mailchimp lists.
- Embed a rendered Drupal node into campaign HTML via the campaign filter.
- Autocomplete and insert site entities into campaign content.
- Send a test email before the real send.
- Send a campaign to its audience from the admin UI.
- View open and click statistics for a sent campaign.
- Edit an existing draft campaign's template and content.
- Store campaigns as Drupal entities for reference and reuse.
- Delete campaigns that are no longer needed.
- Alter campaign recipients/template before saving with `hook_mailchimp_campaign_alter()`.
- Alter campaign template/content before saving with `hook_mailchimp_campaign_content_alter()`.
- Restrict campaign management to trusted editors via permission.
- Build recurring newsletters that pull the latest site content.
- Preview campaign content rendered with a dedicated filter format.
- Keep an editorial record of past campaigns in Drupal.
- Send announcement emails tied to site events or releases.
- Manage multiple campaigns from a single overview listing.
