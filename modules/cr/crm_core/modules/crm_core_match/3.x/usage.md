CRM Core Match is a framework for identifying duplicate CRM Core contacts using configurable, pluggable matching engines.

---

CRM Core Match adds a `crm_core_match` config entity (a "Matcher") whose behaviour is provided by a
**matching-engine plugin**. It ships one engine — the **Default Matching Engine** — which scores a
candidate contact field-by-field against existing Individual contacts and returns those whose total
score meets or exceeds a configured **threshold**. Per-field-type **field handler** plugins
(name, email, telephone, phone number, address, date, integer, string, text, select) know how to
query and score each field type; the operator and score are configured per field in the matcher
form. Matchers are administered at `/admin/config/crm-core/match`; the framework is meant to be
called from contact-creation flows (e.g. CRM Core Profile) to surface potential duplicates. Default
matcher config for `individual`, `organization` and `household` types is installed. The module is
intended to be paired with a matching engine — without one it does nothing.

---

- Detect **duplicate contacts** before or as they are created.
- Configure a **Matcher** per contact type (`crm_core_match.matcher.*` config entities).
- Use the shipped **Default Matching Engine** for field-scored matching.
- Set a numeric **threshold** above which a candidate is treated as a match.
- Choose a **return order** for ties (most recently created / updated / associated with a user).
- Enable **strict** mode to stop at the first qualifying match.
- Configure matching **per field**: enable, operator, options, score and weight.
- Match on **name, email, telephone, phone number, address, date, integer, string, text, select**
  fields via the bundled field-handler plugins.
- See **unsupported fields** (types with no handler) called out in the matcher form.
- Order candidate matches by total score so the best match is first.
- Manage matchers from the admin UI at `/admin/config/crm-core/match`.
- Gate access with `administer matchers`, `view matching engine rules settings`,
  `view match information` permissions.
- Extend the system with custom **matching engines** (`@CrmCoreMatchEngine`).
- Extend it with custom **field handlers** (`@CrmCoreMatchFieldHandler`) for new field types.
- Feed match results into contact-creation UIs such as CRM Core Profile.
- Inject data into contact records during matching (as an engine responsibility).
