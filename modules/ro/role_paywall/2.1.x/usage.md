<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Paywall hides configured fields on premium content from users who lack a subscriber role — the "read the first paragraph, then subscribe" pattern publishers use.

---

Configuration is per entity type and bundle at `/admin/config/content/role_paywall`: choose which field marks an item as premium (or make every item premium), which fields to hide, and which roles may see them, with `access paywalled content` as a permission alongside the role list. `RolePaywallManager` computes the decision and there is a block for the "subscribe to continue" prompt. Enforcement is `$build[$field_name]['#access']` set inside `hook_entity_view()` for the `full` view mode only, which hides an element while it is being rendered and leaves the stored data unchanged, so other view modes (such as a teaser that includes the field), JSON:API/REST, Views and search indexing are not filtered by the module. Keep paywalled fields out of non-full displays and APIs when the content must stay restricted.

---

- Show a teaser and hide the rest for non-subscribers.
- Restrict premium articles to a subscriber role.
- Mark individual articles as premium.
- Prompt visitors to subscribe.
- Hide selected fields from anonymous readers.
- Run a membership publishing model.
- Configure the paywall per content type.
- Grant access by role.
- Show a subscribe block on paywalled content.
- Restrict a research archive.
- Support a magazine subscription.
- Choose which fields sit behind the wall.
- Preview content to drive sign-ups.
- Gate premium video descriptions.
- Support a members-only news section.
- Apply the paywall to several entity types.
- Combine with a commerce subscription.
- Reserve analysis for paying members.
