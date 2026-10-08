# schema_qa_page — agent start

Submodule of **schema_metatag**. Adds **Schema.org/QAPage and FAQPage** structured data as Metatag *Tag*
plugins in the `schema_qa_page` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: @type (QAPage or FAQPage), mainEntity (nested Question/acceptedAnswer or FAQ items), @id.
- Use for FAQ landing pages and community Q&A threads seeking FAQ/Q&A rich results.
