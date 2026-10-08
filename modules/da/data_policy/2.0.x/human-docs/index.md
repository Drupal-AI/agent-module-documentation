# Data Policy — manual setup guide

**Data Policy** (`data_policy`) publishes a data policy or privacy statement as a
*versioned* entity, requires your users to agree to it, and records who agreed to
which version and when. That last part is the whole point: GDPR treats consent as
something you must be able to **demonstrate** — not "the privacy policy was on the
site" but "this person agreed to this exact text on this date". A static policy
page and a plain checkbox cannot prove that; this module keeps an auditable
agreement trail that can.

In practice the module gives you a policy stored as a revisioned entity, an
enforced agreement step that prompts users who have not yet accepted the current
version, and a per‑user, per‑revision record of agreements. When you publish a new
revision of the policy, users are re‑prompted to accept it. An optional submodule,
**Data Policy Export** (`data_policy_export`), produces a user's consent record on
request — which is exactly what a subject access request asks for. The module comes
from the Open Social distribution's ecosystem, where this requirement was felt
first. It depends on core's **Block** and **Path Alias** modules and runs on
Drupal 10.2 and 11.

Because this module handles **user consent and personal data (PII)**, treat its
records as sensitive: they are personal data in their own right, so restrict who
can view and export them and retain them no longer than you need.

> **Important — read before installing.** On a clean Drupal 11 install, enabling
> this module has been observed to **break the `module_installer` service** through
> a circular service reference: `\Drupal::service('module_installer')` throws a
> `ServiceCircularReferenceException`, every `drush pm:*` command disappears, and
> **no module can be installed or uninstalled while Data Policy is enabled —
> including Data Policy itself.** The site keeps serving pages, so the breakage is
> silent until someone tries to install or uninstall something. Recovery is a
> manual edit of `core.extension` to remove `data_policy`, followed by a cache
> rebuild. This has a security dimension too: disabling a module is the normal
> response to a security advisory with no fix, and a site in this state cannot do
> it through normal tooling. Test on a throwaway environment first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally the export submodule), and the caveats to know first.
2. [Configuration](configuration/index.md) — create the policy, enforce agreement,
   set permissions, and show the inform block.

## Where it lives in the admin menu

The module's configure link points at the **inform blocks** collection
(`entity.informblock.collection`) — the small blocks that tell users what data is
collected. From there and the related Data Policy screens you create the policy,
manage its revisions, and review who has agreed. See
[Configuration](configuration/index.md) for the walk‑through.
