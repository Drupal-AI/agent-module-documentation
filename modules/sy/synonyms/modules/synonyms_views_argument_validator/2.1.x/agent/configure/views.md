# Use the synonyms argument validator in a View

No admin form of its own — configure it inside a View.

1. Edit a View, add or open a **contextual filter** on the target entity (e.g. the term/node/user id).
2. Under **"When the filter value IS in the URL or a default is provided"**, set
   **Specify validation criteria** and choose the **"Synonyms …"** validator for that entity type
   (plugin `synonyms_entity`).
3. Options:
   - Standard core Entity-validator options: allowed **bundles** and access.
   - **Transform dashes in URL to spaces** (`transform`, default off) — turn `some-name` into `some name`
     before matching, for clean-URL arguments.
4. Set the filter's action for an invalid argument as usual (e.g. hide the View / show 404).

At request time the validator matches the argument against the entity label first, then against
synonyms (`synonyms.provider_service->findSynonyms()`), and on success replaces the argument with the
resolved entity id so downstream Views handlers work unchanged. Requires a Synonym provider configured
for the entity type/bundle to match on synonyms.
