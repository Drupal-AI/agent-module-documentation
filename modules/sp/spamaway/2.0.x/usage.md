SpamAway is a Webform anti-spam module: it adds a Webform handler that blocks submissions which look like spam based on repeated or too-similar posts and repeated posts from the same IP address, with no CAPTCHA required.

---

SpamAway ships a single Webform handler plugin, `spamaway_anti_spam_forms` ("SpamAway - Anti spam handler", category "Anti-SPAM"), which you add to any individual webform under its *Settings → Emails / Handlers*. On submission it validates against two signals: an **IP check** (too many submissions from the same remote address within a time window) and a **similarity check** (the new submission is too similar to recent submissions on the same form). When the webform stores its own results, similarity is measured with PHP's `similar_text()` against a configurable percentage threshold on named fields; when the webform does not store results, SpamAway keeps its own hashed copies of the chosen field values in a custom table (`spamaway_webform_submission`) and compares hashes instead. All tuning is per-handler configuration: which field names to compare (`spamaway_anti_spam_field_names`, supporting `+`-combined fields and the special `ip` field), the similarity threshold percentage, the allowed count of similar posts before rejection, the time periods and allowed counts for the IP check, the hash algorithm, a query limit, and whether the IP check and logging are enabled. If a submission trips a check, the handler sets a form error ("Spam detected…") and the submission is rejected. Users with the `spamaway bypass spam detection` permission — or when the site sets `$settings['spamaway_bypass_anti_spam'] = TRUE` in settings.php — skip all checks. There is no global settings page: SpamAway is configured per webform via the handler, so `configure` is null.

---

- Block repeated identical or near-identical spam submissions to a contact webform.
- Rate-limit submissions from a single IP address on a webform within a time window.
- Stop bot flooding of a "request a quote" form without adding a CAPTCHA.
- Reject a new comment/message that is >80% similar to recent ones on the same form.
- Compare only specific fields (e.g. `message`, `email`) for similarity, ignoring the rest.
- Combine fields for a stricter match (e.g. `name+email` must both repeat) via the `+` separator.
- Include the submitter IP as a matched "field" using the special `ip` token.
- Allow N similar posts before treating further ones as spam (tunable per field).
- Cap how many submissions per IP are allowed within `spamaway_anti_spam_ip_period` seconds.
- Protect webforms that do NOT store submissions by hashing chosen field values into SpamAway's own table.
- Choose the hash algorithm (e.g. `sha256`) used to store field values for comparison.
- Limit how many prior submissions are scanned per check with `spamaway_query_limit` (max 200).
- Let trusted, logged-in staff bypass spam checks via the `spamaway bypass spam detection` permission.
- Globally disable spam checking in a staging/dev environment with `$settings['spamaway_bypass_anti_spam'] = TRUE`.
- Turn the IP-based check on or off independently of the similarity check.
- Log spam-detection events to a dedicated logger channel for tuning thresholds.
- Add anti-spam protection to many webforms by attaching the same handler to each.
- Keep a public feedback form usable while quietly dropping duplicate blasts.
- Reduce moderation load by rejecting obvious duplicate submissions at validation time.
- Defend a newsletter signup form against the same email being submitted repeatedly.
- Apply different similarity thresholds per field using a comma-separated list.
- Automatically prune SpamAway's stored data for a submission when that submission is deleted.
- Provide anti-spam on decoupled/AJAX webform submissions where a CAPTCHA is awkward.
- Tighten protection on high-value forms while leaving low-risk forms unguarded.
