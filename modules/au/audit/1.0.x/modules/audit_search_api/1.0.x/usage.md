Audit analyzer that scores the health of Search API servers and indexes.

---

audit_search_api registers the `search_api` AuditAnalyzer plugin (SearchApiAnalyzer) and hard-depends on the contrib Search API module. It inspects each configured Search API server (backend availability/reachability) and index (enabled/read-only state, tracked vs indexed item counts, pending items) and produces two scored sections — Servers and Indexes — surfacing unreachable servers, disabled or stale indexes, and indexing backlogs. Ships no config of its own.

---

- Verify all Search API servers are enabled and their backends reachable.
- Detect indexes that are disabled, read-only or misconfigured.
- Spot indexing backlogs (tracked items far exceeding indexed items).
- Score search infrastructure health as part of the overall Project Score.
- Catch a search server that silently went offline in production.
- Confirm each index is attached to a valid server.
- Review index item counts and tracker status at a glance.
- Include search health in a takeover audit of an unfamiliar site.
- Run headless via `drush audit:run search_api --format=json`.
- Monitor search health across a portfolio via DruScan.
- Identify indexes needing a re-index after a content model change.
- Fail a deploy check when a required index is disabled.
- Provide search-ops visibility without granting full Search API admin.
- Surface remediation guidance for each failing server/index.
- Skip gracefully with a requirement warning when search_api is absent.
