# schema_job_posting — agent start

Submodule of [schema_metatag] (also depends on `schema_organization`). Adds a Metatag group
`schema_job_posting` (`@type` JobPosting) with Tag plugins for JobPosting properties (title,
description, datePosted, validThrough, employmentType, hiringOrganization, jobLocation,
baseSalary, jobBenefits, qualifications, responsibilities, industry, occupationalCategory,
identifier, @id). Configure the tags with tokens under the site's **Metatag** settings; values
render as JSON-LD via schema_metatag. No config UI of its own.
