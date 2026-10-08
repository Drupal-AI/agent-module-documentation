<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Bridges the Webform and Domain (Domain Access) modules so webforms and their submissions belong to domains.
- Restricts which webforms a user can submit and which submissions they can list/filter, based on the user's allowed domains.
- Adds a `domain_id` field to submissions and a domain filter to the webform and submission list UIs.

---

## Install & configure

- Enable the module (requires `domain` and `webform`).
- On each webform's Settings form, choose the Domains it is available on (stored in a `domain_ids` config key).
- Grant `bypass domain access webform restrictions` to trusted roles that should ignore the per-domain limits.

---

## Usage & behaviour

- `hook_webform_access()` forbids the `submission_page` operation when the webform's domains do not intersect the user's allowed domains — it only ever returns forbidden/neutral, never grants extra access, so it fails safe.
- User allowed domains are read from the `field_domain_access` and `field_domain_admin` user fields via `DomainWebformService::getUserAllowedDomains()`.
- New submissions get their `domain_id` set to the active (negotiated) domain in `hook_webform_submission_create()`.
- A `domain_id` base field is added to `webform_submission` for optimized per-domain querying.
- A query alter (`hook_query_domain_webform_filter_alter`) constrains submission listings to the user's allowed domains, unless they hold the bypass permission.
- Users without the bypass permission and no domain match are filtered to zero rows (condition on a null sid), not silently shown everything.
- The submission and webform list builders are overridden to add a Domain column and domain filter.
- The bypass permission is the single escalation path; audit who holds it.
- A Views filter plugin (`domain_webform_filter`) lets you build domain-scoped submission views.
- On new webform create/duplicate, the active domain is auto-assigned if none is set.
- Domain assignment on the webform is stored as a `;`-delimited `domain_ids` string in the webform config entity.
- The module restricts rather than grants, so it composes safely with core Webform access and Domain Access node grants.
- Use it on affiliate/multi-brand sites where each brand's editors must only see their own form submissions.
- Anonymous users load the anonymous account, which has no domain fields, so they are correctly excluded from restricted submission pages.
- Clear caches after changing a webform's domains so the entity `config_export` keys and list builders pick up the change.
- Verify the `field_domain_access`/`field_domain_admin` user fields exist (provided by Domain Access) or all non-bypass users resolve to zero allowed domains.
