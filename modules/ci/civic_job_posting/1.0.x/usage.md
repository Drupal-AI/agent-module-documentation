Civic Job Posting ships a ready-made "Job" content type and emits schema.org JobPosting JSON-LD on each job page, with optional Google Indexing API notifications.

---

The module installs a `job` node type (plus a `job_location` Paragraph type) whose fields mirror the schema.org/JobPosting vocabulary: title, description/body, employment type, salary, organization, identifier, expiry/start dates, remote-work flags and one or more structured locations. On the canonical page of a published job node, `hook_page_attachments_alter()` builds a JobPosting JSON-LD object from those fields and injects it as a `<script type="application/ld+json">` tag in the head, making the posting eligible for Google's job rich result. A settings form (Configuration -> Web Services -> Job Posting Settings) stores a Google site-verification code and a Google service-account credential; when "Enable Google Indexing" is on, node insert/update/delete hooks call the Google Indexing API (`urlNotifications:publish`) to notify Google of new, changed or removed job URLs. Three public JSON REST endpoints expose the allowed-values lists of the currency, salary-unit and employment-type fields for front-end use. Requires the paragraphs and field_group contrib modules; built on core node, field, views and serialization.

---

- Add a job-listings section to a Drupal site with a purpose-built "Job" content type instead of hand-building fields.
- Make job postings eligible for Google's job-search rich result via schema.org/JobPosting structured data.
- Automatically emit JSON-LD structured data on every published job page with no per-node configuration.
- Capture structured salary data (base value, min, max, currency, unit) that maps to schema.org MonetaryAmount/QuantitativeValue.
- Record one or more physical job locations as `job_location` Paragraphs (street, locality, region, postal code, country).
- Mark a job as remote (`TELECOMMUTE`) and list the countries applicants may work from (`applicantLocationRequirements`).
- Store the hiring organization's name, website and logo and surface them as a schema.org Organization.
- Set job posting date, expiry date (`validThrough`) and starting date on each listing.
- Attach a job identifier name/value pair (schema.org PropertyValue) for ATS or requisition IDs.
- Capture apply-by email and apply URL fields on each job node.
- Notify Google's Indexing API automatically when a job node is published, updated or unpublished/deleted.
- Add a Google site-verification meta tag site-wide from the settings form.
- Import Google service-account credentials by uploading the downloaded JSON key file, or paste each value manually.
- Disable the Indexing integration and rely on a sitemap or another SEO module instead, avoiding conflicts.
- Provide an admin job-listing page (view `job_view` at `/admin/job`) and a reusable Jobs block for theming.
- Consume the `/rest/salary-currency`, `/rest/salary-unit` and `/rest/employment-type` endpoints from custom front-end code to build filters or forms.
- Seed a recruitment or careers site quickly with a standards-aligned job schema.
- Give SEO teams schema.org-compliant job markup without writing template code.
- Support multiple employment types per job (e.g. FULL_TIME, PART_TIME) rendered as a comma-separated `employmentType`.
- Serve as a starting template that can be extended with additional fields or a custom apply workflow.
