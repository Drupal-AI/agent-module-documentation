<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Solr Schema Check verifies that the schema a Solr server is actually running matches a canonical schema you define — for example the one committed to your git repository.

---

Solr integration has a failure mode that is quiet and expensive: schema drift. Search API Solr generates a schema, someone deploys it to the Solr server, and then over time the two diverge — a config change that was never pushed, a manual edit on the Solr side, a server rebuilt from an older schema. Search keeps working, results are just subtly wrong, and nobody notices until a field stops being searchable or a boost silently disappears. The gap between "the schema we intend" and "the schema Solr is running" is invisible from Drupal.

This module makes it visible. You define the canonical schema — the source of truth, typically the schema in version control — and it compares each configured Solr server's live schema against it, reporting where they differ. That turns a silent drift into a check you can run on deploy or on a schedule, and read the same way you read a failing test: this server is not running the schema we think it is.

It is a diagnostic, not a fix — it tells you the schemas differ, not how to reconcile them; reconciliation is still deploying the right schema to Solr. And it depends on `search_api_solr`, since it is inspecting that module's servers. For any site where Solr search matters, it is the kind of guardrail that pays for itself the first time it catches a mismatched deploy.

---

- Detect Solr schema drift.
- Verify a server runs the intended schema.
- Compare live Solr schema to a canonical one.
- Catch a schema that was never deployed.
- Catch a manual edit on the Solr side.
- Run a schema check on deploy.
- Run a schema check on a schedule.
- Treat the git schema as the source of truth.
- Turn silent drift into a visible check.
- Diagnose subtly wrong search results.
- Confirm a field is still searchable.
- Guard a Solr deploy pipeline.
- Read schema mismatch like a failing test.
- Inspect each configured Solr server.
- Know when Solr was rebuilt from an old schema.
- Catch a lost boost or field.
- Monitor Solr schema consistency.
- Validate schema after a Solr upgrade.
- Pair with search_api_solr servers.
- Prevent quiet search degradation.