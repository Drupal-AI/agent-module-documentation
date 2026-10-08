# Configuration

Setting up Consent Management is a matter of defining the policies you want users
to agree to, deciding how the consent prompt is shown, and controlling who can see
the resulting consent records.

## Who can configure it

The module provides its own permissions and gates its admin functions behind them.
Before configuring, go to **People → Permissions** (`/admin/people/permissions`)
and grant the consent‑management permissions only to the roles that should manage
policies and view consent — this data is sensitive.

## Create your data policies

The core task is to create one or more **policies** at **Administration → People →
Policies** (`/admin/config/people/cm-policy`). A policy is a container; the actual
policy text lives on a **policy version** you add underneath it. Each policy can be
marked **required**, limited to selected **user roles**, and given a **consent
formula** — the checkbox label shown on the agreement page, where the token
`[policy:link]` is replaced by a link that opens the policy text in a modal
dialog (the default is `I agree to [policy:link]`). Because the text lives on the
version, updating the policy means adding a new version, and the module can then
tell consent to the old version apart from consent to the new one.

## How the consent prompt is shown

You do **not** place a block. When an **authenticated** user who has not yet agreed
to a current required policy visits any page, the module automatically redirects
them to the agreement page at **`/policy-agreement`**, which lists a checkbox for
each active policy version. Anonymous visitors are never prompted, and users with
the **Bypass any consent** permission are exempt. For non‑required new versions the
module shows a status message linking to the agreement page instead of forcing a
redirect. (The module's `block` and `path_alias` dependencies are declared for
core plumbing — you do not have to configure a block for the prompt to appear.)

## Re‑prompting on policy changes

When a policy's version changes, the module can re‑prompt users who had only
consented to an earlier version, so their recorded consent stays current. Update
the policy when its terms change rather than editing in place silently, so the
version history — and therefore the audit trail — stays meaningful.

## Reviewing and protecting consent records

Each agreement is stored as a **consent record** tied to a user and a policy
version — this is your compliance artifact. Treat it accordingly:

- Restrict who can view or export consent records to the roles that genuinely need
  it.
- Retain records for only as long as your privacy policy and applicable law
  require, and expose them in line with that policy.
- Keep the records protected — they are personal data.

## Save

Save each policy and block placement as you configure it. Then test as an ordinary
user: you should be prompted to consent, and after agreeing a consent record should
be stored against your account for that policy version.
