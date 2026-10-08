Submodule of Campaign Monitor that gives logged-in users a subscription-management page on their user profile, where they can view and change which Campaign Monitor lists they are subscribed to.

---

The module adds a `/user/{user}/campaignmonitor` route (`CampaignMonitorUserController::subscriptionPage`)
gated by the `access campaign monitor user` permission, exposed as a profile tab. The controller builds the
parent module's `CampaignMonitorSubscribeForm` seeded with `campaignmonitor_user.settings` (headings and
"I'm interested in" text), so the user sees the same subscribe UI (email pre-filled from their account, list
checkboxes / single-list fields) scoped to themselves. A `CampaignMonitorUserManager` service (extends the
parent manager) and an admin form at `admin/config/services/campaignmonitor/user` (perm `administer
campaignmonitor`) let admins tune the profile subscription form. Requires the parent `campaignmonitor` module.
The controller serves the current user's subscribe form; the `{user}` path parameter is not used to load
another account's private subscription data.

---

- Give users a "My Subscriptions" tab on their profile.
- Let a user see which newsletter lists they belong to.
- Let a user subscribe to additional lists from their profile.
- Let a user unsubscribe from lists they no longer want.
- Pre-fill the subscribe form with the user's account email.
- Customise the profile section headings and intro text via config.
- Provide self-service newsletter preference management without admin help.
- Reuse the parent module's list and custom-field configuration on the profile form.
- Gate the profile subscription page behind the `access campaign monitor user` permission.
- Offer a per-user complement to the site-wide subscribe block.
- Configure the profile form defaults from the admin settings page.
- Keep subscription preferences editable alongside other profile settings.
- Present the subscribe UI as a dedicated profile tab rather than a block.
- Support single-list or user-select subscription modes on the profile page.
- Show custom-field inputs (text/select/date) for lists that define them.
- Let members opt into new lists as they are enabled by admins.
- Provide a consistent subscribe experience between registration, block and profile.
