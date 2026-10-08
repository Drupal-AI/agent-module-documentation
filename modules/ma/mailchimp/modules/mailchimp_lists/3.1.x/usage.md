Mailchimp Audiences (mailchimp_lists) ties Drupal entities to Mailchimp audiences by adding a subscription field type, so users (or other entities) can be subscribed, unsubscribed, and mapped to merge fields.

---

This submodule of Mailchimp turns Mailchimp audiences (formerly "lists") into first-class Drupal integration points. It provides a `mailchimp_lists_subscription` **field type** you attach to an entity — typically the user entity — that stores whether the entity is subscribed to a given audience and exposes a subscribe/unsubscribe widget. Field widgets (`MailchimpListsSelectWidget`, info widget) render the subscription UI on entity forms, and formatters display or offer a subscribe control. An admin overview at `/admin/config/services/mailchimp/lists` lists the account's audiences (cached via the base module), a fields page maps Drupal fields to Mailchimp merge variables, and batch tools let you push merge-variable updates for existing subscribers and configure per-audience webhooks. Interest groups are surfaced as selectable options so subscribers can pick preferences. Together with the base module's alter hooks (`hook_mailchimp_lists_mergevars_alter`, `hook_mailchimp_lists_interest_groups_alter`), it is the mechanism most sites use to keep Drupal users in sync with Mailchimp audiences.

---

- Add a "Subscribe to newsletter" field to the user registration form.
- Subscribe/unsubscribe users to a Mailchimp audience from their profile.
- Map Drupal user fields to Mailchimp merge variables (FNAME, LNAME, etc.).
- Attach subscription fields to entities other than users.
- Offer multiple audiences and let users opt into each independently.
- Present Mailchimp interest groups as checkboxes on the subscribe form.
- Batch-update merge variables for all subscribers after a field change.
- Configure a per-audience webhook so external changes flow back into Drupal.
- Reset/clear the cached audience data when audiences change in Mailchimp.
- Display an entity's current subscription status with a field formatter.
- Enforce double opt-in on subscription with the base module's setting.
- Keep user profile data in sync with Mailchimp merge fields on save.
- Let editors choose which audience a given content type subscribes to.
- Segment subscribers by mapping Drupal data to Mailchimp merge tags.
- Alter merge vars per entity before sending via the mergevars hook.
- Alter interest group selections before submission via the interest-groups hook.
- Review all audiences connected to the site from one overview page.
- Provide a subscription preferences page users can revisit and update.
