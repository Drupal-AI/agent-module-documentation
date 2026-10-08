<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Data Policy publishes a privacy/data-protection statement as a versioned entity, forces users to agree to the current version, and records who agreed to which revision and when; a submodule exports those consent records to CSV.

---

GDPR treats consent as something that must be **demonstrable** — not "the policy was on the site" but "this person agreed to this text on this date". A static page and a boolean checkbox cannot show that, so this module models the whole flow. The statement is a revisionable `data_policy` content entity (its text lives in a `field_description` text field); an admin references one or more of these entities from a free-text **consent text** (settings form) using `[id:N]` tokens, where `[id:N*]` marks a policy as **required**. A `RedirectSubscriber` runs on every non-AJAX request at priority 28: if a required policy exists and the current user has not agreed to its active revision, they are redirected to `/data-policy-agreement`; if they refuse a required policy the agreement form sends them to the account-cancellation page. Each decision is written as a `user_consent` content entity (owner, `data_policy_revision_id`, and a `state` of undecided/not-agree/agree), and publishing a new revision re-prompts everyone. The consent checkbox is also injected into user registration. Users with the **`without consent`** permission are exempt, and `simple_oauth` token-authenticated (decoupled/API) requests are skipped entirely. The `data_policy_export` submodule adds a Views Bulk Operations action on the *Data policy agreements* report (`/admin/reports/data-policy-agreements`, gated by `overview user consents`) that writes selected consent rows to a private CSV, downloadable only by the file's owner or a user with `administer users`. It comes from the Open Social ecosystem. Version **2.0.9** on core `^10.2 || ^11`, depending on core `block` and `path_alias`. **Operational defect to know before installing:** `DataPolicyServiceProvider` swaps the core `module_installer` service class and appends `entity_type.manager` + `config.factory` arguments, producing a **circular reference** — reproduced on Drupal 11.4.x, where `\Drupal::service('module_installer')` throws `ServiceCircularReferenceException` and all `drush pm:*` commands vanish. The site keeps serving pages, but **no module can be installed or uninstalled while data_policy is enabled** (including data_policy itself); recovery is a manual edit of `core.extension`.

---

- Publish a versioned privacy / data-protection statement.
- Force users to accept the latest policy before using the site.
- Record who agreed to which policy revision, and when.
- Demonstrate consent for a GDPR audit.
- Re-prompt every user automatically when the policy changes.
- Require agreement at user registration.
- Run several separate policies at once with per-policy required/optional flags.
- Redirect a refusing user to account cancellation.
- Export selected consent records to a private CSV (subject access request).
- Show an "inform" pop-up explaining data use on specific pages.
- Exempt trusted roles from consent via the `without consent` permission.
- Track agreement dates per user for a compliance trail.
- Maintain an auditable, per-revision consent history.
- Enforce terms-of-use acceptance for a community or membership site.
- Keep a decoupled front end responsible for its own consent gate (API requests are skipped).
- Localise the policy text (the entity is translatable).
- Let editors revert or view earlier policy revisions.
- Answer "prove this member consented" for a regulator.
- Place a summarised data-policy block in a region.
- Support an Open Social distribution's compliance obligations.
