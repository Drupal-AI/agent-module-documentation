<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON-LD generation, content model, hooks, Indexing API & REST

All logic lives in `.module` (hooks) and `src/Utils/JobPostingUtils.php` (service
`civic_job_posting.indexing`; args `@logger.factory`, `@current_route_match`, `@file_url_generator`,
`@entity.repository`, `@config.factory`).

## Content model (config/install/)

- Node type **`job`** (`node.type.job.yml`; also depends on `menu_ui`), Paragraph type
  **`job_location`** (`paragraphs.paragraphs_type.job_location.yml`).
- Job node fields: `body`, `field_job_employment_type`, `field_job_base_salary_currency`,
  `field_job_salary_base_value` / `_min_value` / `_max_value`, `field_job_salary_unit`,
  `field_job_organization_name` / `_url` / `_logo` (image), `field_job_identifier` (+ `_value`),
  `field_job_expiry_date`, `field_job_starting_date`, `field_is_this_work_remotely`,
  `field_job_applicant_remote_count` (comma-separated country list), `field_job_apply_email`,
  `field_job_apply_url`, `field_job_location_group` (entity-reference-revisions to
  `job_location` paragraphs).
- `job_location` paragraph fields: `field_job_street_address`, `field_job_locality`,
  `field_job_region`, `field_job_postal_code`, `field_job_country_code`.
- View **`job_view`** (`views.view.job_view.yml`): page display at **`admin/job`** plus a
  "Jobs View Block".

## JSON-LD emission

- `civic_job_posting_page_attachments_alter()` (`.module`): on a route where the `node` param is a
  published `job` node **and** the route is `entity.node.canonical`, it appends an
  `#type => 'html_tag'`, `#tag => 'script'`, `#attributes => ['type' => 'application/ld+json']`
  render element to `#attached['html_head']`, with `#value` = the string returned by
  `JobPostingUtils::jobPostingValues()`.
- It also always appends a `<meta name="google-site-verification">` tag whose `content` is
  `civic_job_posting.settings:google_site_verification`.
- `JobPostingUtils::jobPostingValues()` reads the current `node` from the route match, pulls the
  fields above, and assembles a `schema.org/JobPosting` array: `title`, `datePosted`,
  `description` (raw `body` value), `validThrough`, `employmentType` (comma-joined multi-value),
  `hiringOrganization` (Organization with `name`/`sameAs`/`logo`; logo resolved to an absolute URL
  via `file_url_generator`, falling back to the field's `default_image`), `jobLocation` (Place →
  PostalAddress per `job_location` paragraph, loaded with `Paragraph::load()`),
  `applicantLocationRequirements` (Country list from the comma-split remote-count field),
  `jobLocationType => 'TELECOMMUTE'`, `identifier` (PropertyValue), and `baseSalary`
  (MonetaryAmount → QuantitativeValue value/min/max/unit).
- The array is serialized with **`Drupal\Component\Serialization\Json::encode()`**. Note the call
  passes `JSON_PRETTY_PRINT` as a 2nd arg, but core's `Json::encode()` takes only one argument, so
  that flag is ignored; the encoder always applies `JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_AMP|
  JSON_HEX_QUOT`, i.e. it hex-encodes `< > & ' "` — the intended, safe encoder for embedding JSON
  inside a `<script>` tag.

## Node hooks → Google Indexing API

`hook_node_insert` / `hook_node_update` / `hook_node_delete` (`.module`) only act when the node is a
`job` and `civic_job_posting.settings:enableIndexing` is truthy, each wrapped in `try/catch` that
logs `\Throwable` to the `civic_job_posting` logger:

- insert/update: `URL_UPDATED` if published, else `URL_DELETED`, then `jobPostingGetIndexingApi()`.
- delete: `URL_DELETED`, then `jobPostingGetIndexingApi()`.

In `JobPostingUtils`:
- `jobPostingCallIndexingApi($id, $type)` POSTs `{"url": <job url>, "type": <type>}` to
  `END_POINT = https://indexing.googleapis.com/v3/urlNotifications:publish`; logs success or the
  API error message.
- `jobPostingGetIndexingApi($id)` GETs
  `https://indexing.googleapis.com/v3/urlNotifications/metadata?url=<job url>` and logs the result.
- `jobPostingJobUrl($id)` builds the URL from `Url::fromRoute('entity.node.canonical', ...)` —
  the notified URL is the site's own canonical node URL (not request/config supplied).
- `jobPostingGoogleAuthorize()` builds a `Google_Client` (from **google/apiclient**),
  `setAuthConfig()` from the service-account values in `jobPostingJsonFile()`, adds scope
  `https://www.googleapis.com/auth/indexing`, and returns an authorized Guzzle client. TLS is
  handled by the Google client's defaults.

## REST endpoints (`Controller\JobPostingControllerJson`)

Three GET routes, all `requirements: _access: 'TRUE'` (public, read-only). Each loads a field's
`allowed_values` setting via `FieldConfig::loadByName('node','job', <field>)` and returns it as a
`JsonResponse`:

- `job.posting_job_currency` → `/rest/salary-currency` → `field_job_base_salary_currency` options.
- `job.posting_job_salary_unit` → `/rest/salary-unit` → `field_job_salary_unit` options.
- `job.posting_job_employment_type` → `/rest/employment-type` → `field_job_employment_type` options.

These expose only the static allowed-value option lists of those fields (currency codes, salary
units, employment-type enum) for front-end use — no node data, no config secrets.

## Assets

Library `civic_job_posting/civic_job_posting` (`js/job_posting.js`) attaches globally but defines an
empty `Drupal.behaviors.jobPosting`. Library `civic_job_posting/job_posting_form` powers the
settings form's JSON-file import (see [../config/settings.md](../config/settings.md)).
