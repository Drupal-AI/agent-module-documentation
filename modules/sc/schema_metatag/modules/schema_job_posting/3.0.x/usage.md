Adds a Schema.org `JobPosting` group to Metatag, outputting JSON-LD for job listings so they qualify for Google Jobs.

---

A companion submodule of Schema.org Metatag. It registers a Metatag group `schema_job_posting` with a Tag plugin per JobPosting property, extending `SchemaNameBase`; the hiring organization is expressed using Organization structured data, so it depends on `schema_organization`. Enable it and the JobPosting tags appear under the site's Metatag configuration, populated from content via tokens. On render, Schema.org Metatag emits them in the page's `application/ld+json` script. Aimed at job boards, HR sites and career pages that want inclusion in the Google Jobs experience. Requires `schema_metatag` and `schema_organization`.

---

- Add `JobPosting` JSON-LD to job listing pages.
- Set the job `title`.
- Provide a `description` of the role.
- Record `datePosted` and `validThrough`.
- Declare `employmentType` (full-time, contract, …).
- Name the `hiringOrganization`.
- Set the `jobLocation`.
- Add `baseSalary` with currency and unit.
- List `jobBenefits`.
- State `qualifications` and `responsibilities`.
- Categorise via `industry` / `occupationalCategory`.
- Provide an `identifier` for the posting.
- Set a stable `@id`.
- Power job boards and career pages.
- Improve eligibility for the Google Jobs experience.
- Configure per content type, override per node.
- Validate output in Google's Rich Results Test.
