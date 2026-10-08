<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contribute — service, display & data model

## Service `contribute.manager` (`Drupal\contribute\ContributeManager`)
Interface `ContributeManagerInterface`. Constructed with `@cache.default`, `@http_client`, `@date.formatter`, `@config.factory`; reads `status`/`account_type`/`account_id` from `contribute.settings` at build time.

Public methods:
- `getStatus(): bool` — the config `status` flag.
- `getAccountType(): ?string` / `getAccountId(): ?string` — current values.
- `setAccountType($t)` / `setAccountId($id)` — override in-memory (used by the form during validation before persisting).
- `getAccount($display_type = TRUE): array` — account block render data.
- `getMembership(): array` — Drupal Association membership block.
- `getContribution(): array` — contribution-activity block.

Each of the three `get*` builders returns an array always containing a `status` bool; on success also `value` (renderable/markup) and often `description` (a link/button render array), plus for account: `url`, `name`, `created`, `image`, `organizations`, and a nested `value` render array. Results are cached in `cache.default` under CID `contribute.{account|membership|contribution}.md5("{type}.{id}")` for 1 hour with cache tag `contribute`; an empty `account_id` uses the sentinel `anonymous` (no remote calls, generic messaging). `$display_type` on `getAccount` only toggles whether a "Configure" link is added.

### Outbound Drupal.org calls (protected `get()`, Guzzle, per-request static cache)
- User: `https://www.drupal.org/api-d7/user.json?name={id}` (requires exactly 1 match); avatar scraped from `https://www.drupal.org/u/{id}` HTML (`/user-pictures/picture-…`); member badge detected by `association_ind_member_badge.svg` / `association_org_member_badge.svg` on that page; org names resolved from `field_organizations` URIs.
- Organization: `https://www.drupal.org/api-d7/node.json?type=organization&title={id}` (exactly 1 match); logo from `field_logo` file `.json`; badge scraped from the org page HTML.
- Contribution `status` is TRUE when the user has `field_contributed`/`field_drupal_contributions`, or the org has `field_contributions`/`field_org_issue_credit_count`. Membership success → "You Rock!"; contribution success → "You are a Rockstar!". All failures degrade to the generic join/donate/get-involved messaging with links to drupal.org association/contribute pages.

## Display integration
- `hook_preprocess_status_report_page()` — when `getStatus()`, wraps the status report's `general_info` with a `#theme => contribute_status_report_community_info` render element built from the three getters. `contribute.install` sets module weight to 1 so it runs after system/other status-report alterers.
- `hook_page_attachments()` — only on route `system.status`; injects an inline `<style>` setting `background-image` for `#contribute-info-account/-membership/-contribution` from the account image, membership badge, and the bundled `images/icons/drupal.svg`.
- `hook_theme()` → `contribute_status_report_community_info` with variables `account`, `membership`, `contribution`; template `templates/contribute-status-report-community-info.html.twig`, styled by library `contribute/contribute-status-report-community-info` (CSS only).

## Block plugin `community_information_block`
`Plugin/Block/CommunityInformationBlock` (attribute `#[Block]`, admin label "Community Information block", category "Community Information Block"). `build()` renders the same theme hook when `getStatus()` is true, calling `getAccount(FALSE)` (no Configure link) plus membership/contribution. Place via Block layout to show the section outside the status report.
