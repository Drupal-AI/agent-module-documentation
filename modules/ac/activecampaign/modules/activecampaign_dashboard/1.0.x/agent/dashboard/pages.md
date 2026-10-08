<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard pages

## Install

`drush en activecampaign_dashboard` (enables base `activecampaign` too). Configure credentials at
`/admin/config/services/activecampaign` first, or every page will show an API error.

## Permission & routes

Permission `access activecampaign dashboard` (`activecampaign_dashboard.permissions.yml`) gates all
routes (`activecampaign_dashboard.routing.yml`):

| route | path | target |
|---|---|---|
| `activecampaign.dashboard` | `/admin/activecampaign` | core `SystemController::systemAdminMenuBlockPage` (menu landing) |
| `activecampaign.dashboard.contacts` | `/admin/activecampaign/contacts` | `Form\ActiveCampaignContacts` |
| `activecampaign.dashboard.lists` | `/admin/activecampaign/lists` | `Form\ActiveCampaignLists` |
| `activecampaign.dashboard.campaigns` | `/admin/activecampaign/campaigns` | `Form\ActiveCampaignCampaigns` |

Menu links (`.links.menu.yml`) put the section + three children under `system.admin`; local tasks
(`.links.task.yml`) expose the three pages as tabs (base_route `activecampaign.dashboard.campaigns`).

## Base class

`Form\ActiveCampaignDashboard extends FormBase` (`src/Form/ActiveCampaignDashboard.php`). `create()`
injects `activecampaign.api`, `pager.manager`, `pager.parameters`. `buildForm()`:
1. `$page = pagerParameters->findPage()`, `$limit = 20`.
2. `$data = $this->getTableData($page, $limit)`.
3. builds `#type => table` with `#header => $data['table_fields']`, `#rows => $data['rows']`, and
   `pagerManager->createPager($data['total'], 20)` + a `#type => pager`.

The base `getTableData()` returns empty arrays; each page overrides it. `getFormId()` =
`activecampaign_dashboard`; `submitForm()` is empty (read-only).

## The three pages (each overrides `getTableData()`)

- **`ActiveCampaignContacts`** — `api->getContacts([], $page, $limit)`. Header Email / First Name /
  Last Name / Created. Email cell = `Link::fromTextAndUrl($contact->email, api->createUrlToContact($contact->id))`.
- **`ActiveCampaignCampaigns`** — `api->getCampaigns(...)`. Header Name / Date send / Emails send /
  Open / Click / Bounce / Unsubscribe rate. Name cell links via `api->createUrlToCampaign()`. Rates
  come from `convertToRate($amount, $send_amt)` (`round(($amount/$total)*100,2).'%'`, or `-` when
  total is 0).
- **`ActiveCampaignLists`** — `api->getLists(...)`. Header Name / Subscribers / Active Subscribers.
  Name cell links to the list's own `$list->url`.

Each iterates `$response->rows` keeping only numeric keys (skips API metadata rows) and sets
`$data['total'] = $response->total`. If the API returns a **string** (error), it is shown with
`messenger()->addError($response)` and no rows are built.

## Assets

Library `activecampaign_dashboard/admin_menu` → `css/admin-menu.css`; `images/activecampaign.svg`.
