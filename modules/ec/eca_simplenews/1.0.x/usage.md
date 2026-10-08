<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Simplenews adds Simplenews newsletter subscribe/unsubscribe actions and subscription-state conditions to the ECA (Event-Condition-Action) rules engine.

---

ECA Simplenews is a lightweight bridge between the ECA rules engine and the Simplenews newsletter module. Once installed alongside `eca` and `simplenews`, it makes newsletter subscription operations available as building blocks inside no-code ECA models: two actions ("Subscribe to newsletter" and "Unsubscribe from newsletter") and three conditions ("User is currently subscribed", "User has ever subscribed" and "Check for self-unsubscribes"). Each action and condition works against a newsletter identified by its machine name and resolves the affected person from the `[user:mail]` token, delegating to Simplenews' own `simplenews.subscription_manager` service and `Subscriber` entity. There is no settings page, no route and no permission of its own - you compose everything through ECA's model editor. A typical model is an "entity presave" event on the User entity wired to the Subscribe action, optionally gated by conditions such as an ECA role check, so users are subscribed automatically when their account is created or updated.

---

- Subscribe a user to a named newsletter automatically when their account is created.
- Subscribe a user to a newsletter when their account is updated (presave User event).
- Unsubscribe a user from a newsletter as part of an ECA workflow.
- Drive newsletter opt-in from an ECA model instead of custom code.
- Branch an ECA model on whether the user is currently subscribed to a newsletter.
- Branch an ECA model on whether the user has ever subscribed to a newsletter.
- Skip re-subscribing users who previously unsubscribed themselves ("Check for self-unsubscribes").
- Send an admin notification (via ECA's Send email action) when the self-unsubscribe check flags a possible false positive.
- Add a newsletter subscription step to an existing content-workflow model.
- Combine a subscription action with ECA role/permission conditions to limit who gets subscribed.
- Automatically subscribe members of a given role to an internal newsletter.
- Keep a "members" newsletter in sync with account lifecycle events.
- Trigger a subscribe/unsubscribe from any ECA-supported event, not just user events.
- Use the `[user:mail]` token so the acting user's own address is the subscription target.
- Reference the newsletter by its machine name (for example `default`) in the plugin form.
- Prototype newsletter automations without writing a custom module.
- Gate a welcome-newsletter subscription behind a condition that checks current subscription state.
- Prevent duplicate subscriptions by checking "User is currently subscribed" before subscribing.
- Build a re-engagement model that only targets users who have subscribed in the past.
- Integrate newsletter subscription into a multi-step ECA business process.
- Respect subscriber intent by consulting subscription history before automated resubscribes.
- Automate opt-out handling as part of an account-deactivation ECA model.
