Message Subscribe UI adds the end-user front end for Message Subscribe: a per-user "Subscriptions" tab that lists what a user is subscribed to (via Views), a "Manage subscriptions" block for subscribing on entity pages, and the `administer message subscribe` permission.

---

The base Message Subscribe module is API-only; this submodule provides the humans' interface. It adds a **Subscriptions** local task at `/user/{user}/message-subscribe` (`SubscriptionController`) with one sub-tab per enabled `subscribe_*` flag (built by a local-task deriver), each rendering a Views listing of that user's flagged entities. Which view a flag uses is stored as a **third-party setting** `message_subscribe_ui.view_name` on the flag (default `<prefix>_<entity_type>:default`), and the module adds a "View to use for the Message Subscription UI" select to every subscription flag's edit form so you can change it. It ships the default listing views `subscribe_node`, `subscribe_taxonomy_term`, and `subscribe_user`. A **"Manage subscriptions"** block (`message_subscribe_ui_block`) renders on entity pages with a checkbox to subscribe/unsubscribe to the current entity (and its referenced entities) using the appropriate flag. The submodule also **defines the `administer message subscribe` permission** that the base module's settings route relies on. Access to another user's Subscriptions tab requires that permission; otherwise users can only see their own.

---

- Give users a "Subscriptions" tab on their profile listing everything they follow.
- Show one sub-tab per subscription type (content, terms, users) built automatically from enabled flags.
- Let users subscribe/unsubscribe to the entity they're viewing via the "Manage subscriptions" block.
- Place the subscriptions block on node pages so readers can follow content inline.
- Render each subscription list with a configurable View (change it per flag).
- Point a flag's subscription UI at a custom View via the `message_subscribe_ui.view_name` third-party setting.
- Swap the content-subscriptions listing to an email-aware View (as `message_subscribe_email` does).
- Grant site builders the `administer message subscribe` permission to manage others' subscriptions.
- Let administrators view any user's subscriptions tab (with the permission).
- Provide a self-service subscription management page without custom code.
- Use the shipped `subscribe_node` / `subscribe_taxonomy_term` / `subscribe_user` views as a starting point.
- Add a "View to use" selector on subscription flag forms for site builders.
- Expose subscription toggles for a page's referenced entities (e.g. the author, tagged terms).
- Integrate subscription management into the user account area under a standard local task.
- Customize the subscriptions listing (columns, filters) by editing the underlying View.
- Restrict who can see or manage subscriptions through the permission and flag action access.
- Let anonymous-to-authenticated flows manage subscriptions once users can flag.
- Surface the subscriptions tab title per flag (uses the flag's label).
- Build a "following" experience on top of Flag with no bespoke controller code.
- Combine with Message Subscribe Email so the same UI also toggles email delivery.
