<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Preferences provides a front-end block where end users tick taxonomy terms they care about; the selected term IDs are stored in `$_SESSION` (joined with `+`) so a View can use them as a contextual/session-based filter (designed to pair with Views Extender / Views Extra).

---

The problem it solves is lightweight, login-optional content personalization: an administrator chooses on the settings page (`/admin/config/system/taxonomy_preferences`, `Settings.php`) which taxonomy terms are offered and an optional user message; the block form (`TaxonomyPreferencesForm`) renders those terms as checkboxes, and on submit writes `$_SESSION['taxonomy_preferences']['preferences_key']` (a `+`-joined term-id string) and a `visibility` flag. Because storage is session-based, preferences persist for the browser session without writing to the database. Term labels and the user message are rendered translated via `locale`/`config_translation` in the current content language.

Operational/security notes: the block form route `/taxonomy_preferences` is gated only by the core `access content` permission, i.e. effectively available to anonymous users — appropriate here because the "mutation" is limited to the visitor's own session (their preference selection), not server-side state. The admin `user_message` is rendered as raw `#markup`, so it is trusted admin config (config-translation editors can set it). The module provides two permissions (`access taxonomy preferences settings`, `access taxonomy preferences block`) though the settings route uses the former. Typical setup: pick terms on the settings page, place the Taxonomy Preferences block, then add a session-based contextual filter to a View consuming `$_SESSION['taxonomy_preferences']['preferences_key']`.
---
- Let visitors choose topic terms to personalize a content listing.
- Configure which taxonomy terms are offered on the settings page.
- Set a custom instruction message shown above the checkboxes.
- Translate the offered term labels via config translation.
- Translate the user message per language via config translation.
- Place the preferences block in a sidebar region.
- Store selected term IDs in the visitor's session for later filtering.
- Feed the `+`-joined term IDs into a Views contextual filter.
- Personalize content for anonymous visitors without an account.
- Require at least one term selection via built-in form validation.
- Grant `access taxonomy preferences settings` to configure the module.
- Grant `access taxonomy preferences block` to control block visibility.
- Redirect to the front page after submission when on the front page.
- Combine with Views Extender to read session preferences as arguments.
- Reset a visitor's preferences by resubmitting the block form.
- Show a preferences form only to users with the block permission.
- Use the visibility session flag to conditionally render content.
- Offer a curated subset of a large vocabulary to end users.
- Drive a "recommended for you" block from session preferences.
