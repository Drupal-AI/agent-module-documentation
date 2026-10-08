# Configuration

Configuring Data Policy is about four things: writing the policy, deciding whether
users must agree to it, controlling who can see the consent records, and (if you
want) showing an inform block that tells users what data you collect. Because the
records are **personal data**, treat the permissions here as a privacy control, not
an afterthought.

## 1. Create and publish the policy

Create the data policy from the module's Data Policy screens. The policy is stored
as a **versioned (revisioned) entity**, so:

- Write the current policy text and save it as the active revision.
- When your policy changes, publish a **new revision** rather than overwriting the
  old one — the module keeps the history, which is what makes consent
  demonstrable over time.

## 2. Enforce agreement

Turn on the setting that prompts users to accept the **latest active** data policy.
With this on, any user who has not yet agreed to the current revision is asked to
do so, and is re‑prompted whenever you publish a new revision. Each acceptance is
recorded per user, per revision, with a timestamp — that record is the auditable
consent trail.

## 3. Set permissions

Data Policy provides its own permissions. On **People → Permissions**, decide
carefully who can:

- administer the policy and its revisions,
- view the consent/agreement records (these identify individuals and what they
  agreed to — personal data), and
- export those records, if you enabled the **Data Policy Export** submodule.

Keep viewing and exporting restricted to the roles that genuinely need them, and
remember the records themselves are subject to the same data‑protection obligations
as any other PII you hold.

## 4. Show the inform block

The module also provides **inform blocks** — small blocks that tell users which
data is collected. Manage them from the inform blocks collection
(`entity.informblock.collection`, the module's configure link) and place the block
via **Structure → Block layout** where you want users to see the notice.

## Subject access requests

If you enabled **Data Policy Export** (`data_policy_export`), you can produce an
individual user's consent record on demand — the "this person agreed to this text
on this date" evidence a GDPR subject access request asks for. Restrict who can run
that export to the roles responsible for handling such requests.
