# schema_course — agent start

Submodule of [schema_metatag]. Adds a Metatag group `schema_course` (`@type` Course) with Tag
plugins for Course properties (name, description, provider, courseCode, coursePrerequisites,
educationalCredentialAwarded, @id). Configure the tags with tokens under the site's **Metatag**
settings; values render as JSON-LD via schema_metatag. No config UI of its own.
