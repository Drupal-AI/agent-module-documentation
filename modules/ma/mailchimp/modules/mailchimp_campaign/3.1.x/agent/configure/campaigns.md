# Managing campaigns

`mailchimp_campaign` is a content entity managed under
`/admin/config/services/mailchimp/campaigns`. All routes require the
`administer mailchimp campaigns` permission.

| Route / path | Action |
|---|---|
| `mailchimp_campaign.overview` — `/admin/config/services/mailchimp/campaigns` | List campaigns. |
| `mailchimp_campaign.add` — `.../campaigns/add` | Create a campaign. |
| `entity.mailchimp_campaign.edit_form` — `.../{id}/edit` | Edit a draft. |
| `entity.mailchimp_campaign.send` — `.../{id}/send` | Send the campaign to its audience. |
| `entity.mailchimp_campaign.sendtestmail` — `.../{id}/sendtestmail` | Send a test email. |
| `entity.mailchimp_campaign.stats` — `.../{id}/stats` | View open/click stats. |
| `entity.mailchimp_campaign.delete_form` — `.../{id}/delete` | Delete a campaign. |

Composing content:
- Pick a recipient audience (provided by `mailchimp_lists`) and fill template sections.
- Embed rendered Drupal entities in the HTML using the **Mailchimp Campaign** text filter
  (`FilterMailchimpCampaign`) plus the entity-autocomplete route
  (`mailchimp_campaign.entity_autocomplete`).

Programmatic tweaks (from the base module): `hook_mailchimp_campaign_alter()` (recipients +
template) and `hook_mailchimp_campaign_content_alter()` (template + filtered content) fire
before a campaign is saved to Mailchimp.
