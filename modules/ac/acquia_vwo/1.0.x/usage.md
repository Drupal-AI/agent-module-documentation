<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia VWO integrates VWO (Visual Website Optimizer) with enhanced data capture, so A/B and multivariate experiments can segment on Drupal's own content metadata.

---

A/B testing tools see a page; they do not see that it is an Article in the Pricing section tagged for a particular audience. Acquia VWO closes that gap by injecting the VWO **smart code** into the page head and, alongside it, a `window.VWO.data.acquia` payload carrying the current node's Drupal metadata — content type, title and taxonomy-term names read from fields you map — hence the `node` and `taxonomy` dependencies. Install it, then at **`/admin/config/system/acquia_vwo`** enter your numeric VWO **account id** (the *Extract Account ID* tab will parse it out of a pasted VWO smart-code block for you) and set the load **timeout**. The **Visibility** tab decides where the script loads: leave it on every page, or switch to *Customize* and add `request_path`, `user_role` or node-`entity_bundle` conditions (combined with AND). The **Field Mapping** tab maps up to three segments (`content_section`, `content_keywords`, `persona`) to node entity-reference→taxonomy fields. You can also let individual users **opt in or out** of testing from their user profile (Visibility → user control `optin`/`optout`). VWO is a third-party script that modifies pages client-side and sets bucketing cookies, so treat the vendor account as part of your deployment and gate the cookies behind consent on EU-facing sites (e.g. `usercentrics`, `consent_mode`). Requires a VWO account (a free trial is available); the script is skipped on admin routes and is not attached until an account id is set.

---

- Run an A/B, split or multivariate test on a Drupal site.
- Inject the VWO smart code without editing templates.
- Enter the VWO account id and load timeout.
- Extract the account id from a pasted VWO smart-code block.
- Pass Drupal content metadata (type, title, taxonomy) to VWO.
- Segment experiments by content type.
- Segment by taxonomy term (content section, keywords, persona).
- Map node taxonomy fields to VWO segments.
- Report experiment results by content section.
- Restrict which pages load the VWO script.
- Load the script only on selected paths, roles or node bundles.
- Combine visibility conditions with boolean AND.
- Let individual users opt in or out of testing from their profile.
- Avoid loading the script site-wide.
- Test a pricing-page variant before rolling it out.
- Gate the VWO cookies behind a consent manager.
- Document VWO cookies in a privacy notice.
- Restrict who may configure VWO to trusted administrators.
- Keep the script off admin pages automatically.
- Disable testing simply by clearing the account id.
