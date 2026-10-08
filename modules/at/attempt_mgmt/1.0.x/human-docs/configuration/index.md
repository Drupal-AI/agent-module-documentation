# Configuration

Attempt Management is a building block, so "configuring" it means two things:
defining the **attempt types** you need and attaching the **attempts field** to the
entities that should carry them. There is also a small settings form.

## Define attempt types

An *attempt type* describes a kind of attempt — what it means and what it stores.

1. Log in as a user with the **Administer attempt_mgmt attempt types** permission.
2. Go to **Structure → Attempt types**
   (`/admin/structure/attempt_mgmt_attempt_types`) and choose **Add attempt type**
   (`/admin/structure/attempt_mgmt_attempt_types/add`).
3. Give the type a label and configure its fields, then save. Create as many types
   as your use cases need (for example one for quiz attempts, one for SCORM
   attempts).

## Attach the attempts field

To let an entity record attempts, add the module's **attempts field** to that
entity's bundle (for example a content type) via its **Manage fields** screen, the
same way you add any other field. Once attached, that entity can carry per‑user
attempt records.

## Module settings

A settings form sits at **Configuration → System → Attempt Management settings**
(`/admin/config/system/attempt-management/settings`), gated by the *administer site
configuration* permission. Adjust the module‑level options exposed there as needed.

## Permissions

- **Administer attempt_mgmt attempt types** — create and manage attempt types.
  Grant this only to trusted administrators at **People → Permissions**.
- The settings form itself is gated by the core *administer site configuration*
  permission.

## Driving it

Attempt Management does not create attempts on its own. A driving feature does that
— for example the `scorm_field` module records SCORM completion/score as attempts,
or your own code can create them through the `AttemptFactory` service. Attempts are
then listed through the module's list builders.
