Adds three read-only admin dashboard pages that list ActiveCampaign campaigns, contacts and lists inside Drupal.

---

`activecampaign_dashboard` is a submodule of the ActiveCampaign project. It depends on the base `activecampaign` module and reuses its `activecampaign.api` service to pull data live from ActiveCampaign and render it in Drupal admin tables. It registers a menu section at `/admin/activecampaign` and three form pages: Campaigns (`/admin/activecampaign/campaigns`), Contacts (`/admin/activecampaign/contacts`) and Lists (`/admin/activecampaign/lists`). Each page is a `FormBase` subclass of `ActiveCampaignDashboard` that overrides `getTableData()` to call the matching API method, build a `#type => table`, and page results 20 at a time with Drupal's core pager. Campaign rows show computed open/click/bounce/unsubscribe rates; contact and campaign/list names deep-link into the ActiveCampaign app. All pages require the `access activecampaign dashboard` permission and are entirely read-only (no submit action, no writes).

---

- Give marketing staff a read-only ActiveCampaign overview inside Drupal without ActiveCampaign logins.
- Browse recent ActiveCampaign contacts (email, first/last name, created date) from `/admin/activecampaign/contacts`.
- Review campaign performance — emails sent plus open, click, bounce and unsubscribe rates — at `/admin/activecampaign/campaigns`.
- Check ActiveCampaign lists with total and active subscriber counts at `/admin/activecampaign/lists`.
- Deep-link from a contact row to that contact's page in the ActiveCampaign app.
- Deep-link from a campaign row to that campaign's report overview in ActiveCampaign.
- Deep-link from a list row to the list's ActiveCampaign URL.
- Page through large contact / campaign / list sets 20 records at a time using the core pager.
- Restrict who sees ActiveCampaign data by granting `access activecampaign dashboard` to specific roles.
- Spot at a glance which campaigns underperform (low open/click rate) without leaving Drupal.
- Surface ActiveCampaign API/connection errors to admins (the pages show the API error as a message).
- Add the ActiveCampaign section to the Drupal admin menu (`/admin/activecampaign`) for quick marketing access.
- Provide an in-Drupal reporting tab for stakeholders who never log into ActiveCampaign directly.
- Confirm the ActiveCampaign API credentials work by loading a dashboard page and seeing live data.
- Use the dashboard as a lightweight monitor of list growth (active vs total subscribers) over time.
